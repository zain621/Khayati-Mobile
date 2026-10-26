import 'package:json_annotation/json_annotation.dart';
import '../../../../../constants/response_constants/response_constants.dart';

part 'create_order_response.g.dart';

/// Inner data object returned from POST /zoqak.
@JsonSerializable()
class CreateOrderDataResponse {
  @JsonKey(name: ResponseConstants.id)
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

  CreateOrderDataResponse({
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
  });

  factory CreateOrderDataResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderDataResponseToJson(this);
}

/// Top-level wrapper for POST /zoqak response.
@JsonSerializable()
class CreateOrderResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;

  @JsonKey(name: ResponseConstants.code)
  int? code;

  @JsonKey(name: ResponseConstants.message)
  String? message;

  @JsonKey(name: ResponseConstants.data)
  CreateOrderDataResponse? data;

  CreateOrderResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory CreateOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderResponseToJson(this);
}
