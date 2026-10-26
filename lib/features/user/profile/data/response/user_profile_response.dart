import 'package:json_annotation/json_annotation.dart';
import '../../../../../constants/response_constants/response_constants.dart';

part 'user_profile_response.g.dart';

/// Inner data object: user profile fields returned from the API.
@JsonSerializable()
class UserProfileDataResponse {
  @JsonKey(name: ResponseConstants.fullName)
  String? fullName;

  @JsonKey(name: ResponseConstants.phoneNumber)
  String? phoneNumber;

  @JsonKey(name: ResponseConstants.image)
  String? image;

  @JsonKey(name: ResponseConstants.completedOrdersCount)
  int? completedOrdersCount;

  @JsonKey(name: ResponseConstants.inProgressOrdersCount)
  int? inProgressOrdersCount;

  @JsonKey(name: ResponseConstants.loyaltyPoints)
  int? loyaltyPoints;

  UserProfileDataResponse({
    this.fullName,
    this.phoneNumber,
    this.image,
    this.completedOrdersCount,
    this.inProgressOrdersCount,
    this.loyaltyPoints,
  });

  factory UserProfileDataResponse.fromJson(Map<String, dynamic> json) =>
      _$UserProfileDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileDataResponseToJson(this);
}

/// Top-level user profile response wrapper.
@JsonSerializable()
class UserProfileResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;

  @JsonKey(name: ResponseConstants.code)
  int? code;

  @JsonKey(name: ResponseConstants.message)
  String? message;

  @JsonKey(name: ResponseConstants.data)
  UserProfileDataResponse? data;

  UserProfileResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileResponseToJson(this);
}
