// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_orders_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDataResponse _$OrderDataResponseFromJson(Map<String, dynamic> json) =>
    OrderDataResponse(
      id: json['id'] as String?,
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
      userImage: json['userImage'] as String?,
      offersCount: (json['offersCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderDataResponseToJson(OrderDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
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
      'userImage': instance.userImage,
      'offersCount': instance.offersCount,
    };

GetOrdersResponse _$GetOrdersResponseFromJson(Map<String, dynamic> json) =>
    GetOrdersResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => OrderDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetOrdersResponseToJson(GetOrdersResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
