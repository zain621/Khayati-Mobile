# Khayati Mobile — Full Flow & Push Testing Guide

Production API: `https://api.khayati.ae/api/v1/`  
Admin: [admin.khayati.ae/en/products](https://admin.khayati.ae/en/products)

---

## 1. Demo accounts (ready)

OTP is always **`000000`** (no SMS). Country **+92**.

| Role | National number | Full phone | What to test |
|------|-----------------|------------|--------------|
| Customer | `0000971` | `9710000971` | Zoqak create, offers, shop buy, chat, push receive |
| Independent tailor | `0000972` | `9710000972` | Suggested Zoqak, offers, tracking, chat, push |
| Shop owner | `0000973` | `9710000973` | Catalog, shop orders, stages, push |
| Comprehensive | `0000974` | `9710000974` | Zoqak + catalog + both order types |

Login: open app → phone → OTP `000000` → land on role home.

---

## 2. Seeded marketplace data (live)

| Item | Details |
|------|---------|
| Shops | **Khayati Demo Shop** (shop owner) · **Fatima Atelier** (comprehensive) |
| Categories | Thobe, Abaya, Accessories, Jalabiya |
| Products (5) | Classic White Thobe · Elegant Black Abaya · Leather Belt · Soft Pastel Jalabiya · Cream Silk Abaya |
| Variants | Colors + sizes + stock on each product |
| Providers | Independent + comprehensive accepting Zoqak |

Refresh admin **Products** / mobile **Store** — you should see these 5 products (images may be empty until you upload in admin or app).

Optional full DB seed on VPS (users + zoqak samples + wallets):

```bash
cd /opt/khayati
docker compose exec backend npm run prisma:seed
```

---

## 3. Push prerequisites (do this once per device/role)

1. Install a **release or debug APK** built with Firebase (`khayati-uae`) — not a random unsigned build without `google-services`.
2. Allow **notifications** when the OS prompts.
3. Login as that role → wait ~5s so `POST /notifications/device-token` succeeds.
4. Keep that account’s app **backgrounded or killed** when testing push on another phone/emulator as the other role.

**Best setup:** two physical devices (or one device + one emulator).  
Example: Device A = Customer (`…001`), Device B = Independent (`…002`).

**Foreground:** app open → local-style banner.  
**Background / killed:** system tray FCM.  
**Inbox:** Notifications screen in-app always lists the same events.

---

## 4. Flow checklist (what to do + what push to expect)

### A) Login (all roles)

1. Logout if needed → login with demo phone → OTP `000000`.
2. Confirm correct home (customer / independent / shop / comprehensive).

Push: none required.

---

### B) Ready-made shop purchase + shop-order push

**Customer (`…001`)**

1. Store → open a product → pick color/size → **Add to cart** (app opens **Cart**).
2. Cart → **Continue Shopping** (back) or **Checkout**.
3. Checkout opens the payment WebView (mock Pay / Fail / Cancel). Tap **Pay**.
4. Only after Pay succeeds → “Order placed successfully” → My Orders.
5. Shop owner (`…003`) or comprehensive (`…004`) gets **`SHOP_ORDER_CREATED`** (push + Notifications inbox) → advance shipping stages.
6. Each stage change → Customer gets **`SHOP_ORDER_STATUS_CHANGED`**.
7. Chat: shop order detail sheet → Chat (shop owner ↔ customer).

---

### C) Zoqak custom order + offer pushes (main push path)

**Customer (`…001`)**

1. Create order (Zoqak / Your Choice): name, fabric, min/max budget, date, photos → publish.
2. Stay logged in (or background app).

**Independent (`…002`) and/or Comprehensive (`…004`)**

1. Push / inbox: **`ZOQAK_ORDER_CREATED`** → Suggested requests.
2. Open request → submit offer (price, days, notes).
3. Provider may see **`ZOQAK_OFFER_CREATED`** (confirmation).

**Customer**

1. Push: **`ZOQAK_OFFER_RECEIVED`** → Submitted offers.
2. Accept one offer (and pay if the flow requires payment).

**Winning tailor**

1. Push: **`ZOQAK_OFFER_ACCEPTED`** → tracking / order detail.

**Customer**

1. Push: **`ZOQAK_OFFER_ACCEPT_CONFIRMATION`**.

**Tailor** advances Zoqak stages (accepted → in progress → ready → ready for delivery → completed).

**Customer**

1. Push: **`ZOQAK_ORDER_STATUS_CHANGED`** on each meaningful stage change.

---

### D) Chat push

1. Open the order conversation (customer ↔ tailor/shop).
2. Send a message from Device A while Device B is backgrounded.
3. Device B: **`CHAT_MESSAGE_RECEIVED`** push → opens chat on tap.

---

### E) Shop catalog management (seller)

**Shop owner (`…003`)** or **Comprehensive (`…004`)**

1. Manage products → see seeded items → edit price/stock/status.
2. Optionally add a 6th product from the app to confirm create works end-to-end.

---

### F) Wallet / withdraw (providers)

1. Wallet → balance / transactions → bank account → request withdraw.
2. Admin must approve (admin dashboard) — no mobile FCM for admin alerts.

---

### G) Logout

1. Logout → session cleared → login screen.
2. Device token should unregister (`DELETE /device-token`).

---

## 5. Quick “does push work?” smoke test (10 minutes)

| Step | Who | Action | Expect |
|------|-----|--------|--------|
| 1 | Customer on Device A | Login; allow notifications | Token registered |
| 2 | Independent on Device B | Login; allow notifications; leave app in background | Token registered |
| 3 | Customer | Publish a new Zoqak request | Device B tray: new Zoqak request |
| 4 | Independent | Submit offer | Device A tray: new offer |
| 5 | Customer | Accept offer | Device B tray: offer accepted |
| 6 | Either | Send chat message | Other device tray: new message |

If inbox updates but **no tray notification**: check OS permission, battery optimization, and that backend logs show `Firebase Admin initialized for FCM push`.

---

## 6. Admin portal checks

1. [Products](https://admin.khayati.ae/en/products) → 5 products (Clear Filters if empty).
2. Shops → Khayati Demo Shop / Fatima Atelier.
3. Orders / Your Choice → after mobile tests, new rows appear.
4. Optional: upload product images for nicer Store UI.

---

## 7. APK build note

If `flutter build apk` fails with **core library desugaring**, `android/app/build.gradle` already enables:

- `coreLibraryDesugaringEnabled = true`
- `coreLibraryDesugaring "com.android.tools:desugar_jdk_libs:2.1.4"`

Then:

```powershell
cd E:\Khayati\khayati-mobile
flutter clean
flutter pub get
flutter build apk
```

---

## 8. Notification type reference

See [NOTIFICATIONS.md](./NOTIFICATIONS.md) for full type → screen mapping.
