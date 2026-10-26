import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../constants/constants/constants.dart';
import '../../constants/di/dependency_injection.dart';
import '../../constants/env/env_constants.dart';
import '../error_handler/response_code.dart';
import '../resources/manager_strings.dart';
import '../routes/routes.dart';
import '../service/env_service.dart';
import '../service/session_reset_service.dart';
import '../storage/local/app_settings_prefs.dart';
import '../util/app_snack_bar.dart';

class DioFactory {
  final AppSettingsPrefs _appPreferences = instance<AppSettingsPrefs>();
  static bool _isHandlingExpiredSession = false;

  Future<Dio> getDio() async {
    Dio dio = Dio();
    Map<String, String> headers = {
      Constants.authorization: getAuthorization(_appPreferences.getToken()),
      Constants.accept: Constants.applicationJson,
      Constants.contentType: Constants.applicationJson,
    };

    dio.options = BaseOptions(
      baseUrl: EnvService.getString(
        key: EnvConstants.apiUrl,
      ),
      headers: headers,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(
        seconds: Constants.receiveTimeOutDuration,
      ),
      sendTimeout: const Duration(
        seconds: Constants.sendTimeOutDuration,
      ),
    );

    InterceptorsWrapper authInterceptor = InterceptorsWrapper(
      onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        options.headers[Constants.authorization] = getAuthorization(
          _appPreferences.getToken(),
        );
        return handler.next(options);
      },
      onError: (DioException error, ErrorInterceptorHandler handler) async {
        if (error.response?.statusCode == ResponseCode.unAuthorized &&
            _appPreferences.getToken().isNotEmpty) {
          await _handleExpiredSession();
        }
        return handler.next(error);
      },
    );
    dio.interceptors.add(authInterceptor);

    InterceptorsWrapper languageInterceptor = InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        options.headers[Constants.acceptLanguage] = _appPreferences.getLocale();
        return handler.next(options);
      },
    );
    dio.interceptors.add(languageInterceptor);

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          final retried = error.requestOptions.extra['khayati_retried'] == true;
          final isTransient = error.type == DioExceptionType.connectionError ||
              error.type == DioExceptionType.connectionTimeout;
          if (!retried && isTransient) {
            error.requestOptions.extra['khayati_retried'] = true;
            try {
              await Future<void>.delayed(const Duration(milliseconds: 350));
              final response = await dio.fetch(error.requestOptions);
              return handler.resolve(response);
            } catch (_) {
              return handler.next(error);
            }
          }
          return handler.next(error);
        },
      ),
    );

    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseBody: true,
          responseHeader: true,
        ),
      );
    }
    return dio;
  }

  String getAuthorization(String token) {
    return '${Constants.bearer} $token';
  }

  Future<void> _handleExpiredSession() async {
    if (_isHandlingExpiredSession) return;
    _isHandlingExpiredSession = true;

    await clearLocalAuthArtifacts();

    if (Get.currentRoute != Routes.loginScreen) {
      AppSnackbar.warning(ManagerStrings.sessionFinished);
      Get.offAllNamed(Routes.loginScreen);
    }
    resetSessionControllers();

    _isHandlingExpiredSession = false;
  }
}
