import 'package:app_mobile/core/error_handler/data_source_extension.dart';
import 'package:app_mobile/core/error_handler/response_code.dart';
import 'package:app_mobile/core/error_handler/type_handler_enum.dart';
import 'package:app_mobile/core/extensions/extensions.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import 'package:dio/dio.dart';
import '../../constants/constants/constants.dart';
import '../../constants/di/dependency_injection.dart';
import '../resources/manager_strings.dart';
import 'failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;
  AppSettingsPrefs appSettings = instance<AppSettingsPrefs>();

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      final response = error.response;
      final statusCode = response?.statusCode ?? ResponseCode.badRequest;
      final data = response?.data;
      final apiMessage = _messageFromBody(data);

      if (response?.statusCode == ResponseCode.unAuthorized) {
        final token = appSettings.getToken();
        final isLoginCredentialError = _isCredentialError(apiMessage);
        if (token.isNotEmpty && !isLoginCredentialError) {
          Future.delayed(
            const Duration(
              seconds: Constants.sessionFinishedDuration,
            ),
            () {
              // appSettings.clear();
              // Get.offAllNamed(Routes.splash);
            },
          );
          failure = Failure(
            response!.statusCode.onNull(),
            ManagerStrings.sessionFinished,
          );
        } else {
          failure = Failure(
            statusCode,
            apiMessage ?? ManagerStrings.loginUserNotFound,
          );
        }
      } else if (apiMessage != null) {
        failure = Failure(statusCode, apiMessage);
      } else if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.connectionError) {
        failure = Failure(
          statusCode,
          ManagerStrings.noInternetConnection,
        );
      } else {
        failure = Failure(
          statusCode,
          ManagerStrings.unKnown,
        );
      }
    } else {
      failure = TypeHandlerEnum.unknown.getFailure();
    }
  }

  String? _messageFromBody(dynamic data) {
    if (data is! Map) return null;
    try {
      final raw = data[Constants.message];
      if (raw is String && raw.trim().isNotEmpty) {
        return _cleanApiMessage(raw);
      }
      if (raw is List && raw.isNotEmpty) {
        return _cleanApiMessage(raw.first.toString());
      }
      final nested = (data[Constants.error] as Map?)?[Constants.message];
      if (nested is String && nested.trim().isNotEmpty) {
        return _cleanApiMessage(nested);
      }
    } catch (_) {
      return null;
    }
    return null;
  }

  bool _isCredentialError(String? message) {
    if (message == null) return false;
    final lower = message.toLowerCase();
    return lower.contains('not found') ||
        lower.contains('not registered') ||
        lower.contains('invalid') ||
        lower.contains('credential');
  }

  String _cleanApiMessage(String raw) {
    var msg = raw.trim();
    if (msg.startsWith('common.')) {
      msg = msg.substring(7);
    }
    final lower = msg.toLowerCase();
    if (lower.contains('user not found') ||
        lower.contains('user.not_found') ||
        lower == 'not_found') {
      return ManagerStrings.loginUserNotFound;
    }
    if (lower == 'error' || lower == 'unknown') {
      return ManagerStrings.unKnown;
    }
    return msg;
  }
}
