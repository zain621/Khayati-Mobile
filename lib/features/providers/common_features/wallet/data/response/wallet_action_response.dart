import 'package:json_annotation/json_annotation.dart';
import '../../../../../../constants/response_constants/response_constants.dart';

part 'wallet_action_response.g.dart';

@JsonSerializable()
class WalletActionResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  WalletActionResponse({this.status, this.code, this.message});

  factory WalletActionResponse.fromJson(Map<String, dynamic> json) =>
      _$WalletActionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WalletActionResponseToJson(this);
}
