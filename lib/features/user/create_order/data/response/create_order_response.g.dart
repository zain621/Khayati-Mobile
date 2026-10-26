// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrderDataResponse _$CreateOrderDataResponseFromJson(
        Map<String, dynamic> json) =>
    CreateOrderDataResponse(
      id: json['_id'] as String?,
      orderNumber: json['orderNumber'] as String?,
      productName: json['productName'] as String?,
      description: json['description'] as String?,
      specialRequests: json['specialRequests'] as String?,
      fabricType: json['fabricType'] as String?,
      minExpectedBudget: json['minExpectedBudget'] as num?,
      maxExpectedBudget: json['maxExpectedBudget'] as num?,
      deliveryDate: json['deliveryDate'] as String?,
      similarImages: (json['similarImages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      userName: json['userName'] as String?,
    );

Map<String, dynamic> _$CreateOrderDataResponseToJson(
        CreateOrderDataResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'orderNumber': instance.orderNumber,
      'productName': instance.productName,
      'description': instance.description,
      'specialRequests': instance.specialRequests,
      'fabricType': instance.fabricType,
      'minExpectedBudget': instance.minExpectedBudget,
      'maxExpectedBudget': instance.maxExpectedBudget,
      'deliveryDate': instance.deliveryDate,
      'similarImages': instance.similarImages,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'userName': instance.userName,
    };

CreateOrderResponse _$CreateOrderResponseFromJson(Map<String, dynamic> json) =>
    CreateOrderResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : CreateOrderDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateOrderResponseToJson(
        CreateOrderResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
