# Khayati Push & In-App Notifications

## End-to-end testing

For demo accounts, seeded catalog, and step-by-step flow + push checks, see **[MOBILE_TESTING_GUIDE.md](./MOBILE_TESTING_GUIDE.md)**.

## Firebase project

Configured Flutter app against **`khayati-uae`** (same project as the Admin SDK key).

Mobile + backend must stay on the **same** Firebase project for FCM to work.

## Backend setup (required for real push)

1. Firebase Console → Project settings → Service accounts → **Generate new private key**
2. Save as `Khayati-backend/firebase-service-account.json` (do not commit)
3. In backend `.env`:

```env
FIREBASE_PROJECT_ID=khayati-uae
FIREBASE_SERVICE_ACCOUNT_PATH=./firebase-service-account.json
```

4. Apply DB migration for device tokens:

```bash
cd Khayati-backend
npx prisma migrate dev --name add_device_tokens
# or on VPS: npx prisma migrate deploy
```

## Mobile behaviour

- On app start: Firebase init + permission request + local notification channel
- After login / OTP / register / splash (if logged in): register FCM token via `POST /api/v1/notifications/device-token`
- On logout / delete account: `DELETE /api/v1/notifications/device-token`
- Foreground: show system-style local notification
- Background / killed: FCM system tray; tap opens role-aware screen
- In-app inbox (`GET /notifications/my`) still works; tap deep-links the same way

## Notification types & use cases

| Type | Who gets it | When | Tap opens |
|------|-------------|------|-----------|
| `ZOQAK_ORDER_CREATED` | Independent / shop / comprehensive | Customer publishes Zoqak request | Suggested requests |
| `ZOQAK_OFFER_CREATED` | Provider (confirmation) | Provider submits offer | My offers |
| `ZOQAK_OFFER_RECEIVED` | Customer | Tailor sends offer | Submitted offers |
| `ZOQAK_OFFER_ACCEPTED` | Provider | Customer pays/accepts offer | Order detail / tracking |
| `ZOQAK_OFFER_ACCEPT_CONFIRMATION` | Customer | Offer accepted | Order details |
| `ZOQAK_OFFER_WITHDRAWN` / `_BY_PROVIDER` | Provider / customer | Offer withdrawn | Offers / submitted offers |
| `ZOQAK_OFFER_REMOVED` / `_BY_PROVIDER` | Provider / customer | Offer removed | Offers / submitted offers |
| `ZOQAK_ORDER_STATUS_CHANGED` | Customer | Tailor advances Zoqak stage | Order details |
| `SHOP_ORDER_CREATED` | Shop owner / comprehensive | Customer pays shop order | Order tracking |
| `SHOP_ORDER_STATUS_CHANGED` | Customer | Shop advances fulfillment stage | Order details |
| `CHAT_MESSAGE_RECEIVED` | Other chat party | New chat message | Chat detail |

Admin-only alerts (provider join, contact us, withdrawals, upgrades) stay in the **admin dashboard**, not the mobile user inbox.

## APIs

```http
GET    /api/v1/notifications/my
PATCH  /api/v1/notifications/:id/read
POST   /api/v1/notifications/device-token   { "token": "...", "platform": "android|ios" }
DELETE /api/v1/notifications/device-token  { "token": "..." }
```
