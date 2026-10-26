import 'package:json_annotation/json_annotation.dart';
import '../../../../../constants/response_constants/response_constants.dart';
import 'user_orders_response.dart';

part 'zoqak_offers_response.g.dart';

// ─── Root wrapper (data is a list) ───────────────────────────────────────────

@JsonSerializable()
class ZoqakOffersResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.data)
  final List<ZoqakOfferItemResponse>? data;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  const ZoqakOffersResponse({
    this.status,
    this.code,
    this.data,
    this.message,
  });

  factory ZoqakOffersResponse.fromJson(Map<String, dynamic> json) =>
      _$ZoqakOffersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ZoqakOffersResponseToJson(this);
}

// ─── Single offer item ────────────────────────────────────────────────────────

@JsonSerializable()
class ZoqakOfferItemResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.orderId)
  final String? orderId;

  @JsonKey(name: ResponseConstants.providerId)
  final String? providerId;

  @JsonKey(name: ResponseConstants.proposedPrice)
  final dynamic proposedPrice;

  @JsonKey(name: ResponseConstants.executionDays)
  final int? executionDays;

  @JsonKey(name: ResponseConstants.details)
  final String? details;

  @JsonKey(name: ResponseConstants.orderStatus)
  final String? status;

  @JsonKey(name: ResponseConstants.createdAt)
  final String? createdAt;

  @JsonKey(name: ResponseConstants.providerName)
  final String? providerName;

  @JsonKey(name: ResponseConstants.providerImage)
  final String? providerImage;

  @JsonKey(name: ResponseConstants.providerIsAvailable)
  final bool? providerIsAvailable;

  @JsonKey(name: ResponseConstants.providerRank)
  final String? providerRank;

  @JsonKey(name: ResponseConstants.providerRankLabel)
  final String? providerRankLabel;

  @JsonKey(name: ResponseConstants.providerRating)
  final dynamic providerRating;

  @JsonKey(name: ResponseConstants.providerRatersCount)
  final int? providerRatersCount;

  @JsonKey(name: ResponseConstants.providerOffersCount)
  final int? providerOffersCount;

  @JsonKey(name: ResponseConstants.orderOffersCount)
  final int? orderOffersCount;

  const ZoqakOfferItemResponse({
    this.id,
    this.orderId,
    this.providerId,
    this.proposedPrice,
    this.executionDays,
    this.details,
    this.status,
    this.createdAt,
    this.providerName,
    this.providerImage,
    this.providerIsAvailable,
    this.providerRank,
    this.providerRankLabel,
    this.providerRating,
    this.providerRatersCount,
    this.providerOffersCount,
    this.orderOffersCount,
  });

  factory ZoqakOfferItemResponse.fromJson(Map<String, dynamic> json) =>
      _$ZoqakOfferItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ZoqakOfferItemResponseToJson(this);
}

// ─── Zoqak order detail response ─────────────────────────────────────────────

@JsonSerializable()
class ZoqakOrderDetailResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.data)
  final ZoqakOrderDetailDataResponse? data;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  const ZoqakOrderDetailResponse({
    this.status,
    this.code,
    this.data,
    this.message,
  });

  factory ZoqakOrderDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$ZoqakOrderDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ZoqakOrderDetailResponseToJson(this);
}

@JsonSerializable()
class ZoqakOrderDetailDataResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.orderNumber)
  final String? orderNumber;

  @JsonKey(name: ResponseConstants.productName)
  final String? productName;

  @JsonKey(name: ResponseConstants.description)
  final String? description;

  @JsonKey(name: ResponseConstants.specialRequests)
  final String? specialRequests;

  @JsonKey(name: ResponseConstants.fabricType)
  final String? fabricType;

  @JsonKey(name: ResponseConstants.minExpectedBudget)
  final dynamic minExpectedBudget;

  @JsonKey(name: ResponseConstants.maxExpectedBudget)
  final dynamic maxExpectedBudget;

  @JsonKey(name: ResponseConstants.deliveryDate)
  final String? deliveryDate;

  @JsonKey(name: ResponseConstants.similarImages)
  final List<String>? similarImages;

  @JsonKey(name: ResponseConstants.orderStatus)
  final String? status;

  @JsonKey(name: ResponseConstants.createdAt)
  final String? createdAt;

  @JsonKey(name: ResponseConstants.userName)
  final String? userName;

  @JsonKey(name: ResponseConstants.offers)
  final List<ZoqakOfferItemResponse>? offers;

  @JsonKey(name: ResponseConstants.stages)
  final List<OrderStageResponse>? stages;

  @JsonKey(name: ResponseConstants.stagesSummary)
  final StagesSummaryResponse? stagesSummary;

  const ZoqakOrderDetailDataResponse({
    this.id,
    this.orderNumber,
    this.productName,
    this.description,
    this.specialRequests,
    this.fabricType,
    this.minExpectedBudget,
    this.maxExpectedBudget,
    this.deliveryDate,
    this.similarImages,
    this.status,
    this.createdAt,
    this.userName,
    this.offers,
    this.stages,
    this.stagesSummary,
  });

  factory ZoqakOrderDetailDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ZoqakOrderDetailDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ZoqakOrderDetailDataResponseToJson(this);
}
