import 'package:json_annotation/json_annotation.dart';
import '../../../../../../constants/response_constants/response_constants.dart';

part 'order_detail_response.g.dart';

/// Full order detail returned by GET /zoqak/{orderId}.
@JsonSerializable()
class OrderDetailDataResponse {
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

  @JsonKey(name: ResponseConstants.userImage)
  String? userImage;

  @JsonKey(name: ResponseConstants.offersCount)
  int? offersCount;

  OrderDetailDataResponse({
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

  factory OrderDetailDataResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailDataResponseToJson(this);
}

/// Top-level wrapper for the order detail endpoint.
@JsonSerializable()
class OrderDetailResponse {
  @JsonKey(name: ResponseConstants.data)
  OrderDetailDataResponse? data;

  OrderDetailResponse({this.data});

  factory OrderDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailResponseToJson(this);
}
