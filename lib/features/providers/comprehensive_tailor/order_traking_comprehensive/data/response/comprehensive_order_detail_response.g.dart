// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comprehensive_order_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComprehensiveOrderDetailResponse _$ComprehensiveOrderDetailResponseFromJson(
        Map<String, dynamic> json) =>
    ComprehensiveOrderDetailResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : ComprehensiveOrderDetailDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ComprehensiveOrderDetailResponseToJson(
        ComprehensiveOrderDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

ComprehensiveOrderDetailDataResponse
    _$ComprehensiveOrderDetailDataResponseFromJson(Map<String, dynamic> json) =>
        ComprehensiveOrderDetailDataResponse(
          source: json['source'] as String?,
          shopOrder: json['order'] == null
              ? null
              : ComprehensiveShopOrderResponse.fromJson(
                  json['order'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$ComprehensiveOrderDetailDataResponseToJson(
        ComprehensiveOrderDetailDataResponse instance) =>
    <String, dynamic>{
      'source': instance.source,
      'order': instance.shopOrder,
    };
