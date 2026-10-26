// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zoqak_offers_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZoqakOffersResponse _$ZoqakOffersResponseFromJson(Map<String, dynamic> json) =>
    ZoqakOffersResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => ZoqakOfferItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ZoqakOffersResponseToJson(
        ZoqakOffersResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };

ZoqakOfferItemResponse _$ZoqakOfferItemResponseFromJson(
        Map<String, dynamic> json) =>
    ZoqakOfferItemResponse(
      id: json['id'] as String?,
      orderId: json['orderId'] as String?,
      providerId: json['providerId'] as String?,
      proposedPrice: json['proposedPrice'],
      executionDays: (json['executionDays'] as num?)?.toInt(),
      details: json['details'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      providerName: json['providerName'] as String?,
      providerImage: json['providerImage'] as String?,
      providerIsAvailable: json['providerIsAvailable'] as bool?,
      providerRank: json['providerRank'] as String?,
      providerRankLabel: json['providerRankLabel'] as String?,
      providerRating: json['providerRating'],
      providerRatersCount: (json['providerRatersCount'] as num?)?.toInt(),
      providerOffersCount: (json['providerOffersCount'] as num?)?.toInt(),
      orderOffersCount: (json['orderOffersCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ZoqakOfferItemResponseToJson(
        ZoqakOfferItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'providerId': instance.providerId,
      'proposedPrice': instance.proposedPrice,
      'executionDays': instance.executionDays,
      'details': instance.details,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'providerName': instance.providerName,
      'providerImage': instance.providerImage,
      'providerIsAvailable': instance.providerIsAvailable,
      'providerRank': instance.providerRank,
      'providerRankLabel': instance.providerRankLabel,
      'providerRating': instance.providerRating,
      'providerRatersCount': instance.providerRatersCount,
      'providerOffersCount': instance.providerOffersCount,
      'orderOffersCount': instance.orderOffersCount,
    };

ZoqakOrderDetailResponse _$ZoqakOrderDetailResponseFromJson(
        Map<String, dynamic> json) =>
    ZoqakOrderDetailResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : ZoqakOrderDetailDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ZoqakOrderDetailResponseToJson(
        ZoqakOrderDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };

ZoqakOrderDetailDataResponse _$ZoqakOrderDetailDataResponseFromJson(
        Map<String, dynamic> json) =>
    ZoqakOrderDetailDataResponse(
      id: json['id'] as String?,
      orderNumber: json['orderNumber'] as String?,
      productName: json['productName'] as String?,
      description: json['description'] as String?,
      specialRequests: json['specialRequests'] as String?,
      fabricType: json['fabricType'] as String?,
      minExpectedBudget: json['minExpectedBudget'],
      maxExpectedBudget: json['maxExpectedBudget'],
      deliveryDate: json['deliveryDate'] as String?,
      similarImages: (json['similarImages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      userName: json['userName'] as String?,
      offers: (json['offers'] as List<dynamic>?)
          ?.map(
              (e) => ZoqakOfferItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      stages: (json['stages'] as List<dynamic>?)
          ?.map((e) => OrderStageResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      stagesSummary: json['stagesSummary'] == null
          ? null
          : StagesSummaryResponse.fromJson(
              json['stagesSummary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ZoqakOrderDetailDataResponseToJson(
        ZoqakOrderDetailDataResponse instance) =>
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
      'offers': instance.offers,
      'stages': instance.stages,
      'stagesSummary': instance.stagesSummary,
    };
