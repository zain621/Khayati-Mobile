/// Domain model returned after a successful profile update.
class UpdateUserProfileModel {
  final String fullName;
  final String phoneNumber;
  final String? image;

  UpdateUserProfileModel({
    required this.fullName,
    required this.phoneNumber,
    this.image,
  });
}
