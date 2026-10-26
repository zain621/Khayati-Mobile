import 'package:json_annotation/json_annotation.dart';
import '../../../../../constants/response_constants/response_constants.dart';

part 'redeem_loyalty_response.g.dart';

@JsonSerializable()
class RedeemLoyaltyDataResponse {
  @JsonKey(name: 'code')
  final String? code;

  const RedeemLoyaltyDataResponse({this.code});

  factory RedeemLoyaltyDataResponse.fromJson(Map<String, dynamic> json) =>
      _$RedeemLoyaltyDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RedeemLoyaltyDataResponseToJson(this);
}

@JsonSerializable()
class RedeemLoyaltyResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  @JsonKey(name: ResponseConstants.data)
  final RedeemLoyaltyDataResponse? data;

  const RedeemLoyaltyResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory RedeemLoyaltyResponse.fromJson(Map<String, dynamic> json) =>
      _$RedeemLoyaltyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RedeemLoyaltyResponseToJson(this);
}
