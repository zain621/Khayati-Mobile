import 'package:json_annotation/json_annotation.dart';
import '../../../../../../constants/response_constants/response_constants.dart';

part 'comprehensive_orders_response.g.dart';

// ─── Root wrapper ─────────────────────────────────────────────────────────────

@JsonSerializable()
class ComprehensiveOrdersResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  @JsonKey(name: ResponseConstants.data)
  final ComprehensiveOrdersDataResponse? data;

  const ComprehensiveOrdersResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory ComprehensiveOrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$ComprehensiveOrdersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ComprehensiveOrdersResponseToJson(this);
}

// ─── Data ─────────────────────────────────────────────────────────────────────

@JsonSerializable()
class ComprehensiveOrdersDataResponse {
  @JsonKey(name: ResponseConstants.shopOrders)
  final List<ComprehensiveShopOrderResponse>? shopOrders;

  @JsonKey(name: ResponseConstants.zoqakOrders)
  final List<ComprehensiveZoqakOrderResponse>? zoqakOrders;

  const ComprehensiveOrdersDataResponse({this.shopOrders, this.zoqakOrders});

  factory ComprehensiveOrdersDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ComprehensiveOrdersDataResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ComprehensiveOrdersDataResponseToJson(this);
}

// ─── Shop order ───────────────────────────────────────────────────────────────

@JsonSerializable()
class ComprehensiveShopOrderResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.orderNumber)
  final String? orderNumber;

  @JsonKey(name: ResponseConstants.orderStatus)
  final String? status;

  @JsonKey(name: ResponseConstants.paymentStatus)
  final String? paymentStatus;

  @JsonKey(name: ResponseConstants.totalAmount)
  final num? totalAmount;

  @JsonKey(name: ResponseConstants.itemsCount)
  final int? itemsCount;

  @JsonKey(name: ResponseConstants.createdAt)
  final String? createdAt;

  @JsonKey(name: ResponseConstants.buyer)
  final ComprehensiveBuyerResponse? buyer;

  @JsonKey(name: ResponseConstants.items)
  final List<ComprehensiveShopItemResponse>? items;

  @JsonKey(name: ResponseConstants.stages)
  final List<ComprehensiveStageResponse>? stages;

  @JsonKey(name: ResponseConstants.stagesSummary)
  final ComprehensiveStagesSummaryResponse? stagesSummary;

  const ComprehensiveShopOrderResponse({
    this.id,
    this.orderNumber,
    this.status,
    this.paymentStatus,
    this.totalAmount,
    this.itemsCount,
    this.createdAt,
    this.buyer,
    this.items,
    this.stages,
    this.stagesSummary,
  });

  factory ComprehensiveShopOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$ComprehensiveShopOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ComprehensiveShopOrderResponseToJson(this);
}

// ─── Buyer ────────────────────────────────────────────────────────────────────

@JsonSerializable()
class ComprehensiveBuyerResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.fullName)
  final String? fullName;

  @JsonKey(name: ResponseConstants.phoneNumber)
  final String? phoneNumber;

  @JsonKey(name: ResponseConstants.image)
  final String? image;

  const ComprehensiveBuyerResponse({
    this.id,
    this.fullName,
    this.phoneNumber,
    this.image,
  });

  factory ComprehensiveBuyerResponse.fromJson(Map<String, dynamic> json) =>
      _$ComprehensiveBuyerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ComprehensiveBuyerResponseToJson(this);
}

// ─── Shop order item ──────────────────────────────────────────────────────────

@JsonSerializable()
class ComprehensiveShopItemResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.productId)
  final String? productId;

  @JsonKey(name: ResponseConstants.variantId)
  final String? variantId;

  @JsonKey(name: ResponseConstants.productName)
  final String? productName;

  @JsonKey(name: ResponseConstants.color)
  final String? color;

  @JsonKey(name: ResponseConstants.size)
  final String? size;

  @JsonKey(name: ResponseConstants.quantity)
  final int? quantity;

  @JsonKey(name: ResponseConstants.unitPrice)
  final num? unitPrice;

  @JsonKey(name: ResponseConstants.totalPrice)
  final num? totalPrice;

  const ComprehensiveShopItemResponse({
    this.id,
    this.productId,
    this.variantId,
    this.productName,
    this.color,
    this.size,
    this.quantity,
    this.unitPrice,
    this.totalPrice,
  });

  factory ComprehensiveShopItemResponse.fromJson(Map<String, dynamic> json) =>
      _$ComprehensiveShopItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ComprehensiveShopItemResponseToJson(this);
}

// ─── Stage ────────────────────────────────────────────────────────────────────

@JsonSerializable()
class ComprehensiveStageResponse {
  @JsonKey(name: ResponseConstants.stageKey)
  final String? key;

  @JsonKey(name: ResponseConstants.stageLabel)
  final String? label;

  @JsonKey(name: ResponseConstants.stageCompleted)
  final bool? completed;

  @JsonKey(name: ResponseConstants.stageStatusDate)
  final String? statusDate;

  const ComprehensiveStageResponse({
    this.key,
    this.label,
    this.completed,
    this.statusDate,
  });

  factory ComprehensiveStageResponse.fromJson(Map<String, dynamic> json) =>
      _$ComprehensiveStageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ComprehensiveStageResponseToJson(this);
}

// ─── Stages summary ───────────────────────────────────────────────────────────

@JsonSerializable()
class ComprehensiveStagesSummaryResponse {
  @JsonKey(name: ResponseConstants.totalStages)
  final int? totalStages;

  @JsonKey(name: ResponseConstants.completedStagesCount)
  final int? completedStagesCount;

  @JsonKey(name: ResponseConstants.incompleteStagesCount)
  final int? incompleteStagesCount;

  const ComprehensiveStagesSummaryResponse({
    this.totalStages,
    this.completedStagesCount,
    this.incompleteStagesCount,
  });

  factory ComprehensiveStagesSummaryResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ComprehensiveStagesSummaryResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ComprehensiveStagesSummaryResponseToJson(this);
}

// ─── Zoqak order (on-flavor order) ───────────────────────────────────────────

@JsonSerializable()
class ComprehensiveZoqakOrderResponse {
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
  final num? minExpectedBudget;

  @JsonKey(name: ResponseConstants.maxExpectedBudget)
  final num? maxExpectedBudget;

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

  @JsonKey(name: ResponseConstants.userImage)
  final String? userImage;

  @JsonKey(name: ResponseConstants.offersCount)
  final int? offersCount;

  @JsonKey(name: ResponseConstants.paymentStatus)
  final String? paymentStatus;

  @JsonKey(name: ResponseConstants.acceptedByProviderId)
  final String? acceptedByProviderId;

  @JsonKey(name: ResponseConstants.userId)
  final String? userId;

  @JsonKey(name: ResponseConstants.myOffer)
  final ComprehensiveZoqakOfferResponse? myOffer;

  @JsonKey(name: ResponseConstants.timeline)
  final List<ComprehensiveTimelineEventResponse>? timeline;

  const ComprehensiveZoqakOrderResponse({
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
    this.userImage,
    this.offersCount,
    this.paymentStatus,
    this.acceptedByProviderId,
    this.userId,
    this.myOffer,
    this.timeline,
  });

  factory ComprehensiveZoqakOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$ComprehensiveZoqakOrderResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ComprehensiveZoqakOrderResponseToJson(this);
}

@JsonSerializable()
class ComprehensiveZoqakOfferResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.orderId)
  final String? orderId;

  @JsonKey(name: ResponseConstants.proposedPrice)
  final num? proposedPrice;

  @JsonKey(name: ResponseConstants.executionDays)
  final int? executionDays;

  @JsonKey(name: ResponseConstants.details)
  final String? details;

  @JsonKey(name: ResponseConstants.orderStatus)
  final String? status;

  @JsonKey(name: ResponseConstants.createdAt)
  final String? createdAt;

  @JsonKey(name: ResponseConstants.updatedAt)
  final String? updatedAt;

  const ComprehensiveZoqakOfferResponse({
    this.id,
    this.orderId,
    this.proposedPrice,
    this.executionDays,
    this.details,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory ComprehensiveZoqakOfferResponse.fromJson(Map<String, dynamic> json) =>
      _$ComprehensiveZoqakOfferResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ComprehensiveZoqakOfferResponseToJson(this);
}

@JsonSerializable()
class ComprehensiveTimelineEventResponse {
  @JsonKey(name: ResponseConstants.code)
  final String? code;

  @JsonKey(name: ResponseConstants.occurredAt)
  final String? occurredAt;

  const ComprehensiveTimelineEventResponse({
    this.code,
    this.occurredAt,
  });

  factory ComprehensiveTimelineEventResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ComprehensiveTimelineEventResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ComprehensiveTimelineEventResponseToJson(this);
}

// ─── Zoqak offer-by-order (GET /my-offers/by-order/:id) ──────────────────────

@JsonSerializable()
class ZoqakMyOfferByOrderResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  @JsonKey(name: ResponseConstants.data)
  final ZoqakMyOfferByOrderDataResponse? data;

  const ZoqakMyOfferByOrderResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory ZoqakMyOfferByOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$ZoqakMyOfferByOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ZoqakMyOfferByOrderResponseToJson(this);
}

@JsonSerializable()
class ZoqakMyOfferByOrderDataResponse {
  @JsonKey(name: ResponseConstants.offer)
  final ComprehensiveZoqakOfferResponse? offer;

  @JsonKey(name: ResponseConstants.order)
  final ZoqakDetailOrderResponse? order;

  @JsonKey(name: ResponseConstants.timeline)
  final List<ComprehensiveTimelineEventResponse>? timeline;

  const ZoqakMyOfferByOrderDataResponse({
    this.offer,
    this.order,
    this.timeline,
  });

  factory ZoqakMyOfferByOrderDataResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ZoqakMyOfferByOrderDataResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ZoqakMyOfferByOrderDataResponseToJson(this);
}

@JsonSerializable()
class ZoqakDetailOrderResponse {
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
  final num? minExpectedBudget;

  @JsonKey(name: ResponseConstants.maxExpectedBudget)
  final num? maxExpectedBudget;

  @JsonKey(name: ResponseConstants.deliveryDate)
  final String? deliveryDate;

  @JsonKey(name: ResponseConstants.similarImages)
  final List<String>? similarImages;

  @JsonKey(name: ResponseConstants.orderStatus)
  final String? status;

  @JsonKey(name: ResponseConstants.paymentStatus)
  final String? paymentStatus;

  @JsonKey(name: ResponseConstants.acceptedByProviderId)
  final String? acceptedByProviderId;

  @JsonKey(name: ResponseConstants.requester)
  final ZoqakRequesterResponse? requester;

  @JsonKey(name: ResponseConstants.totalOffersOnOrder)
  final int? totalOffersOnOrder;

  const ZoqakDetailOrderResponse({
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
    this.paymentStatus,
    this.acceptedByProviderId,
    this.requester,
    this.totalOffersOnOrder,
  });

  factory ZoqakDetailOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$ZoqakDetailOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ZoqakDetailOrderResponseToJson(this);
}

@JsonSerializable()
class ZoqakRequesterResponse {
  @JsonKey(name: ResponseConstants.fullName)
  final String? fullName;

  @JsonKey(name: ResponseConstants.image)
  final String? image;

  @JsonKey(name: ResponseConstants.phoneNumber)
  final String? phoneNumber;

  const ZoqakRequesterResponse({
    this.fullName,
    this.image,
    this.phoneNumber,
  });

  factory ZoqakRequesterResponse.fromJson(Map<String, dynamic> json) =>
      _$ZoqakRequesterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ZoqakRequesterResponseToJson(this);
}
