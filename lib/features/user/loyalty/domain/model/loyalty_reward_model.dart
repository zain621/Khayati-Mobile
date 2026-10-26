class LoyaltyRewardModel {
  final String id;
  final String titleAr;
  final String titleEn;
  final int pointsRequired;
  final String discountType;
  final double discountValue;
  final bool isActive;

  const LoyaltyRewardModel({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.pointsRequired,
    required this.discountType,
    required this.discountValue,
    required this.isActive,
  });
}
