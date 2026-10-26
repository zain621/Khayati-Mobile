// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailDataResponse _$OrderDetailDataResponseFromJson(
        Map<String, dynamic> json) =>
    OrderDetailDataResponse(
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
      userImage: json['userImage'] as String?,
      offersCount: (json['offersCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderDetailDataResponseToJson(
        OrderDetailDataResponse instance) =>
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
      'userImage': instance.userImage,
      'offersCount': instance.offersCount,
    };

OrderDetailResponse _$OrderDetailResponseFromJson(Map<String, dynamic> json) =>
    OrderDetailResponse(
      data: json['data'] == null
          ? null
          : OrderDetailDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderDetailResponseToJson(
        OrderDetailResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
