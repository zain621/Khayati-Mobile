import 'package:json_annotation/json_annotation.dart';
import '../../../../../../constants/response_constants/response_constants.dart';

part 'get_comprehensive_reviews_response.g.dart';

/// Reviewer info embedded in each comprehensive review item.
@JsonSerializable()
class ReviewerResponse {
  @JsonKey(name: ResponseConstants.entityId)
  String? id;

  @JsonKey(name: ResponseConstants.fullName)
  String? fullName;

  @JsonKey(name: ResponseConstants.image)
  String? image;

  ReviewerResponse({this.id, this.fullName, this.image});

  factory ReviewerResponse.fromJson(Map<String, dynamic> json) =>
      _$ReviewerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewerResponseToJson(this);
}

/// Product attached to a shop-type review.
@JsonSerializable()
class ReviewProductResponse {
  @JsonKey(name: ResponseConstants.productId)
  String? productId;

  @JsonKey(name: ResponseConstants.productName)
  String? productName;

  @JsonKey(name: ResponseConstants.quantity)
  int? quantity;

  ReviewProductResponse({this.productId, this.productName, this.quantity});

  factory ReviewProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ReviewProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewProductResponseToJson(this);
}

/// Single review item from /comprehensive-tailor/orders/reviews
@JsonSerializable()
class ComprehensiveReviewItemResponse {
  @JsonKey(name: ResponseConstants.reviewType)
  String? type;

  @JsonKey(name: ResponseConstants.reviewId)
  String? reviewId;

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

  @JsonKey(name: ResponseConstants.reviewer)
  ReviewerResponse? reviewer;

  @JsonKey(name: 'products')
  List<ReviewProductResponse>? products;

  ComprehensiveReviewItemResponse({
    this.type,
    this.reviewId,
    this.orderId,
    this.orderNumber,
    this.rating,
    this.comment,
    this.imageUrl,
    this.createdAt,
    this.reviewer,
    this.products,
  });

  factory ComprehensiveReviewItemResponse.fromJson(Map<String, dynamic> json) =>
      _$ComprehensiveReviewItemResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ComprehensiveReviewItemResponseToJson(this);
}

/// Paginated data wrapper for comprehensive reviews.
@JsonSerializable()
class ComprehensiveReviewsDataResponse {
  @JsonKey(name: ResponseConstants.items)
  List<ComprehensiveReviewItemResponse>? items;

  @JsonKey(name: ResponseConstants.total)
  int? total;

  @JsonKey(name: ResponseConstants.limit)
  int? limit;

  @JsonKey(name: ResponseConstants.offset)
  int? offset;

  ComprehensiveReviewsDataResponse({
    this.items,
    this.total,
    this.limit,
    this.offset,
  });

  factory ComprehensiveReviewsDataResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ComprehensiveReviewsDataResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ComprehensiveReviewsDataResponseToJson(this);
}

/// Top-level response: { "data": { "items": [...], "total", "limit", "offset" } }
@JsonSerializable()
class GetComprehensiveReviewsResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;

  @JsonKey(name: ResponseConstants.code)
  int? code;

  @JsonKey(name: ResponseConstants.message)
  String? message;

  @JsonKey(name: ResponseConstants.data)
  ComprehensiveReviewsDataResponse? data;

  GetComprehensiveReviewsResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory GetComprehensiveReviewsResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetComprehensiveReviewsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetComprehensiveReviewsResponseToJson(this);
}
