// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_action_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletActionResponse _$WalletActionResponseFromJson(
        Map<String, dynamic> json) =>
    WalletActionResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$WalletActionResponseToJson(
        WalletActionResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
    };
