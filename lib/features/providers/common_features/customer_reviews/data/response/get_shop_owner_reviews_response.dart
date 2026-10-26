import 'package:json_annotation/json_annotation.dart';
import '../../../../../../constants/response_constants/response_constants.dart';

part 'get_shop_owner_reviews_response.g.dart';

/// Rating breakdown object inside the summary.
@JsonSerializable()
class RatingBreakdownResponse {
  @JsonKey(name: ResponseConstants.fiveStars)
  int? fiveStars;

  @JsonKey(name: ResponseConstants.fourStars)
  int? fourStars;

  @JsonKey(name: ResponseConstants.threeStars)
  int? threeStars;

  @JsonKey(name: ResponseConstants.twoStars)
  int? twoStars;

  @JsonKey(name: ResponseConstants.oneStar)
  int? oneStar;

  RatingBreakdownResponse({
    this.fiveStars,
    this.fourStars,
    this.threeStars,
    this.twoStars,
    this.oneStar,
  });

  factory RatingBreakdownResponse.fromJson(Map<String, dynamic> json) =>
      _$RatingBreakdownResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RatingBreakdownResponseToJson(this);
}

/// Summary block returned for shop owner reviews.
@JsonSerializable()
class ShopReviewsSummaryResponse {
  @JsonKey(name: ResponseConstants.totalReviews)
  int? totalReviews;

  @JsonKey(name: ResponseConstants.averageRating)
  num? averageRating;

  @JsonKey(name: ResponseConstants.ratingBreakdown)
  RatingBreakdownResponse? ratingBreakdown;

  ShopReviewsSummaryResponse({
    this.totalReviews,
    this.averageRating,
    this.ratingBreakdown,
  });

  factory ShopReviewsSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopReviewsSummaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShopReviewsSummaryResponseToJson(this);
}

/// Single shop-owner review item (same shape as independent but no type/reviewer object).
@JsonSerializable()
class ShopOwnerReviewItemResponse {
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
  ReviewerShopOwnerResponse? reviewer;

  ShopOwnerReviewItemResponse({
    this.reviewId,
    this.orderId,
    this.orderNumber,
    this.rating,
    this.comment,
    this.imageUrl,
    this.createdAt,
    this.reviewer,
  });

  factory ShopOwnerReviewItemResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopOwnerReviewItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShopOwnerReviewItemResponseToJson(this);
}

/// Reviewer embedded in shop owner review items.
@JsonSerializable()
class ReviewerShopOwnerResponse {
  @JsonKey(name: ResponseConstants.entityId)
  String? id;

  @JsonKey(name: ResponseConstants.fullName)
  String? fullName;

  @JsonKey(name: ResponseConstants.image)
  String? image;

  ReviewerShopOwnerResponse({this.id, this.fullName, this.image});

  factory ReviewerShopOwnerResponse.fromJson(Map<String, dynamic> json) =>
      _$ReviewerShopOwnerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewerShopOwnerResponseToJson(this);
}

/// Pagination object for shop owner reviews.
@JsonSerializable()
class ShopReviewsPaginationResponse {
  @JsonKey(name: ResponseConstants.limit)
  int? limit;

  @JsonKey(name: ResponseConstants.offset)
  int? offset;

  ShopReviewsPaginationResponse({this.limit, this.offset});

  factory ShopReviewsPaginationResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopReviewsPaginationResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ShopReviewsPaginationResponseToJson(this);
}

/// Nested data object for shop owner reviews endpoint.
@JsonSerializable()
class ShopOwnerReviewsDataResponse {
  @JsonKey(name: ResponseConstants.summary)
  ShopReviewsSummaryResponse? summary;

  @JsonKey(name: ResponseConstants.productInsights)
  List<dynamic>? productInsights;

  @JsonKey(name: ResponseConstants.items)
  List<ShopOwnerReviewItemResponse>? items;

  @JsonKey(name: ResponseConstants.pagination)
  ShopReviewsPaginationResponse? pagination;

  ShopOwnerReviewsDataResponse({
    this.summary,
    this.productInsights,
    this.items,
    this.pagination,
  });

  factory ShopOwnerReviewsDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopOwnerReviewsDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShopOwnerReviewsDataResponseToJson(this);
}

/// Top-level response: { "data": { "summary": {...}, "items": [...], ... } }
@JsonSerializable()
class GetShopOwnerReviewsResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;

  @JsonKey(name: ResponseConstants.code)
  int? code;

  @JsonKey(name: ResponseConstants.message)
  String? message;

  @JsonKey(name: ResponseConstants.data)
  ShopOwnerReviewsDataResponse? data;

  GetShopOwnerReviewsResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory GetShopOwnerReviewsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetShopOwnerReviewsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetShopOwnerReviewsResponseToJson(this);
}
