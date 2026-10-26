import 'package:json_annotation/json_annotation.dart';
import '../../../../../constants/response_constants/response_constants.dart';

part 'checkout_response.g.dart';

@JsonSerializable()
class CheckoutResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.data)
  final CheckoutDataResponse? data;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  const CheckoutResponse({this.status, this.code, this.data, this.message});

  factory CheckoutResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckoutResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutResponseToJson(this);
}

@JsonSerializable()
class CheckoutDataResponse {
  @JsonKey(name: ResponseConstants.orders)
  final List<CheckoutOrderResponse>? orders;

  @JsonKey(name: ResponseConstants.payment)
  final CheckoutPaymentResponse? payment;

  @JsonKey(name: ResponseConstants.userLoyaltyPoints)
  final int? userLoyaltyPoints;

  const CheckoutDataResponse({
    this.orders,
    this.payment,
    this.userLoyaltyPoints,
  });

  factory CheckoutDataResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckoutDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutDataResponseToJson(this);
}

@JsonSerializable()
class CheckoutOrderResponse {
  @JsonKey(name: ResponseConstants.id)
  final String? id;

  @JsonKey(name: ResponseConstants.orderNumber)
  final String? orderNumber;

  @JsonKey(name: ResponseConstants.shopId)
  final String? shopId;

  @JsonKey(name: ResponseConstants.shopName)
  final String? shopName;

  @JsonKey(name: ResponseConstants.orderStatus)
  final String? status;

  @JsonKey(name: ResponseConstants.paymentStatus)
  final String? paymentStatus;

  @JsonKey(name: ResponseConstants.totalAmount)
  final double? totalAmount;

  @JsonKey(name: ResponseConstants.itemsCount)
  final int? itemsCount;

  @JsonKey(name: ResponseConstants.createdAt)
  final String? createdAt;

  const CheckoutOrderResponse({
    this.id,
    this.orderNumber,
    this.shopId,
    this.shopName,
    this.status,
    this.paymentStatus,
    this.totalAmount,
    this.itemsCount,
    this.createdAt,
  });

  factory CheckoutOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckoutOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutOrderResponseToJson(this);
}

@JsonSerializable()
class CheckoutPaymentResponse {
  @JsonKey(name: ResponseConstants.paymentSessionId)
  final String? paymentSessionId;

  @JsonKey(name: ResponseConstants.provider)
  final String? provider;

  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.paymentUrl)
  final String? paymentUrl;

  @JsonKey(name: ResponseConstants.invoiceUrl)
  final String? invoiceUrl;

  const CheckoutPaymentResponse({
    this.paymentSessionId,
    this.provider,
    this.status,
    this.paymentUrl,
    this.invoiceUrl,
  });

  factory CheckoutPaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckoutPaymentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutPaymentResponseToJson(this);
}
