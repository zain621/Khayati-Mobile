import 'package:json_annotation/json_annotation.dart';
import '../../../../../../constants/response_constants/response_constants.dart';

part 'submit_offer_response.g.dart';

/// Top-level submit offer response wrapper.
@JsonSerializable()
class SubmitOfferResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;

  @JsonKey(name: ResponseConstants.code)
  int? code;

  @JsonKey(name: ResponseConstants.message)
  String? message;

  SubmitOfferResponse({
    this.status,
    this.code,
    this.message,
  });

  factory SubmitOfferResponse.fromJson(Map<String, dynamic> json) =>
      _$SubmitOfferResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitOfferResponseToJson(this);
}
