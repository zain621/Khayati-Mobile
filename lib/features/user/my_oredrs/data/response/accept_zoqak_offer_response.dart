import 'package:json_annotation/json_annotation.dart';
import '../../../../../constants/response_constants/response_constants.dart';
import '../../../cart/data/response/checkout_response.dart';

part 'accept_zoqak_offer_response.g.dart';

@JsonSerializable()
class AcceptZoqakOfferResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  @JsonKey(name: ResponseConstants.data)
  final AcceptZoqakOfferDataResponse? data;

  const AcceptZoqakOfferResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory AcceptZoqakOfferResponse.fromJson(Map<String, dynamic> json) =>
      _$AcceptZoqakOfferResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AcceptZoqakOfferResponseToJson(this);
}

@JsonSerializable()
class AcceptZoqakOfferDataResponse {
  @JsonKey(name: 'offerId')
  final String? offerId;

  @JsonKey(name: 'orderId')
  final String? orderId;

  @JsonKey(name: ResponseConstants.payment)
  final CheckoutPaymentResponse? payment;

  const AcceptZoqakOfferDataResponse({
    this.offerId,
    this.orderId,
    this.payment,
  });

  factory AcceptZoqakOfferDataResponse.fromJson(Map<String, dynamic> json) =>
      _$AcceptZoqakOfferDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AcceptZoqakOfferDataResponseToJson(this);
}
