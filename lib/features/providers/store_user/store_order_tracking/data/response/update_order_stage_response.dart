import 'package:json_annotation/json_annotation.dart';
import '../../../../../../constants/response_constants/response_constants.dart';

part 'update_order_stage_response.g.dart';

@JsonSerializable()
class UpdateOrderStageResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;

  @JsonKey(name: ResponseConstants.code)
  int? code;

  @JsonKey(name: ResponseConstants.message)
  String? message;

  UpdateOrderStageResponse({
    this.status,
    this.code,
    this.message,
  });

  factory UpdateOrderStageResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateOrderStageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateOrderStageResponseToJson(this);
}
