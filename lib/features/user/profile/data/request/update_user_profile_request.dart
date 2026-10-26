import 'dart:io';

/// Request payload for the PATCH /user/profile endpoint.
/// [image] is optional — only included when the user selects a new photo.
class UpdateUserProfileRequest {
  final String fullName;
  final File? image;

  UpdateUserProfileRequest({
    required this.fullName,
    this.image,
  });
}
