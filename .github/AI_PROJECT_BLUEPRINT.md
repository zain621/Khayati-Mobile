# Flutter Project — AI Development Blueprint

> **FOR AI ASSISTANT:** This document is MANDATORY. Follow every rule here without exception on every task, every file, every line of code. No deviations allowed without explicit user approval.

---

## PART 1 — CRITICAL RULES (Read First, Always)

### 1.1 — Absolute Non-Negotiables

| Rule | Requirement |
|------|-------------|
| Architecture | Always 3-layer Clean Architecture: Data → Domain → Presentation |
| State Management | GetX only — NEVER use `setState` |
| Colors | ONLY `ManagerColors.*` — NEVER hardcode colors |
| Dimensions | ONLY `ManagerWidth.w*` / `ManagerHeight.h*` / `ManagerRadius.r*` |
| Font Sizes | ONLY `ManagerFontSize.s*` — NEVER hardcode numbers |
| Text Styles | ONLY `getBoldTextStyle()` / `getRegularTextStyle()` / `getMediumTextStyle()` / `getLightTextStyle()` |
| **All UI text & strings** | **ONLY `ManagerStrings.*` — NEVER hardcode any string in UI** |
| **Snackbar messages** | **ONLY `ManagerStrings.*` — always provide Arabic + English** |
| Error handling | ALWAYS `Either<Failure, Model>` with `.fold()` |
| Code comments | English only — no emojis, no Arabic |
| DI registration | ALWAYS check `if (!GetIt.I.isRegistered<T>())` before registering |

---

### 1.2 — ManagerStrings Rule (STRICT)

All user-facing text **must** be defined in `lib/core/resources/manager_strings.dart` and referenced via `ManagerStrings.*`.

**Define strings here:**
```dart
// lib/core/resources/manager_strings.dart
class ManagerStrings {
  static const String loginTitle        = 'تسجيل الدخول';
  static const String phoneHint         = 'رقم الهاتف';
  static const String passwordHint      = 'كلمة المرور';
  static const String loginButton       = 'دخول';
  static const String loginSuccess      = 'تم تسجيل الدخول بنجاح';
  static const String loginSuccessEn    = 'Login successful';
  static const String savedSuccess      = 'تم الحفظ بنجاح';
  static const String savedSuccessEn    = 'Saved successfully';
  static const String fillAllFields     = 'يرجى ملء جميع الحقول';
  static const String fillAllFieldsEn   = 'Please fill all fields';
  static const String enterPhone        = 'يرجى إدخال رقم الهاتف';
  static const String enterPhoneEn      = 'Please enter phone number';
  static const String enterPassword     = 'يرجى إدخال كلمة المرور';
  static const String enterPasswordEn   = 'Please enter password';
  static const String noItems           = 'لا توجد بيانات';
  // add more as needed...
}
```

**Use in UI:**
```dart
Text(ManagerStrings.loginTitle)
```

**Use in Snackbar (ALWAYS both languages):**
```dart
AppSnackbar.success(ManagerStrings.loginSuccess, englishMessage: ManagerStrings.loginSuccessEn);
AppSnackbar.error(failure.message);
AppSnackbar.warning(ManagerStrings.fillAllFields, englishMessage: ManagerStrings.fillAllFieldsEn);
```

**What belongs in ManagerStrings:**
- Screen titles
- Button labels
- TextField hints and labels
- Empty state messages
- Snackbar success/error/warning messages (both Arabic + English)
- Form validation messages

**NEVER do this:**
```dart
// BAD
Text('تسجيل الدخول')
AppSnackbar.success('تم الحفظ', englishMessage: 'Saved')
```

---

## PART 2 — Project Architecture

### 2.1 — Layer Responsibilities

```
┌──────────────────────────────────────────────────┐
│             PRESENTATION LAYER                   │
│  controllers/ · pages/ · widgets/               │
│  → UI, GetX state, navigation                   │
└──────────────────────────────────────────────────┘
                       ↕
┌──────────────────────────────────────────────────┐
│               DOMAIN LAYER                       │
│  model/ · use_case/ · di/                       │
│  → Business logic, domain models, DI setup      │
└──────────────────────────────────────────────────┘
                       ↕
┌──────────────────────────────────────────────────┐
│                DATA LAYER                        │
│  data_source/ · repository/ · mapper/           │
│  request/ · response/                           │
│  → API calls, JSON parsing, error handling      │
└──────────────────────────────────────────────────┘
```

### 2.2 — End-to-End Data Flow

```
User taps button
  ↓ Controller method called        (e.g., login())
  ↓ Use Case executed               (e.g., LoginUseCase.execute(request))
  ↓ Repository called               (e.g., LoginRepository.login(request))
  ↓ DataSource makes API call       (via AppService)
  ↓ Response received               (LoginResponse)
  ↓ Mapper converts                 (LoginResponse.toDomain() → LoginModel)
  ↓ Either<Failure, LoginModel>     returned up the chain
  ↓ Controller handles              result.fold(failure, success)
  ↓ UI updates                      via Obx / GetBuilder
```

### 2.3 — Feature Folder Structure (Golden Rule)

Every feature MUST follow this exact structure:

```
lib/features/<role_group>/<feature_name>/
├── data/
│   ├── data_source/    → *_data_source.dart
│   ├── mapper/         → *_mapper.dart
│   ├── repository/     → *_repository.dart
│   ├── request/        → *_request.dart
│   └── response/       → *_response.dart  +  *_response.g.dart
├── domain/
│   ├── di/             → di.dart
│   ├── model/          → *_model.dart
│   └── use_case/       → *_use_case.dart
└── presentation/
    ├── controller/     → *_controller.dart
    ├── pages/          → *_screen.dart
    └── widgets/        → *_widget.dart
```

> **Role group** (`<role_group>`) is determined by the user per task — do not assume or invent a role. Wait for the user to specify it before creating any feature folder.

---

## PART 3 — API Integration (Step-by-Step)

> Follow these steps **in order** every time a new API endpoint is added.

### Step 1 — Add Endpoint Constant

**File:** `lib/constants/request_constants/request_constants_endpoints.dart`

```dart
class RequestConstantsEndpoints {
  static const String login = 'auth/login';
}
```

### Step 2 — Add Field Constants

**File:** `lib/constants/request_constants/request_constants.dart`

```dart
class RequestConstants {
  static const String phone    = 'phone';
  static const String password = 'password';
  static const String fcmToken = 'fcm_token';
}
```

### Step 3 — Create Request Model

**File:** `lib/features/<role>/<feature>/data/request/<action>_request.dart`

```dart
class LoginRequest {
  final String phone;
  final String password;
  final String fcmToken;

  LoginRequest({
    required this.phone,
    required this.password,
    required this.fcmToken,
  });
}
```

### Step 4 — Create Response Model

**File:** `lib/features/<role>/<feature>/data/response/<action>_response.dart`

```dart
import 'package:json_annotation/json_annotation.dart';
import '../../../../../constants/response_constants/response_constants.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: ResponseConstants.status)
  int? status;
  @JsonKey(name: ResponseConstants.message)
  String? message;
  @JsonKey(name: ResponseConstants.data)
  LoginDataResponse? data;

  LoginResponse({this.status, this.message, this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
```

### Step 5 — Add Method to AppService

**File:** `lib/core/network/app_api.dart`

```dart
@POST(RequestConstantsEndpoints.login)
Future<LoginResponse> login(
  @Field(RequestConstants.phone)    String phone,
  @Field(RequestConstants.password) String password,
  @Field(RequestConstants.fcmToken) String fcmToken,
);
```

**HTTP Annotations:** `@GET` · `@POST` · `@PUT` · `@PATCH` · `@DELETE`
**Parameter Annotations:** `@Field` (body) · `@Query` (query param) · `@Path` (path param) · `@Part` (multipart)

For paginated endpoints:
```dart
@GET(RequestConstantsEndpoints.sales)
Future<GetAllSalesResponse> getAllSales(
  @Query('page')     int page,
  @Query('per_page') int perPage,
);
```

### Step 6 — Run Code Generator

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

> Run this after EVERY change to any `@JsonSerializable` class or `AppService`.

### Step 7 — Create Domain Model

**File:** `lib/features/<role>/<feature>/domain/model/<action>_model.dart`

```dart
// Plain Dart class — NO json_annotation
class LoginModel {
  final int status;
  final String message;
  final LoginDataModel data;

  LoginModel({
    required this.status,
    required this.message,
    required this.data,
  });
}
```

### Step 8 — Create Mapper

**File:** `lib/features/<role>/<feature>/data/mapper/<action>_mapper.dart`

```dart
import 'package:khayati/core/extensions/extensions.dart';
import '../response/login_response.dart';
import '../../domain/model/login_model.dart';

extension LoginMapper on LoginResponse {
  LoginModel toDomain() {
    return LoginModel(
      status:  status.onNull(),
      message: message.onNull(),
      data:    data!.toDomain(),
    );
  }
}
```

> Always use `.onNull()` extension from `core/extensions` for nullable fields.

### Step 9 — Create DataSource

**File:** `lib/features/<role>/<feature>/data/data_source/<action>_data_source.dart`

```dart
import '../../../../../core/network/app_api.dart';
import '../request/login_request.dart';
import '../response/login_response.dart';

abstract class LoginDataSource {
  Future<LoginResponse> login(LoginRequest request);
}

class LoginDataSourceImplement implements LoginDataSource {
  final AppService _appService;

  LoginDataSourceImplement(this._appService);

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    return await _appService.login(
      request.phone,
      request.password,
      request.fcmToken,
    );
  }
}
```

### Step 10 — Create Repository

**File:** `lib/features/<role>/<feature>/data/repository/<action>_repository.dart`

```dart
import 'package:dartz/dartz.dart';
import '../../../../../core/error_handler/error_handler.dart';
import '../../../../../core/error_handler/failure.dart';
import '../../../../../core/internet_checker/interent_checker.dart';
import '../data_source/login_data_source.dart';
import '../mapper/login_mapper.dart';
import '../request/login_request.dart';
import '../../domain/model/login_model.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginModel>> login(LoginRequest request);
}

class LoginRepositoryImplement implements LoginRepository {
  final LoginDataSource remoteDataSource;
  final NetworkInfo _networkInfo;

  LoginRepositoryImplement(this._networkInfo, this.remoteDataSource);

  @override
  Future<Either<Failure, LoginModel>> login(LoginRequest request) async {
    try {
      final response = await remoteDataSource.login(request);
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
```

### Step 11 — Create Use Case

**File:** `lib/features/<role>/<feature>/domain/use_case/<action>_use_case.dart`

```dart
import 'package:dartz/dartz.dart';
import '../../../../../core/error_handler/failure.dart';
import '../../../../../core/usecase/base_usecase.dart';
import '../../data/repository/login_repository.dart';
import '../../data/request/login_request.dart';
import '../model/login_model.dart';

// With input parameter → BaseUseCase<In, Out>
class LoginUseCase implements BaseUseCase<LoginRequest, LoginModel> {
  final LoginRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, LoginModel>> execute(LoginRequest request) async {
    return await _repository.login(request);
  }
}

// Without input parameter → BaseGetUseCase<Out>
```

### Step 12 — Create DI Module

**File:** `lib/features/<role>/<feature>/domain/di/di.dart`

```dart
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../../../../constants/di/dependency_injection.dart';
import '../../../../../core/network/app_api.dart';
import '../../../../../core/storage/local/app_settings_prefs.dart';
import '../../data/data_source/login_data_source.dart';
import '../../data/repository/login_repository.dart';
import '../../presentation/controller/login_controller.dart';
import '../use_case/login_use_case.dart';

void initLoginRequest() {
  if (!GetIt.I.isRegistered<LoginDataSource>()) {
    instance.registerLazySingleton<LoginDataSource>(
      () => LoginDataSourceImplement(instance<AppService>()),
    );
  }
  if (!GetIt.I.isRegistered<LoginRepository>()) {
    instance.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImplement(instance(), instance()),
    );
  }
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(
      () => LoginUseCase(instance<LoginRepository>()),
    );
  }
}

void disposeLoginRequest() {
  if (GetIt.I.isRegistered<LoginUseCase>())    instance.unregister<LoginUseCase>();
  if (GetIt.I.isRegistered<LoginRepository>()) instance.unregister<LoginRepository>();
  if (GetIt.I.isRegistered<LoginDataSource>()) instance.unregister<LoginDataSource>();
}

void initLogin() {
  initLoginRequest();
  Get.put(LoginController(
    instance<LoginUseCase>(),
    instance<AppSettingsPrefs>(),
  ));
}

void disposeLogin() {
  disposeLoginRequest();
  Get.delete<LoginController>();
}
```

> **GetIt** → DataSource / Repository / UseCase
> **GetX** → Controllers only

---

## PART 4 — Controller Standard

**File:** `lib/features/<role>/<feature>/presentation/controller/<feature>_controller.dart`

```dart
import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import '../../domain/use_case/login_use_case.dart';
import '../../data/request/login_request.dart';
import '../../../../../core/error_handler/failure.dart';
import '../../../../../core/helpers/app_snack_bar.dart';
import '../../../../../core/resources/manager_strings.dart';

class LoginController extends GetxController {
  final LoginUseCase _loginUseCase;

  LoginController(this._loginUseCase);

  // State variables
  final RxBool   isLoading     = false.obs;
  final RxBool   isError       = false.obs;
  final RxString errorMessage  = ''.obs;

  final TextEditingController phoneController    = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> login() async {
    // Validate inputs using ManagerStrings
    if (phoneController.text.trim().isEmpty) {
      AppSnackbar.warning(
        ManagerStrings.enterPhone,
        englishMessage: ManagerStrings.enterPhoneEn,
      );
      return;
    }
    if (passwordController.text.trim().isEmpty) {
      AppSnackbar.warning(
        ManagerStrings.enterPassword,
        englishMessage: ManagerStrings.enterPasswordEn,
      );
      return;
    }

    isLoading.value   = true;
    errorMessage.value = '';

    final request = LoginRequest(
      phone:    phoneController.text.trim(),
      password: passwordController.text.trim(),
      fcmToken: '',
    );

    final Either<Failure, LoginModel> result =
        await _loginUseCase.execute(request);

    result.fold(
      (failure) {
        errorMessage.value = failure.message;
        AppSnackbar.error(failure.message);
      },
      (data) {
        AppSnackbar.success(
          ManagerStrings.loginSuccess,
          englishMessage: ManagerStrings.loginSuccessEn,
        );
        // Navigate or handle success state
      },
    );

    isLoading.value = false;
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
```

### Controller Rules

| Do | Don't |
|----|-------|
| Use `Rx` types for reactive state | Use `setState` |
| Call `update()` when using GetBuilder | Access BuildContext directly |
| Use Use Cases for all data operations | Call API/DataSource directly |
| Use `ManagerStrings.*` for ALL messages | Hardcode any string |
| Show `AppSnackbar` for user feedback | Ignore errors silently |
| Validate input before API calls | Make API calls without validation |

### Method Naming Conventions

| Action | Prefix |
|--------|--------|
| Initial data load | `fetch*()` |
| Pull-to-refresh | `refresh*()` |
| Pagination load | `loadMore*()` |
| Create/submit | `submit*()` / `create*()` |
| Update existing | `update*()` |
| Delete | `delete*()` |

---

## PART 5 — Screen (UI Page) Standard

**File:** `lib/features/<role>/<feature>/presentation/pages/<feature>_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khayati/core/resources/manager_colors.dart';
import 'package:khayati/core/resources/manager_height.dart';
import 'package:khayati/core/resources/manager_width.dart';
import 'package:khayati/core/resources/manager_strings.dart';
import '../../domain/di/di.dart';
import '../controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    initLogin(); // Always call init before Get.find
    final controller = Get.find<LoginController>();

    return Scaffold(
      backgroundColor: ManagerColors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: LoadingWidget());
        }
        return Column(
          children: [
            // All text must use ManagerStrings
            Text(ManagerStrings.loginTitle),
          ],
        );
      }),
    );
  }
}
```

---

## PART 6 — Design System (MANDATORY)

### Colors — `ManagerColors`
```dart
ManagerColors.primaryColor    // Primary brand color
ManagerColors.secondColor     // Secondary color
ManagerColors.white
ManagerColors.blackColor
ManagerColors.greenColor
ManagerColors.greyLight
```

### Dimensions — `ManagerWidth` / `ManagerHeight` / `ManagerRadius`
```dart
SizedBox(height: ManagerHeight.h16)
SizedBox(width:  ManagerWidth.w10)
EdgeInsets.symmetric(horizontal: ManagerWidth.w16, vertical: ManagerHeight.h8)
Container(width: ManagerWidth.w305, height: ManagerHeight.h46)
BorderRadius.circular(ManagerRadius.r8)
```

### Font Sizes — `ManagerFontSize`
```dart
ManagerFontSize.s10 / s12 / s14 / s16 / s18 / s20 ...
```

### Text Styles — Always use style functions
```dart
getBoldTextStyle(fontSize: ManagerFontSize.s14,   color: ManagerColors.blackColor)
getRegularTextStyle(fontSize: ManagerFontSize.s12, color: ManagerColors.greyLight)
getMediumTextStyle(fontSize: ManagerFontSize.s16,  color: ManagerColors.primaryColor)
getLightTextStyle(fontSize: ManagerFontSize.s12,   color: ManagerColors.white)
```

### Gradient
```dart
decoration: BoxDecoration(
  gradient: const LinearGradient(colors: [
    ManagerColors.secondColor,
    ManagerColors.primaryColor,
  ]),
  borderRadius: BorderRadius.circular(ManagerRadius.r5),
)
```

> **DO NOT change any UI design unless explicitly instructed. Only modify logic/functionality.**

---

## PART 7 — Reusable Core Widgets

| Widget | Path | Purpose |
|--------|------|---------|
| `ButtonApp` | `lib/core/widgets/button_app.dart` | Standard gradient button |
| `LabeledTextField` | `lib/core/widgets/label_text_field.dart` | Input with label |
| `LoadingWidget` | `lib/core/widgets/loading_widget.dart` | Full-screen loader |
| `AvatarWithBorderShadow` | `lib/core/widgets/avatar_widget.dart` | Circular avatar |
| `CustomAppBar` | `lib/core/widgets/custom_app_bar.dart` | App bar with back |
| `EmptyStateWidget` | — | Empty list placeholder |
| `AppSnackbar` | `lib/core/helpers/app_snack_bar.dart` | User feedback |

```dart
// Button — title from ManagerStrings
ButtonApp(
  title:        ManagerStrings.loginButton,
  onPressed:    () => controller.login(),
  paddingWidth: ManagerWidth.w16,
)

// TextField — label/hint from ManagerStrings
LabeledTextField(
  label:        ManagerStrings.phoneLabel,
  hintText:     ManagerStrings.phoneHint,
  controller:   controller.phoneController,
  widthButton:  ManagerWidth.w0,
  keyboardType: TextInputType.phone,
)

// Snackbar — always ManagerStrings + both languages
AppSnackbar.success(ManagerStrings.savedSuccess, englishMessage: ManagerStrings.savedSuccessEn);
AppSnackbar.error(failure.message);
AppSnackbar.warning(ManagerStrings.fillAllFields, englishMessage: ManagerStrings.fillAllFieldsEn);
```

---

## PART 8 — Common UI Patterns

### Loading / Error / Empty States
```dart
Obx(() {
  if (controller.isLoading.value)
    return const Center(child: LoadingWidget());
  if (controller.isError.value)
    return Center(
      child: Text(
        controller.errorMessage.value,
        style: getRegularTextStyle(
          fontSize: ManagerFontSize.s14,
          color: ManagerColors.redNew,
        ),
      ),
    );
  if (controller.items.isEmpty)
    return EmptyStateWidget(message: ManagerStrings.noItems);
  return ListView.builder(...);
})
```

### Pull-to-Refresh
```dart
RefreshIndicator(
  onRefresh: () async => controller.refreshData(),
  child: ListView.builder(
    physics: const AlwaysScrollableScrollPhysics(),
    itemCount: controller.items.length,
    itemBuilder: (context, index) => ...,
  ),
)
```

### Pagination
```dart
int currentPage = 1;
final int perPage = 20;
bool hasMore = true;

Future<void> loadMore() async {
  if (!hasMore || isLoading.value) return;
  currentPage++;
  final result = await _useCase.execute(currentPage, perPage);
  result.fold(
    (failure) => hasMore = false,
    (data) {
      items.addAll(data.items);
      hasMore = data.items.length == perPage;
    },
  );
}
```

### Navigation
```dart
// Navigate — init first
initMyFeature();
Get.toNamed(Routes.myFeatureScreen);

// With arguments
Get.toNamed(Routes.detailScreen, arguments: item);
final item = Get.arguments as MyItem; // In target screen

// Replace / clear stack
Get.offNamed(Routes.homeScreen);
Get.offAllNamed(Routes.loginScreen);
Get.back();
```

### Route Registration

**Step 1 — `lib/core/routes/routes.dart`:**
```dart
static const String loginScreen = '/login_screen';
```

**Step 2 — `RouteGenerator.getRoute()`:**
```dart
case Routes.loginScreen:
  return fadeRoute(const LoginScreen());
```

**Transitions:** `fadeRoute()` · `slideFromRight()` · `slideFromLeft()` · `zoomInRoute()`

---

## PART 9 — Auto Headers & Error Handling

### Headers (handled automatically by DioFactory)
- **Authorization:** `Bearer <token>` from `AppSettingsPrefs`
- **x-localization:** `ar` or `en` based on current locale

### Error Flow
```dart
// In repository — always wrap in try-catch
try {
  final response = await remoteDataSource.doSomething(request);
  return Right(response.toDomain());
} catch (e) {
  return Left(ErrorHandler.handle(e).failure);
}
```

- **401 Unauthorized** → Auto clear session + redirect to login
- **Error message** → Extracted from API `message` field or generic fallback

---

## PART 10 — Constants Structure

```
lib/constants/
├── constants/constants.dart                           → App-level constants
├── di/dependency_injection.dart                       → Base DI (init in main.dart)
├── env/env_constants.dart                             → Environment variables
├── request_constants/
│   ├── request_constants.dart                         → API field names
│   └── request_constants_endpoints.dart               → API endpoints
├── response_constants/response_constants.dart         → API response field names
└── shared_prefs_constants/shared_prefs_constants.dart → SharedPrefs keys
```

---

## PART 11 — File Naming Conventions

| Type | Pattern | Example |
|------|---------|---------|
| Screen | `*_screen.dart` | `login_screen.dart` |
| Controller | `*_controller.dart` | `login_controller.dart` |
| Widget | `*_widget.dart` | `product_card_widget.dart` |
| Use Case | `*_use_case.dart` | `login_use_case.dart` |
| Repository | `*_repository.dart` | `login_repository.dart` |
| DataSource | `*_data_source.dart` | `login_data_source.dart` |
| Domain Model | `*_model.dart` | `login_model.dart` |
| Request | `*_request.dart` | `login_request.dart` |
| Response | `*_response.dart` | `login_response.dart` |
| Mapper | `*_mapper.dart` | `login_mapper.dart` |
| DI | `di.dart` | `di.dart` |

---

## PART 12 — Full Feature Checklist

### Data Layer
- [ ] Endpoint added to `RequestConstantsEndpoints`
- [ ] Fields added to `RequestConstants`
- [ ] `*_request.dart` created (no annotations)
- [ ] `*_response.dart` created with `@JsonSerializable()`
- [ ] Method added to `AppService`
- [ ] `build_runner` executed
- [ ] `*_response.g.dart` generated
- [ ] `*_mapper.dart` with `.toDomain()`, using `.onNull()`
- [ ] `*_data_source.dart` — abstract + implementation
- [ ] `*_repository.dart` — abstract + implementation with `try-catch`

### Domain Layer
- [ ] `*_model.dart` — plain Dart class, no annotations
- [ ] `*_use_case.dart` — implements `BaseUseCase` or `BaseGetUseCase`
- [ ] `di.dart` — `init*Request()`, `dispose*Request()`, `init*()`, `dispose*()`

### Presentation Layer
- [ ] `*_controller.dart` — Rx state, validates with `ManagerStrings.*`
- [ ] `*_screen.dart` — calls `init*()` in build, uses `Get.find<>()`
- [ ] `*_widget.dart` (if needed) — uses Manager* classes
- [ ] Route constant in `Routes`
- [ ] Route case in `RouteGenerator`

### Strings & Style Checks
- [ ] ALL new user-facing text added to `ManagerStrings`
- [ ] No hardcoded strings anywhere
- [ ] No hardcoded colors, sizes, or font sizes
- [ ] All snackbars use `ManagerStrings.*` with Arabic + English
- [ ] Text styles use `getBoldTextStyle()` / `getRegularTextStyle()` etc.

### Final Checks
- [ ] English code comments only
- [ ] DI checks `if (!GetIt.I.isRegistered<T>())`
- [ ] Module disposed on screen exit
- [ ] Loading / Error / Empty states all handled
- [ ] `AppSnackbar` shown for all user-triggered actions

---

## PART 13 — Quick Commands

```bash
# Generate code (run after every Response/AppService change)
flutter pub run build_runner build --delete-conflicting-outputs

# Clean and reinstall
flutter clean && flutter pub get

# Analyze code
flutter analyze

# Run app
flutter run

# Release APK
flutter build apk --release
```

---

*This blueprint is the single source of truth. All generated or modified code must comply fully.*
