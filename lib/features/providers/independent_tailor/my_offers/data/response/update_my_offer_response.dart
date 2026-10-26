import 'package:json_annotation/json_annotation.dart';
import '../../../../../../constants/response_constants/response_constants.dart';
import 'get_my_offers_response.dart';

part 'update_my_offer_response.g.dart';

/// Response wrapper for PATCH /my-offers/{offerId} and DELETE /my-offers/{offerId}.
@JsonSerializable()
class UpdateMyOfferResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;

  @JsonKey(name: ResponseConstants.code)
  int? code;

  @JsonKey(name: ResponseConstants.message)
  String? message;

  @JsonKey(name: ResponseConstants.data)
  MyOfferItemResponse? data;

  UpdateMyOfferResponse({this.status, this.code, this.message, this.data});

  factory UpdateMyOfferResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateMyOfferResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateMyOfferResponseToJson(this);
}
