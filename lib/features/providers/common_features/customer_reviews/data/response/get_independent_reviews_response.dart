import 'package:json_annotation/json_annotation.dart';
import '../../../../../../constants/response_constants/response_constants.dart';

part 'get_independent_reviews_response.g.dart';

/// Single review item from /independent-tailor/zoqak/my-reviews
@JsonSerializable()
class IndependentReviewItemResponse {
  @JsonKey(name: ResponseConstants.entityId)
  String? id;

  @JsonKey(name: ResponseConstants.orderId)
  String? orderId;

  @JsonKey(name: ResponseConstants.orderNumber)
  String? orderNumber;

  @JsonKey(name: ResponseConstants.rating)
  int? rating;

  @JsonKey(name: ResponseConstants.comment)
  String? comment;

  @JsonKey(name: ResponseConstants.imageUrl)
  String? imageUrl;

  @JsonKey(name: ResponseConstants.createdAt)
  String? createdAt;

  @JsonKey(name: ResponseConstants.reviewerName)
  String? reviewerName;

  @JsonKey(name: ResponseConstants.reviewerImage)
  String? reviewerImage;

  IndependentReviewItemResponse({
    this.id,
    this.orderId,
    this.orderNumber,
    this.rating,
    this.comment,
    this.imageUrl,
    this.createdAt,
    this.reviewerName,
    this.reviewerImage,
  });

  factory IndependentReviewItemResponse.fromJson(Map<String, dynamic> json) =>
      _$IndependentReviewItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$IndependentReviewItemResponseToJson(this);
}

/// Top-level response: { "data": [...] }
@JsonSerializable()
class GetIndependentReviewsResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;

  @JsonKey(name: ResponseConstants.code)
  int? code;

  @JsonKey(name: ResponseConstants.message)
  String? message;

  @JsonKey(name: ResponseConstants.data)
  List<IndependentReviewItemResponse>? data;

  GetIndependentReviewsResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory GetIndependentReviewsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetIndependentReviewsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetIndependentReviewsResponseToJson(this);
}
