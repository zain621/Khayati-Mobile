/// Domain model for a user. Shared across all roles.
/// Placed in core because the user entity is common to every feature.
class UserModel {
  final String id;
  final String fullName;
  final String? image;
  final String phoneNumber;
  final String role;

  UserModel({
    required this.id,
    required this.fullName,
    this.image,
    required this.phoneNumber,
    required this.role,
  });
}
