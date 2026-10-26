// ── Portfolio sub-models ───────────────────────────────────────────────────

class PortfolioImageModel {
  final String id;
  final String imageUrl;
  final int sortOrder;

  const PortfolioImageModel({
    required this.id,
    required this.imageUrl,
    required this.sortOrder,
  });
}

class SpecializationModel {
  final String id;
  final String name;

  const SpecializationModel({required this.id, required this.name});
}

class PortfolioModel {
  final List<PortfolioImageModel> images;
  final List<SpecializationModel> specializations;

  const PortfolioModel({required this.images, required this.specializations});
}

// ── Provider profile domain model ─────────────────────────────────────────

class ProviderProfileModel {
  final String id;
  final String fullName;
  final String? nameEn;
  final String phoneNumber;
  final String? image;
  final String? bio;
  final String role;
  final String? rank;
  final String? rankLabel;
  final PortfolioModel? portfolio;

  ProviderProfileModel({
    required this.id,
    required this.fullName,
    this.nameEn,
    required this.phoneNumber,
    this.image,
    this.bio,
    required this.role,
    this.rank,
    this.rankLabel,
    this.portfolio,
  });
}
