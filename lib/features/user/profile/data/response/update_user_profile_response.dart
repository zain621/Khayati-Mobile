import 'package:json_annotation/json_annotation.dart';
import '../../../../../constants/response_constants/response_constants.dart';

part 'update_user_profile_response.g.dart';

/// Inner data returned after a successful profile update.
@JsonSerializable()
class UpdateUserProfileDataResponse {
  @JsonKey(name: ResponseConstants.fullName)
  String? fullName;

  @JsonKey(name: ResponseConstants.phoneNumber)
  String? phoneNumber;

  @JsonKey(name: ResponseConstants.image)
  String? image;

  UpdateUserProfileDataResponse({
    this.fullName,
    this.phoneNumber,
    this.image,
  });

  factory UpdateUserProfileDataResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserProfileDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserProfileDataResponseToJson(this);
}

/// Top-level response wrapper for the update-profile PATCH endpoint.
@JsonSerializable()
class UpdateUserProfileResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;

  @JsonKey(name: ResponseConstants.code)
  int? code;

  @JsonKey(name: ResponseConstants.message)
  String? message;

  @JsonKey(name: ResponseConstants.data)
  UpdateUserProfileDataResponse? data;

  UpdateUserProfileResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory UpdateUserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserProfileResponseToJson(this);
}
