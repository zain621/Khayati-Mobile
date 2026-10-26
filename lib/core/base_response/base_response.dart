import 'package:json_annotation/json_annotation.dart';
import '../../constants/response_constants/response_constants.dart';

part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: ResponseConstants.message)
  String? message;

  BaseResponse();

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}
