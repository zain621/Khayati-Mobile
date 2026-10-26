// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionsResponse _$TransactionsResponseFromJson(
        Map<String, dynamic> json) =>
    TransactionsResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : TransactionsDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$TransactionsResponseToJson(
        TransactionsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };

TransactionsDataResponse _$TransactionsDataResponseFromJson(
        Map<String, dynamic> json) =>
    TransactionsDataResponse(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) =>
              TransactionItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TransactionsDataResponseToJson(
        TransactionsDataResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
      'total': instance.total,
    };

TransactionItemResponse _$TransactionItemResponseFromJson(
        Map<String, dynamic> json) =>
    TransactionItemResponse(
      id: json['id'] as String?,
      type: json['type'] as String?,
      typeLabel: json['typeLabel'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      description: json['description'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$TransactionItemResponseToJson(
        TransactionItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'typeLabel': instance.typeLabel,
      'amount': instance.amount,
      'description': instance.description,
      'createdAt': instance.createdAt,
    };
