import 'package:json_annotation/json_annotation.dart';
import '../../../../../../constants/response_constants/response_constants.dart';

part 'portfolio_response.g.dart';

/// Generic response for portfolio add/delete actions.
@JsonSerializable()
class PortfolioActionResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;

  @JsonKey(name: ResponseConstants.code)
  int? code;

  @JsonKey(name: ResponseConstants.message)
  String? message;

  PortfolioActionResponse({this.status, this.code, this.message});

  factory PortfolioActionResponse.fromJson(Map<String, dynamic> json) =>
      _$PortfolioActionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PortfolioActionResponseToJson(this);
}
