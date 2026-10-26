// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletResponse _$WalletResponseFromJson(Map<String, dynamic> json) =>
    WalletResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : WalletDataResponse.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$WalletResponseToJson(WalletResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };

WalletDataResponse _$WalletDataResponseFromJson(Map<String, dynamic> json) =>
    WalletDataResponse(
      pendingBalance: (json['pendingBalance'] as num?)?.toDouble(),
      withdrawableBalance: (json['withdrawableBalance'] as num?)?.toDouble(),
      totalBalance: (json['totalBalance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WalletDataResponseToJson(WalletDataResponse instance) =>
    <String, dynamic>{
      'pendingBalance': instance.pendingBalance,
      'withdrawableBalance': instance.withdrawableBalance,
      'totalBalance': instance.totalBalance,
    };
