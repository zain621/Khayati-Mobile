import 'package:json_annotation/json_annotation.dart';
import '../../../../../../constants/response_constants/response_constants.dart';

part 'order_tracking_response.g.dart';

// ── Fetch my accepted orders ─────────────────────────────────────────────────

@JsonSerializable()
class MyOrdersResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;
  @JsonKey(name: ResponseConstants.code)
  int? code;
  @JsonKey(name: ResponseConstants.message)
  String? message;
  @JsonKey(name: ResponseConstants.data)
  MyOrdersDataResponse? data;

  MyOrdersResponse({this.status, this.code, this.message, this.data});

  factory MyOrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$MyOrdersResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MyOrdersResponseToJson(this);
}

@JsonSerializable()
class MyOrdersDataResponse {
  @JsonKey(name: ResponseConstants.items)
  List<MyOrderItemResponse>? items;
  @JsonKey(name: ResponseConstants.counts)
  OrderCountsResponse? counts;

  MyOrdersDataResponse({this.items, this.counts});

  factory MyOrdersDataResponse.fromJson(Map<String, dynamic> json) =>
      _$MyOrdersDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MyOrdersDataResponseToJson(this);
}

@JsonSerializable()
class MyOrderItemResponse {
  @JsonKey(name: ResponseConstants.orderId)
  String? orderId;
  @JsonKey(name: ResponseConstants.orderNumber)
  String? orderNumber;
  @JsonKey(name: ResponseConstants.userName)
  String? userName;
  @JsonKey(name: ResponseConstants.userImage)
  String? userImage;
  @JsonKey(name: ResponseConstants.price)
  double? price;
  @JsonKey(name: ResponseConstants.statusPayment)
  String? statusPayment;
  @JsonKey(name: ResponseConstants.orderStatus)
  String? status;
  @JsonKey(name: ResponseConstants.stages)
  List<OrderStageResponse>? stages;
  @JsonKey(name: ResponseConstants.stagesSummary)
  OrderStagesSummaryResponse? stagesSummary;
  @JsonKey(name: ResponseConstants.latestStatus)
  OrderLatestStatusResponse? latestStatus;
  @JsonKey(name: ResponseConstants.orderDate)
  String? orderDate;
  @JsonKey(name: ResponseConstants.deliveryDeadline)
  String? deliveryDeadline;

  MyOrderItemResponse({
    this.orderId,
    this.orderNumber,
    this.userName,
    this.userImage,
    this.price,
    this.statusPayment,
    this.status,
    this.stages,
    this.stagesSummary,
    this.latestStatus,
    this.orderDate,
    this.deliveryDeadline,
  });

  factory MyOrderItemResponse.fromJson(Map<String, dynamic> json) =>
      _$MyOrderItemResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MyOrderItemResponseToJson(this);
}

@JsonSerializable()
class OrderStageResponse {
  @JsonKey(name: ResponseConstants.stageKey)
  String? key;
  @JsonKey(name: ResponseConstants.stageLabel)
  String? label;
  @JsonKey(name: ResponseConstants.stageCompleted)
  bool? completed;
  @JsonKey(name: ResponseConstants.stageStatusDate)
  String? statusDate;

  OrderStageResponse({this.key, this.label, this.completed, this.statusDate});

  factory OrderStageResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderStageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrderStageResponseToJson(this);
}

@JsonSerializable()
class OrderStagesSummaryResponse {
  @JsonKey(name: ResponseConstants.totalStages)
  int? totalStages;
  @JsonKey(name: ResponseConstants.completedStagesCount)
  int? completedStagesCount;
  @JsonKey(name: ResponseConstants.incompleteStagesCount)
  int? incompleteStagesCount;

  OrderStagesSummaryResponse({
    this.totalStages,
    this.completedStagesCount,
    this.incompleteStagesCount,
  });

  factory OrderStagesSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderStagesSummaryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrderStagesSummaryResponseToJson(this);
}

@JsonSerializable()
class OrderLatestStatusResponse {
  @JsonKey(name: ResponseConstants.stageKey)
  String? key;
  @JsonKey(name: ResponseConstants.stageLabel)
  String? label;
  @JsonKey(name: ResponseConstants.stageStatusDate)
  String? statusDate;

  OrderLatestStatusResponse({this.key, this.label, this.statusDate});

  factory OrderLatestStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderLatestStatusResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrderLatestStatusResponseToJson(this);
}

@JsonSerializable()
class OrderCountsResponse {
  @JsonKey(name: 'all')
  int? all;
  @JsonKey(name: 'accepted')
  int? accepted;
  @JsonKey(name: 'in_progress')
  int? inProgress;
  @JsonKey(name: 'ready')
  int? ready;
  @JsonKey(name: 'ready_for_delivery')
  int? readyForDelivery;
  @JsonKey(name: 'completed')
  int? completed;

  OrderCountsResponse({
    this.all,
    this.accepted,
    this.inProgress,
    this.ready,
    this.readyForDelivery,
    this.completed,
  });

  factory OrderCountsResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderCountsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrderCountsResponseToJson(this);
}

// ── Update order status ──────────────────────────────────────────────────────

@JsonSerializable()
class UpdateOrderStatusResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;
  @JsonKey(name: ResponseConstants.code)
  int? code;
  @JsonKey(name: ResponseConstants.message)
  String? message;

  UpdateOrderStatusResponse({this.status, this.code, this.message});

  factory UpdateOrderStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateOrderStatusResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateOrderStatusResponseToJson(this);
}

// ── Accepted order detail ────────────────────────────────────────────────────

@JsonSerializable()
class AcceptedOrderDetailResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;
  @JsonKey(name: ResponseConstants.code)
  int? code;
  @JsonKey(name: ResponseConstants.message)
  String? message;
  @JsonKey(name: ResponseConstants.data)
  AcceptedOrderDetailDataResponse? data;

  AcceptedOrderDetailResponse({this.status, this.code, this.message, this.data});

  factory AcceptedOrderDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$AcceptedOrderDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AcceptedOrderDetailResponseToJson(this);
}

@JsonSerializable()
class AcceptedOrderDetailDataResponse {
  @JsonKey(name: ResponseConstants.orderId)
  String? orderId;
  @JsonKey(name: ResponseConstants.orderNumber)
  String? orderNumber;
  @JsonKey(name: ResponseConstants.orderStatus)
  String? status;
  @JsonKey(name: ResponseConstants.stages)
  List<OrderStageResponse>? stages;
  @JsonKey(name: ResponseConstants.stagesSummary)
  OrderStagesSummaryResponse? stagesSummary;
  @JsonKey(name: ResponseConstants.latestStatus)
  OrderLatestStatusResponse? latestStatus;
  @JsonKey(name: ResponseConstants.paymentStatus)
  String? paymentStatus;
  @JsonKey(name: ResponseConstants.orderDate)
  String? orderDate;
  @JsonKey(name: ResponseConstants.deliveryDeadline)
  String? deliveryDeadline;
  @JsonKey(name: ResponseConstants.userName)
  String? userName;
  @JsonKey(name: ResponseConstants.userImage)
  String? userImage;
  @JsonKey(name: ResponseConstants.userPhone)
  String? userPhone;
  @JsonKey(name: ResponseConstants.productName)
  String? productName;
  @JsonKey(name: ResponseConstants.description)
  String? description;
  @JsonKey(name: ResponseConstants.specialRequests)
  String? specialRequests;
  @JsonKey(name: ResponseConstants.fabricType)
  String? fabricType;
  @JsonKey(name: ResponseConstants.minExpectedBudget)
  double? minExpectedBudget;
  @JsonKey(name: ResponseConstants.maxExpectedBudget)
  double? maxExpectedBudget;
  @JsonKey(name: ResponseConstants.similarImages)
  List<String>? similarImages;
  @JsonKey(name: ResponseConstants.myOffer)
  AcceptedOrderMyOfferResponse? myOffer;

  AcceptedOrderDetailDataResponse({
    this.orderId,
    this.orderNumber,
    this.status,
    this.stages,
    this.stagesSummary,
    this.latestStatus,
    this.paymentStatus,
    this.orderDate,
    this.deliveryDeadline,
    this.userName,
    this.userImage,
    this.userPhone,
    this.productName,
    this.description,
    this.specialRequests,
    this.fabricType,
    this.minExpectedBudget,
    this.maxExpectedBudget,
    this.similarImages,
    this.myOffer,
  });

  factory AcceptedOrderDetailDataResponse.fromJson(Map<String, dynamic> json) =>
      _$AcceptedOrderDetailDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AcceptedOrderDetailDataResponseToJson(this);
}

@JsonSerializable()
class AcceptedOrderMyOfferResponse {
  @JsonKey(name: ResponseConstants.proposedPrice)
  double? proposedPrice;
  @JsonKey(name: ResponseConstants.executionDays)
  int? executionDays;
  @JsonKey(name: ResponseConstants.details)
  String? details;
  @JsonKey(name: ResponseConstants.createdAt)
  String? createdAt;

  AcceptedOrderMyOfferResponse({
    this.proposedPrice,
    this.executionDays,
    this.details,
    this.createdAt,
  });

  factory AcceptedOrderMyOfferResponse.fromJson(Map<String, dynamic> json) =>
      _$AcceptedOrderMyOfferResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AcceptedOrderMyOfferResponseToJson(this);
}
