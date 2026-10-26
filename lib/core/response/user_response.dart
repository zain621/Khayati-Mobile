import 'package:json_annotation/json_annotation.dart';
import '../../constants/response_constants/response_constants.dart';

part 'user_response.g.dart';

/// The user object returned inside the API login/profile response.
/// Placed in core because this model is shared across all roles.
@JsonSerializable()
class UserResponse {
  @JsonKey(name: ResponseConstants.entityId)
  String? id;

  @JsonKey(name: ResponseConstants.fullName)
  String? fullName;

  @JsonKey(name: ResponseConstants.image)
  String? image;

  @JsonKey(name: ResponseConstants.phoneNumber)
  String? phoneNumber;

  @JsonKey(name: ResponseConstants.role)
  String? role;

  UserResponse({
    this.id,
    this.fullName,
    this.image,
    this.phoneNumber,
    this.role,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
