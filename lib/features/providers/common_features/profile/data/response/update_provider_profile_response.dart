import 'package:json_annotation/json_annotation.dart';
import '../../../../../../constants/response_constants/response_constants.dart';

part 'update_provider_profile_response.g.dart';

@JsonSerializable()
class UpdateProviderProfileResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  const UpdateProviderProfileResponse({
    this.status,
    this.code,
    this.message,
  });

  factory UpdateProviderProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateProviderProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProviderProfileResponseToJson(this);
}
