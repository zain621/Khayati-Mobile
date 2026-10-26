// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginDataResponse _$LoginDataResponseFromJson(Map<String, dynamic> json) =>
    LoginDataResponse(
      accessToken: json['accessToken'] as String?,
      user: json['user'] == null
          ? null
          : UserResponse.fromJson(json['user'] as Map<String, dynamic>),
      requiresVerification: json['requiresVerification'] as bool?,
      temporaryToken: json['temporaryToken'] as String?,
      otpCode: json['otpCode'] as String?,
    );

Map<String, dynamic> _$LoginDataResponseToJson(LoginDataResponse instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'user': instance.user,
      'requiresVerification': instance.requiresVerification,
      'temporaryToken': instance.temporaryToken,
      'otpCode': instance.otpCode,
    };

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      status: json['status'] as String?,
      code: _loginStatusCodeFromJson(json['code']),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : LoginDataResponse.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
