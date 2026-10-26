// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'independent_tailor_home_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndependentTailorHomeResponse _$IndependentTailorHomeResponseFromJson(
        Map<String, dynamic> json) =>
    IndependentTailorHomeResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : IndependentTailorHomeDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IndependentTailorHomeResponseToJson(
        IndependentTailorHomeResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

IndependentTailorHomeDataResponse _$IndependentTailorHomeDataResponseFromJson(
        Map<String, dynamic> json) =>
    IndependentTailorHomeDataResponse(
      shopStatus: json['shopStatus'] as String?,
      isAcceptingOrders: json['isAcceptingOrders'] as bool?,
      withdrawableBalance: (json['withdrawableBalance'] as num?)?.toDouble(),
      lastLoginAt: json['lastLoginAt'] as String?,
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => IndependentTailorHomeReviewResponse.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      reviewsCount: (json['reviewsCount'] as num?)?.toInt(),
      rank: json['rank'] as String?,
      rankLabel: json['rankLabel'] as String?,
      isAvailable: json['isAvailable'] as bool?,
      zoqakOrdersCount: (json['zoqakOrdersCount'] as num?)?.toInt(),
      zoqakAvailableForOffersCount:
          (json['zoqakAvailableForOffersCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$IndependentTailorHomeDataResponseToJson(
        IndependentTailorHomeDataResponse instance) =>
    <String, dynamic>{
      'shopStatus': instance.shopStatus,
      'isAcceptingOrders': instance.isAcceptingOrders,
      'withdrawableBalance': instance.withdrawableBalance,
      'lastLoginAt': instance.lastLoginAt,
      'reviews': instance.reviews,
      'averageRating': instance.averageRating,
      'reviewsCount': instance.reviewsCount,
      'rank': instance.rank,
      'rankLabel': instance.rankLabel,
      'isAvailable': instance.isAvailable,
      'zoqakOrdersCount': instance.zoqakOrdersCount,
      'zoqakAvailableForOffersCount': instance.zoqakAvailableForOffersCount,
    };

IndependentTailorHomeReviewResponse
    _$IndependentTailorHomeReviewResponseFromJson(Map<String, dynamic> json) =>
        IndependentTailorHomeReviewResponse(
          id: json['id'] as String?,
          orderId: json['orderId'] as String?,
          rating: (json['rating'] as num?)?.toInt(),
          comment: json['comment'] as String?,
          imageUrl: json['imageUrl'] as String?,
          buyerName: json['buyerName'] as String?,
          createdAt: json['createdAt'] as String?,
        );

Map<String, dynamic> _$IndependentTailorHomeReviewResponseToJson(
        IndependentTailorHomeReviewResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'rating': instance.rating,
      'comment': instance.comment,
      'imageUrl': instance.imageUrl,
      'buyerName': instance.buyerName,
      'createdAt': instance.createdAt,
    };

ChangeIndependentTailorAvailabilityResponse
    _$ChangeIndependentTailorAvailabilityResponseFromJson(
            Map<String, dynamic> json) =>
        ChangeIndependentTailorAvailabilityResponse(
          status: json['status'] as String?,
          code: (json['code'] as num?)?.toInt(),
          message: json['message'] as String?,
          data: json['data'] == null
              ? null
              : ChangeIndependentTailorAvailabilityDataResponse.fromJson(
                  json['data'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$ChangeIndependentTailorAvailabilityResponseToJson(
        ChangeIndependentTailorAvailabilityResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

ChangeIndependentTailorAvailabilityDataResponse
    _$ChangeIndependentTailorAvailabilityDataResponseFromJson(
            Map<String, dynamic> json) =>
        ChangeIndependentTailorAvailabilityDataResponse(
          isAcceptingOrders: json['isAcceptingOrders'] as bool?,
        );

Map<String, dynamic> _$ChangeIndependentTailorAvailabilityDataResponseToJson(
        ChangeIndependentTailorAvailabilityDataResponse instance) =>
    <String, dynamic>{
      'isAcceptingOrders': instance.isAcceptingOrders,
    };
