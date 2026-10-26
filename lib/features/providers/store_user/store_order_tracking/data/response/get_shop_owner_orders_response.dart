import 'package:json_annotation/json_annotation.dart';
import '../../../../../../constants/response_constants/response_constants.dart';

part 'get_shop_owner_orders_response.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Buyer sub-object
// ─────────────────────────────────────────────────────────────────────────────

@JsonSerializable()
class ShopOrderBuyerResponse {
  @JsonKey(name: ResponseConstants.entityId)
  String? id;

  @JsonKey(name: ResponseConstants.fullName)
  String? fullName;

  @JsonKey(name: ResponseConstants.phoneNumber)
  String? phoneNumber;

  @JsonKey(name: ResponseConstants.image)
  String? image;

  ShopOrderBuyerResponse({
    this.id,
    this.fullName,
    this.phoneNumber,
    this.image,
  });

  factory ShopOrderBuyerResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopOrderBuyerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShopOrderBuyerResponseToJson(this);
}

// ─────────────────────────────────────────────────────────────────────────────
// Item sub-object
// ─────────────────────────────────────────────────────────────────────────────

@JsonSerializable()
class ShopOrderItemResponse {
  @JsonKey(name: ResponseConstants.entityId)
  String? id;

  @JsonKey(name: ResponseConstants.productId)
  String? productId;

  @JsonKey(name: ResponseConstants.variantId)
  String? variantId;

  @JsonKey(name: ResponseConstants.productName)
  String? productName;

  @JsonKey(name: ResponseConstants.color)
  String? color;

  @JsonKey(name: ResponseConstants.size)
  String? size;

  @JsonKey(name: ResponseConstants.quantity)
  int? quantity;

  @JsonKey(name: ResponseConstants.unitPrice)
  num? unitPrice;

  @JsonKey(name: ResponseConstants.totalPrice)
  num? totalPrice;

  ShopOrderItemResponse({
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

  factory ShopOrderItemResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopOrderItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShopOrderItemResponseToJson(this);
}

// ─────────────────────────────────────────────────────────────────────────────
// Stage sub-object
// ─────────────────────────────────────────────────────────────────────────────

@JsonSerializable()
class ShopOrderStageResponse {
  @JsonKey(name: ResponseConstants.stageKey)
  String? key;

  @JsonKey(name: ResponseConstants.stageLabel)
  String? label;

  @JsonKey(name: ResponseConstants.stageCompleted)
  bool? completed;

  @JsonKey(name: ResponseConstants.stageStatusDate)
  String? statusDate;

  ShopOrderStageResponse({
    this.key,
    this.label,
    this.completed,
    this.statusDate,
  });

  factory ShopOrderStageResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopOrderStageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShopOrderStageResponseToJson(this);
}

// ─────────────────────────────────────────────────────────────────────────────
// Stages summary sub-object
// ─────────────────────────────────────────────────────────────────────────────

@JsonSerializable()
class ShopOrderStagesSummaryResponse {
  @JsonKey(name: ResponseConstants.totalStages)
  int? totalStages;

  @JsonKey(name: ResponseConstants.completedStagesCount)
  int? completedStagesCount;

  @JsonKey(name: ResponseConstants.incompleteStagesCount)
  int? incompleteStagesCount;

  ShopOrderStagesSummaryResponse({
    this.totalStages,
    this.completedStagesCount,
    this.incompleteStagesCount,
  });

  factory ShopOrderStagesSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopOrderStagesSummaryResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ShopOrderStagesSummaryResponseToJson(this);
}

// ─────────────────────────────────────────────────────────────────────────────
// Single order data object
// ─────────────────────────────────────────────────────────────────────────────

@JsonSerializable()
class ShopOrderDataResponse {
  @JsonKey(name: ResponseConstants.entityId)
  String? id;

  @JsonKey(name: ResponseConstants.orderNumber)
  String? orderNumber;

  @JsonKey(name: ResponseConstants.buyerId)
  String? buyerId;

  @JsonKey(name: ResponseConstants.orderStatus)
  String? status;

  @JsonKey(name: ResponseConstants.paymentStatus)
  String? paymentStatus;

  @JsonKey(name: ResponseConstants.totalAmount)
  num? totalAmount;

  @JsonKey(name: ResponseConstants.itemsCount)
  int? itemsCount;

  @JsonKey(name: ResponseConstants.createdAt)
  String? createdAt;

  @JsonKey(name: ResponseConstants.updatedAt)
  String? updatedAt;

  @JsonKey(name: ResponseConstants.buyer)
  ShopOrderBuyerResponse? buyer;

  @JsonKey(name: ResponseConstants.items)
  List<ShopOrderItemResponse>? items;

  @JsonKey(name: ResponseConstants.stages)
  List<ShopOrderStageResponse>? stages;

  @JsonKey(name: ResponseConstants.stagesSummary)
  ShopOrderStagesSummaryResponse? stagesSummary;

  ShopOrderDataResponse({
    this.id,
    this.orderNumber,
    this.buyerId,
    this.status,
    this.paymentStatus,
    this.totalAmount,
    this.itemsCount,
    this.createdAt,
    this.updatedAt,
    this.buyer,
    this.items,
    this.stages,
    this.stagesSummary,
  });

  factory ShopOrderDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopOrderDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShopOrderDataResponseToJson(this);
}

// ─────────────────────────────────────────────────────────────────────────────
// Top-level response wrapper
// ─────────────────────────────────────────────────────────────────────────────

@JsonSerializable()
class GetShopOwnerOrdersResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;

  @JsonKey(name: ResponseConstants.code)
  int? code;

  @JsonKey(name: ResponseConstants.data)
  List<ShopOrderDataResponse>? data;

  @JsonKey(name: ResponseConstants.message)
  String? message;

  GetShopOwnerOrdersResponse({
    this.status,
    this.code,
    this.data,
    this.message,
  });

  factory GetShopOwnerOrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$GetShopOwnerOrdersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetShopOwnerOrdersResponseToJson(this);
}
