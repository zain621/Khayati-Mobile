class TailorDetailsModel {
  final String id;
  final String name;
  final String? image;
  final String? bio;
  final String role;
  final bool isAvailable;
  final String rank;
  final String rankLabel;
  final double rating;
  final int ratersCount;
  final int offersCount;
  final int completedOrdersCount;
  final List<String> portfolioImages;
  final List<String> specializations;
  final String? address;

  const TailorDetailsModel({
    required this.id,
    required this.name,
    required this.role,
    required this.isAvailable,
    required this.rank,
    required this.rankLabel,
    required this.rating,
    required this.ratersCount,
    required this.offersCount,
    required this.completedOrdersCount,
    required this.portfolioImages,
    required this.specializations,
    this.image,
    this.bio,
    this.address,
  });
}
