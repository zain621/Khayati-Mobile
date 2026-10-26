import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/extensions/extensions.dart';
import 'package:app_mobile/core/locale/locale_controller.dart';
import 'package:app_mobile/core/service/push_notification_service.dart';
import 'package:app_mobile/core/util/screen_util_new.dart';
import 'package:app_mobile/firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker_android/image_picker_android.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'constants/constants/constants.dart';
import 'constants/env/env_constants.dart';
import 'core/locale/locales.dart';
import 'core/resources/manager_translation.dart';
import 'core/routes/routes.dart';
import 'core/util/size_util.dart';

// import 'package:device_preview/device_preview.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Force Android system Photo Picker (no READ_MEDIA_IMAGES / READ_MEDIA_VIDEO).
  final imagePickerImplementation = ImagePickerPlatform.instance;
  if (imagePickerImplementation is ImagePickerAndroid) {
    imagePickerImplementation.useAndroidPhotoPicker = true;
  }

  // Web Firebase app is not registered yet (only Android/iOS in FlutterFire).
  // Skip Firebase on Chrome so UI/debug runs; mobile keeps full FCM init.
  if (!kIsWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  await initModule();
  await PushNotificationService.instance.initialize();
  Get.put(LocaleController(), permanent: true);
  runApp(
    EasyLocalization(
      supportedLocales: localeSettings.locales,
      path: translationPath,
      fallbackLocale: const Locale("en"),
      startLocale: localeSettings.defaultLocale,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilNew.init(context);
    SizeConfig.init(context);
    return ScreenUtilInit(
      designSize: const Size(Constants.deviceWidth, Constants.deviceHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return GetMaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          defaultGlobalState: dotenv.env[EnvConstants.debug].onNullBool(),
          locale: context.locale,
          debugShowCheckedModeBanner:
              dotenv.env[EnvConstants.debug].onNullBool(),
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.splash,
          theme: ThemeData(
            useMaterial3: true,
          ),
        );
      },
    );
  }
}

///flutter pub run build_runner build --delete-conflicting-outputs
