import 'package:json_annotation/json_annotation.dart';
import '../../../../../constants/response_constants/response_constants.dart';
import '../../../cart/data/response/checkout_response.dart';

part 'accept_chat_offer_response.g.dart';

@JsonSerializable()
class AcceptChatOfferResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  @JsonKey(name: ResponseConstants.data)
  final AcceptChatOfferDataResponse? data;

  const AcceptChatOfferResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory AcceptChatOfferResponse.fromJson(Map<String, dynamic> json) =>
      _$AcceptChatOfferResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AcceptChatOfferResponseToJson(this);
}

@JsonSerializable()
class AcceptChatOfferDataResponse {
  @JsonKey(name: 'offerId')
  final String? offerId;

  @JsonKey(name: 'conversationId')
  final String? conversationId;

  @JsonKey(name: ResponseConstants.payment)
  final CheckoutPaymentResponse? payment;

  const AcceptChatOfferDataResponse({
    this.offerId,
    this.conversationId,
    this.payment,
  });

  factory AcceptChatOfferDataResponse.fromJson(Map<String, dynamic> json) =>
      _$AcceptChatOfferDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AcceptChatOfferDataResponseToJson(this);
}
