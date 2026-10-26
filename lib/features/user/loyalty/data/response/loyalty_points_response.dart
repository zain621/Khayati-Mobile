import 'package:json_annotation/json_annotation.dart';
import '../../../../../constants/response_constants/response_constants.dart';

part 'loyalty_points_response.g.dart';

@JsonSerializable()
class LoyaltyPointsResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.data)
  final LoyaltyPointsDataResponse? data;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  const LoyaltyPointsResponse({
    this.status,
    this.code,
    this.data,
    this.message,
  });

  factory LoyaltyPointsResponse.fromJson(Map<String, dynamic> json) =>
      _$LoyaltyPointsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoyaltyPointsResponseToJson(this);
}

@JsonSerializable()
class LoyaltyPointsDataResponse {
  @JsonKey(name: ResponseConstants.points)
  final int? points;

  const LoyaltyPointsDataResponse({this.points});

  factory LoyaltyPointsDataResponse.fromJson(Map<String, dynamic> json) =>
      _$LoyaltyPointsDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoyaltyPointsDataResponseToJson(this);
}
