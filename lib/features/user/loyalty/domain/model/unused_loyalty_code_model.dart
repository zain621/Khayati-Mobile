class UnusedLoyaltyCodeModel {
  final String id;
  final String code;
  final String rewardId;
  final String rewardTitleAr;
  final String rewardTitleEn;
  final String discountType;
  final double discountValue;
  final String createdAt;

  const UnusedLoyaltyCodeModel({
    required this.id,
    required this.code,
    required this.rewardId,
    required this.rewardTitleAr,
    required this.rewardTitleEn,
    required this.discountType,
    required this.discountValue,
    required this.createdAt,
  });
}
