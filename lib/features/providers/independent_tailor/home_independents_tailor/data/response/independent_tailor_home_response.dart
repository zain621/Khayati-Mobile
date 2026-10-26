import 'package:json_annotation/json_annotation.dart';
import '../../../../../../constants/response_constants/response_constants.dart';

part 'independent_tailor_home_response.g.dart';

// ── Main wrapper ─────────────────────────────────────────────────────────────

@JsonSerializable()
class IndependentTailorHomeResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  @JsonKey(name: ResponseConstants.data)
  final IndependentTailorHomeDataResponse? data;

  IndependentTailorHomeResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory IndependentTailorHomeResponse.fromJson(Map<String, dynamic> json) =>
      _$IndependentTailorHomeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$IndependentTailorHomeResponseToJson(this);
}

// ── Flat data object ─────────────────────────────────────────────────────────

@JsonSerializable()
class IndependentTailorHomeDataResponse {
  @JsonKey(name: ResponseConstants.shopOwnerShopStatus)
  final String? shopStatus;

  @JsonKey(name: ResponseConstants.isAcceptingOrders)
  final bool? isAcceptingOrders;

  @JsonKey(name: ResponseConstants.withdrawableBalance)
  final double? withdrawableBalance;

  @JsonKey(name: ResponseConstants.lastLoginAt)
  final String? lastLoginAt;

  @JsonKey(name: ResponseConstants.reviews)
  final List<IndependentTailorHomeReviewResponse>? reviews;

  @JsonKey(name: ResponseConstants.averageRating)
  final double? averageRating;

  @JsonKey(name: ResponseConstants.reviewsCount)
  final int? reviewsCount;

  @JsonKey(name: ResponseConstants.rank)
  final String? rank;

  @JsonKey(name: ResponseConstants.rankLabel)
  final String? rankLabel;

  @JsonKey(name: ResponseConstants.isAvailable)
  final bool? isAvailable;

  @JsonKey(name: ResponseConstants.zoqakOrdersCount)
  final int? zoqakOrdersCount;

  @JsonKey(name: ResponseConstants.zoqakAvailableForOffersCount)
  final int? zoqakAvailableForOffersCount;

  IndependentTailorHomeDataResponse({
    this.shopStatus,
    this.isAcceptingOrders,
    this.withdrawableBalance,
    this.lastLoginAt,
    this.reviews,
    this.averageRating,
    this.reviewsCount,
    this.rank,
    this.rankLabel,
    this.isAvailable,
    this.zoqakOrdersCount,
    this.zoqakAvailableForOffersCount,
  });

  factory IndependentTailorHomeDataResponse.fromJson(
          Map<String, dynamic> json) =>
      _$IndependentTailorHomeDataResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$IndependentTailorHomeDataResponseToJson(this);
}

// ── Review sub-item ──────────────────────────────────────────────────────────

@JsonSerializable()
class IndependentTailorHomeReviewResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.orderId)
  final String? orderId;

  @JsonKey(name: ResponseConstants.rating)
  final int? rating;

  @JsonKey(name: ResponseConstants.comment)
  final String? comment;

  @JsonKey(name: ResponseConstants.imageUrl)
  final String? imageUrl;

  @JsonKey(name: ResponseConstants.buyerName)
  final String? buyerName;

  @JsonKey(name: ResponseConstants.createdAt)
  final String? createdAt;

  IndependentTailorHomeReviewResponse({
    this.id,
    this.orderId,
    this.rating,
    this.comment,
    this.imageUrl,
    this.buyerName,
    this.createdAt,
  });

  factory IndependentTailorHomeReviewResponse.fromJson(
          Map<String, dynamic> json) =>
      _$IndependentTailorHomeReviewResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$IndependentTailorHomeReviewResponseToJson(this);
}

// ── Availability PATCH response ───────────────────────────────────────────────

@JsonSerializable()
class ChangeIndependentTailorAvailabilityResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  @JsonKey(name: ResponseConstants.data)
  final ChangeIndependentTailorAvailabilityDataResponse? data;

  ChangeIndependentTailorAvailabilityResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory ChangeIndependentTailorAvailabilityResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ChangeIndependentTailorAvailabilityResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ChangeIndependentTailorAvailabilityResponseToJson(this);
}

@JsonSerializable()
class ChangeIndependentTailorAvailabilityDataResponse {
  @JsonKey(name: ResponseConstants.isAcceptingOrders)
  final bool? isAcceptingOrders;

  ChangeIndependentTailorAvailabilityDataResponse({this.isAcceptingOrders});

  factory ChangeIndependentTailorAvailabilityDataResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ChangeIndependentTailorAvailabilityDataResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ChangeIndependentTailorAvailabilityDataResponseToJson(this);
}
