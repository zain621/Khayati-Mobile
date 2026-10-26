import 'package:json_annotation/json_annotation.dart';
import '../../../../../../constants/response_constants/response_constants.dart';

part 'get_orders_response.g.dart';

/// Inner data object for a single order in the list.
@JsonSerializable()
class OrderDataResponse {
  @JsonKey(name: ResponseConstants.entityId)
  String? id;

  @JsonKey(name: ResponseConstants.orderNumber)
  String? orderNumber;

  @JsonKey(name: ResponseConstants.productName)
  String? productName;

  @JsonKey(name: ResponseConstants.description)
  String? description;

  @JsonKey(name: ResponseConstants.specialRequests)
  String? specialRequests;

  @JsonKey(name: ResponseConstants.fabricType)
  String? fabricType;

  @JsonKey(name: ResponseConstants.minExpectedBudget)
  num? minExpectedBudget;

  @JsonKey(name: ResponseConstants.maxExpectedBudget)
  num? maxExpectedBudget;

  @JsonKey(name: ResponseConstants.deliveryDate)
  String? deliveryDate;

  @JsonKey(name: ResponseConstants.similarImages)
  List<String>? similarImages;

  @JsonKey(name: ResponseConstants.orderStatus)
  String? status;

  @JsonKey(name: ResponseConstants.createdAt)
  String? createdAt;

  @JsonKey(name: ResponseConstants.userName)
  String? userName;

  @JsonKey(name: ResponseConstants.userImage)
  String? userImage;

  @JsonKey(name: ResponseConstants.offersCount)
  int? offersCount;

  OrderDataResponse({
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
  });

  factory OrderDataResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDataResponseToJson(this);
}

/// Top-level orders list response wrapper.
@JsonSerializable()
class GetOrdersResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;

  @JsonKey(name: ResponseConstants.code)
  int? code;

  @JsonKey(name: ResponseConstants.message)
  String? message;

  @JsonKey(name: ResponseConstants.data)
  List<OrderDataResponse>? data;

  GetOrdersResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory GetOrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$GetOrdersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetOrdersResponseToJson(this);
}
