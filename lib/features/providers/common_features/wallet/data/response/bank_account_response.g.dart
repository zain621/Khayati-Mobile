// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_account_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankAccountsResponse _$BankAccountsResponseFromJson(
        Map<String, dynamic> json) =>
    BankAccountsResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              BankAccountDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$BankAccountsResponseToJson(
        BankAccountsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };

BankAccountDataResponse _$BankAccountDataResponseFromJson(
        Map<String, dynamic> json) =>
    BankAccountDataResponse(
      id: json['id'] as String?,
      bankName: json['bankName'] as String?,
      accountHolderName: json['accountHolderName'] as String?,
      accountNumber: json['accountNumber'] as String?,
      iban: json['iban'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$BankAccountDataResponseToJson(
        BankAccountDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bankName': instance.bankName,
      'accountHolderName': instance.accountHolderName,
      'accountNumber': instance.accountNumber,
      'iban': instance.iban,
      'createdAt': instance.createdAt,
    };

BankAccountActionResponse _$BankAccountActionResponseFromJson(
        Map<String, dynamic> json) =>
    BankAccountActionResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : BankAccountDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$BankAccountActionResponseToJson(
        BankAccountActionResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };
