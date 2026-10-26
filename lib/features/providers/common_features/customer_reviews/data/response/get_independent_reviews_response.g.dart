// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_independent_reviews_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndependentReviewItemResponse _$IndependentReviewItemResponseFromJson(
        Map<String, dynamic> json) =>
    IndependentReviewItemResponse(
      id: json['id'] as String?,
      orderId: json['orderId'] as String?,
      orderNumber: json['orderNumber'] as String?,
      rating: (json['rating'] as num?)?.toInt(),
      comment: json['comment'] as String?,
      imageUrl: json['imageUrl'] as String?,
      createdAt: json['createdAt'] as String?,
      reviewerName: json['reviewerName'] as String?,
      reviewerImage: json['reviewerImage'] as String?,
    );

Map<String, dynamic> _$IndependentReviewItemResponseToJson(
        IndependentReviewItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'orderNumber': instance.orderNumber,
      'rating': instance.rating,
      'comment': instance.comment,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt,
      'reviewerName': instance.reviewerName,
      'reviewerImage': instance.reviewerImage,
    };

GetIndependentReviewsResponse _$GetIndependentReviewsResponseFromJson(
        Map<String, dynamic> json) =>
    GetIndependentReviewsResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              IndependentReviewItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetIndependentReviewsResponseToJson(
        GetIndependentReviewsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
