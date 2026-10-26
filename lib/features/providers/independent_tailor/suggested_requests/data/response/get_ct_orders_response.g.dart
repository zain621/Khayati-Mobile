// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_ct_orders_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCTOrdersDataResponse _$GetCTOrdersDataResponseFromJson(
        Map<String, dynamic> json) =>
    GetCTOrdersDataResponse(
      zoqakOrders: (json['zoqakOrders'] as List<dynamic>?)
          ?.map((e) => OrderDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      shopOrders: (json['shopOrders'] as List<dynamic>?)
          ?.map((e) => OrderDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetCTOrdersDataResponseToJson(
        GetCTOrdersDataResponse instance) =>
    <String, dynamic>{
      'zoqakOrders': instance.zoqakOrders,
      'shopOrders': instance.shopOrders,
    };

GetCTOrdersResponse _$GetCTOrdersResponseFromJson(Map<String, dynamic> json) =>
    GetCTOrdersResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : GetCTOrdersDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetCTOrdersResponseToJson(
        GetCTOrdersResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
