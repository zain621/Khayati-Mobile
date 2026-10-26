// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_shop_owner_reviews_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingBreakdownResponse _$RatingBreakdownResponseFromJson(
        Map<String, dynamic> json) =>
    RatingBreakdownResponse(
      fiveStars: (json['fiveStars'] as num?)?.toInt(),
      fourStars: (json['fourStars'] as num?)?.toInt(),
      threeStars: (json['threeStars'] as num?)?.toInt(),
      twoStars: (json['twoStars'] as num?)?.toInt(),
      oneStar: (json['oneStar'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RatingBreakdownResponseToJson(
        RatingBreakdownResponse instance) =>
    <String, dynamic>{
      'fiveStars': instance.fiveStars,
      'fourStars': instance.fourStars,
      'threeStars': instance.threeStars,
      'twoStars': instance.twoStars,
      'oneStar': instance.oneStar,
    };

ShopReviewsSummaryResponse _$ShopReviewsSummaryResponseFromJson(
        Map<String, dynamic> json) =>
    ShopReviewsSummaryResponse(
      totalReviews: (json['totalReviews'] as num?)?.toInt(),
      averageRating: json['averageRating'] as num?,
      ratingBreakdown: json['ratingBreakdown'] == null
          ? null
          : RatingBreakdownResponse.fromJson(
              json['ratingBreakdown'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShopReviewsSummaryResponseToJson(
        ShopReviewsSummaryResponse instance) =>
    <String, dynamic>{
      'totalReviews': instance.totalReviews,
      'averageRating': instance.averageRating,
      'ratingBreakdown': instance.ratingBreakdown,
    };

ShopOwnerReviewItemResponse _$ShopOwnerReviewItemResponseFromJson(
        Map<String, dynamic> json) =>
    ShopOwnerReviewItemResponse(
      reviewId: json['reviewId'] as String?,
      orderId: json['orderId'] as String?,
      orderNumber: json['orderNumber'] as String?,
      rating: (json['rating'] as num?)?.toInt(),
      comment: json['comment'] as String?,
      imageUrl: json['imageUrl'] as String?,
      createdAt: json['createdAt'] as String?,
      reviewer: json['reviewer'] == null
          ? null
          : ReviewerShopOwnerResponse.fromJson(
              json['reviewer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShopOwnerReviewItemResponseToJson(
        ShopOwnerReviewItemResponse instance) =>
    <String, dynamic>{
      'reviewId': instance.reviewId,
      'orderId': instance.orderId,
      'orderNumber': instance.orderNumber,
      'rating': instance.rating,
      'comment': instance.comment,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt,
      'reviewer': instance.reviewer,
    };

ReviewerShopOwnerResponse _$ReviewerShopOwnerResponseFromJson(
        Map<String, dynamic> json) =>
    ReviewerShopOwnerResponse(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$ReviewerShopOwnerResponseToJson(
        ReviewerShopOwnerResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'image': instance.image,
    };

ShopReviewsPaginationResponse _$ShopReviewsPaginationResponseFromJson(
        Map<String, dynamic> json) =>
    ShopReviewsPaginationResponse(
      limit: (json['limit'] as num?)?.toInt(),
      offset: (json['offset'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ShopReviewsPaginationResponseToJson(
        ShopReviewsPaginationResponse instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'offset': instance.offset,
    };

ShopOwnerReviewsDataResponse _$ShopOwnerReviewsDataResponseFromJson(
        Map<String, dynamic> json) =>
    ShopOwnerReviewsDataResponse(
      summary: json['summary'] == null
          ? null
          : ShopReviewsSummaryResponse.fromJson(
              json['summary'] as Map<String, dynamic>),
      productInsights: json['productInsights'] as List<dynamic>?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) =>
              ShopOwnerReviewItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : ShopReviewsPaginationResponse.fromJson(
              json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShopOwnerReviewsDataResponseToJson(
        ShopOwnerReviewsDataResponse instance) =>
    <String, dynamic>{
      'summary': instance.summary,
      'productInsights': instance.productInsights,
      'items': instance.items,
      'pagination': instance.pagination,
    };

GetShopOwnerReviewsResponse _$GetShopOwnerReviewsResponseFromJson(
        Map<String, dynamic> json) =>
    GetShopOwnerReviewsResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : ShopOwnerReviewsDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetShopOwnerReviewsResponseToJson(
        GetShopOwnerReviewsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
