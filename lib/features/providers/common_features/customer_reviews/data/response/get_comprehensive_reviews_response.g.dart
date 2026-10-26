// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_comprehensive_reviews_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewerResponse _$ReviewerResponseFromJson(Map<String, dynamic> json) =>
    ReviewerResponse(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$ReviewerResponseToJson(ReviewerResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'image': instance.image,
    };

ReviewProductResponse _$ReviewProductResponseFromJson(
        Map<String, dynamic> json) =>
    ReviewProductResponse(
      productId: json['productId'] as String?,
      productName: json['productName'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ReviewProductResponseToJson(
        ReviewProductResponse instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'quantity': instance.quantity,
    };

ComprehensiveReviewItemResponse _$ComprehensiveReviewItemResponseFromJson(
        Map<String, dynamic> json) =>
    ComprehensiveReviewItemResponse(
      type: json['type'] as String?,
      reviewId: json['reviewId'] as String?,
      orderId: json['orderId'] as String?,
      orderNumber: json['orderNumber'] as String?,
      rating: (json['rating'] as num?)?.toInt(),
      comment: json['comment'] as String?,
      imageUrl: json['imageUrl'] as String?,
      createdAt: json['createdAt'] as String?,
      reviewer: json['reviewer'] == null
          ? null
          : ReviewerResponse.fromJson(json['reviewer'] as Map<String, dynamic>),
      products: (json['products'] as List<dynamic>?)
          ?.map(
              (e) => ReviewProductResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ComprehensiveReviewItemResponseToJson(
        ComprehensiveReviewItemResponse instance) =>
    <String, dynamic>{
      'type': instance.type,
      'reviewId': instance.reviewId,
      'orderId': instance.orderId,
      'orderNumber': instance.orderNumber,
      'rating': instance.rating,
      'comment': instance.comment,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt,
      'reviewer': instance.reviewer,
      'products': instance.products,
    };

ComprehensiveReviewsDataResponse _$ComprehensiveReviewsDataResponseFromJson(
        Map<String, dynamic> json) =>
    ComprehensiveReviewsDataResponse(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ComprehensiveReviewItemResponse.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
      offset: (json['offset'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ComprehensiveReviewsDataResponseToJson(
        ComprehensiveReviewsDataResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
      'total': instance.total,
      'limit': instance.limit,
      'offset': instance.offset,
    };

GetComprehensiveReviewsResponse _$GetComprehensiveReviewsResponseFromJson(
        Map<String, dynamic> json) =>
    GetComprehensiveReviewsResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : ComprehensiveReviewsDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetComprehensiveReviewsResponseToJson(
        GetComprehensiveReviewsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
