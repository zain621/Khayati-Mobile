/// Domain model for the user profile.
class UserProfileModel {
  final String fullName;
  final String phoneNumber;
  final String? image;
  final int completedOrdersCount;
  final int inProgressOrdersCount;
  final int loyaltyPoints;

  UserProfileModel({
    required this.fullName,
    required this.phoneNumber,
    this.image,
    required this.completedOrdersCount,
    required this.inProgressOrdersCount,
    required this.loyaltyPoints,
  });
}
