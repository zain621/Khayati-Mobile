// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_my_offers_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyOfferDetailResponse _$MyOfferDetailResponseFromJson(
        Map<String, dynamic> json) =>
    MyOfferDetailResponse(
      id: json['id'] as String?,
      proposedPrice: json['proposedPrice'] as num?,
      executionDays: (json['executionDays'] as num?)?.toInt(),
      details: json['details'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$MyOfferDetailResponseToJson(
        MyOfferDetailResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'proposedPrice': instance.proposedPrice,
      'executionDays': instance.executionDays,
      'details': instance.details,
      'status': instance.status,
      'createdAt': instance.createdAt,
    };

ClientBudgetResponse _$ClientBudgetResponseFromJson(
        Map<String, dynamic> json) =>
    ClientBudgetResponse(
      minExpectedBudget: json['minExpectedBudget'] as num?,
      maxExpectedBudget: json['maxExpectedBudget'] as num?,
    );

Map<String, dynamic> _$ClientBudgetResponseToJson(
        ClientBudgetResponse instance) =>
    <String, dynamic>{
      'minExpectedBudget': instance.minExpectedBudget,
      'maxExpectedBudget': instance.maxExpectedBudget,
    };

MyOfferItemResponse _$MyOfferItemResponseFromJson(Map<String, dynamic> json) =>
    MyOfferItemResponse(
      orderId: json['orderId'] as String?,
      orderNumber: json['orderNumber'] as String?,
      requesterImage: json['requesterImage'] as String?,
      requesterName: json['requesterName'] as String?,
      requesterDescription: json['requesterDescription'] as String?,
      myOffer: json['myOffer'] == null
          ? null
          : MyOfferDetailResponse.fromJson(
              json['myOffer'] as Map<String, dynamic>),
      clientBudget: json['clientBudget'] == null
          ? null
          : ClientBudgetResponse.fromJson(
              json['clientBudget'] as Map<String, dynamic>),
      competitors: json['competitors'] as List<dynamic>?,
    );

Map<String, dynamic> _$MyOfferItemResponseToJson(
        MyOfferItemResponse instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'orderNumber': instance.orderNumber,
      'requesterImage': instance.requesterImage,
      'requesterName': instance.requesterName,
      'requesterDescription': instance.requesterDescription,
      'myOffer': instance.myOffer,
      'clientBudget': instance.clientBudget,
      'competitors': instance.competitors,
    };

GetMyOffersResponse _$GetMyOffersResponseFromJson(Map<String, dynamic> json) =>
    GetMyOffersResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => MyOfferItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetMyOffersResponseToJson(
        GetMyOffersResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
