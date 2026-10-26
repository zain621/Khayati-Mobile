import 'package:json_annotation/json_annotation.dart';
import '../../../../../constants/response_constants/response_constants.dart';

part 'user_orders_response.g.dart';

// ─── Root wrapper ─────────────────────────────────────────────────────────────

@JsonSerializable()
class UserOrdersResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.data)
  final UserOrdersDataResponse? data;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  const UserOrdersResponse({
    this.status,
    this.code,
    this.data,
    this.message,
  });

  factory UserOrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$UserOrdersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserOrdersResponseToJson(this);
}

// ─── Data ─────────────────────────────────────────────────────────────────────

@JsonSerializable()
class UserOrdersDataResponse {
  @JsonKey(name: ResponseConstants.orders)
  final List<UserOrderItemResponse>? orders;

  @JsonKey(name: ResponseConstants.total)
  final int? total;

  const UserOrdersDataResponse({this.orders, this.total});

  factory UserOrdersDataResponse.fromJson(Map<String, dynamic> json) =>
      _$UserOrdersDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserOrdersDataResponseToJson(this);
}

// ─── Single order item ────────────────────────────────────────────────────────

@JsonSerializable()
class UserOrderItemResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.orderNumber)
  final String? orderNumber;

  @JsonKey(name: ResponseConstants.orderType)
  final String? orderType;

  @JsonKey(name: ResponseConstants.shopId)
  final String? shopId;

  @JsonKey(name: ResponseConstants.shopName)
  final String? shopName;

  @JsonKey(name: ResponseConstants.orderStatus)
  final String? status;

  @JsonKey(name: ResponseConstants.paymentStatus)
  final String? paymentStatus;

  @JsonKey(name: ResponseConstants.totalAmount)
  final dynamic totalAmount;

  @JsonKey(name: ResponseConstants.stages)
  final List<OrderStageResponse>? stages;

  @JsonKey(name: ResponseConstants.stagesSummary)
  final StagesSummaryResponse? stagesSummary;

  @JsonKey(name: ResponseConstants.items)
  final List<OrderItemLineResponse>? items;

  @JsonKey(name: ResponseConstants.zoqakData)
  final ZoqakDataResponse? zoqak;

  @JsonKey(name: ResponseConstants.acceptedByProviderId)
  final String? acceptedByProviderId;

  @JsonKey(name: ResponseConstants.acceptedByProviderName)
  final String? acceptedByProviderName;

  @JsonKey(name: ResponseConstants.createdAt)
  final String? createdAt;

  @JsonKey(name: ResponseConstants.updatedAt)
  final String? updatedAt;

  const UserOrderItemResponse({
    this.id,
    this.orderNumber,
    this.orderType,
    this.shopId,
    this.shopName,
    this.status,
    this.paymentStatus,
    this.totalAmount,
    this.stages,
    this.stagesSummary,
    this.items,
    this.zoqak,
    this.acceptedByProviderId,
    this.acceptedByProviderName,
    this.createdAt,
    this.updatedAt,
  });

  factory UserOrderItemResponse.fromJson(Map<String, dynamic> json) =>
      _$UserOrderItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserOrderItemResponseToJson(this);
}

// ─── Stage ────────────────────────────────────────────────────────────────────

@JsonSerializable()
class OrderStageResponse {
  @JsonKey(name: ResponseConstants.stageKey)
  final String? key;

  @JsonKey(name: ResponseConstants.stageLabel)
  final String? label;

  @JsonKey(name: ResponseConstants.stageCompleted)
  final bool? completed;

  @JsonKey(name: ResponseConstants.stageStatusDate)
  final String? statusDate;

  const OrderStageResponse({this.key, this.label, this.completed, this.statusDate});

  factory OrderStageResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderStageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderStageResponseToJson(this);
}

// ─── Stages Summary ───────────────────────────────────────────────────────────

@JsonSerializable()
class StagesSummaryResponse {
  @JsonKey(name: ResponseConstants.totalStages)
  final int? totalStages;

  @JsonKey(name: ResponseConstants.completedStagesCount)
  final int? completedStagesCount;

  @JsonKey(name: ResponseConstants.incompleteStagesCount)
  final int? incompleteStagesCount;

  const StagesSummaryResponse({
    this.totalStages,
    this.completedStagesCount,
    this.incompleteStagesCount,
  });

  factory StagesSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$StagesSummaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StagesSummaryResponseToJson(this);
}

// ─── Order item line (shop orders) ───────────────────────────────────────────

@JsonSerializable()
class OrderItemLineResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.productId)
  final String? productId;

  @JsonKey(name: ResponseConstants.productName)
  final String? productName;

  @JsonKey(name: ResponseConstants.variantId)
  final String? variantId;

  @JsonKey(name: ResponseConstants.color)
  final String? color;

  @JsonKey(name: ResponseConstants.size)
  final String? size;

  @JsonKey(name: ResponseConstants.quantity)
  final int? quantity;

  @JsonKey(name: ResponseConstants.unitPrice)
  final dynamic unitPrice;

  @JsonKey(name: ResponseConstants.totalPrice)
  final dynamic totalPrice;

  @JsonKey(name: ResponseConstants.imageUrl)
  final String? imageUrl;

  const OrderItemLineResponse({
    this.id,
    this.productId,
    this.productName,
    this.variantId,
    this.color,
    this.size,
    this.quantity,
    this.unitPrice,
    this.totalPrice,
    this.imageUrl,
  });

  factory OrderItemLineResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderItemLineResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemLineResponseToJson(this);
}

// ─── Zoqak data (custom tailoring orders) ────────────────────────────────────

@JsonSerializable()
class ZoqakDataResponse {
  @JsonKey(name: ResponseConstants.productName)
  final String? productName;

  @JsonKey(name: ResponseConstants.description)
  final String? description;

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

  @JsonKey(name: ResponseConstants.acceptedByProviderId)
  final String? acceptedByProviderId;

  const ZoqakDataResponse({
    this.productName,
    this.description,
    this.fabricType,
    this.minExpectedBudget,
    this.maxExpectedBudget,
    this.deliveryDate,
    this.similarImages,
    this.acceptedByProviderId,
  });

  factory ZoqakDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ZoqakDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ZoqakDataResponseToJson(this);
}
