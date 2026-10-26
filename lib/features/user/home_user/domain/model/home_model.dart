/// Domain models for the /home endpoint.
/// These are plain Dart classes — no json_annotation.

class HomeProductModel {
  final String id;
  final String? variantId;
  final String? variantColor;
  final String? variantSize;
  final String name;
  final String shopName;
  final String shopId;
  final double price;
  final double? priceBeforeDiscount;
  final String? imageUrl;
  final bool isBestSelling;
  final double rating;
  final int ratersCount;
  final bool isAvailable;
  final String? categoryId;
  final String? categoryName;

  const HomeProductModel({
    required this.id,
    required this.name,
    required this.shopName,
    required this.shopId,
    required this.price,
    required this.isBestSelling,
    required this.rating,
    required this.ratersCount,
    required this.isAvailable,
    this.variantId,
    this.variantColor,
    this.variantSize,
    this.priceBeforeDiscount,
    this.imageUrl,
    this.categoryId,
    this.categoryName,
  });
}

class HomeShopModel {
  final String id;
  final String name;
  final String? imageUrl;
  final int productsCount;
  final double rating;
  final int ratersCount;
  final int completedOrdersCount;
  final double? latitude;
  final double? longitude;

  const HomeShopModel({
    required this.id,
    required this.name,
    required this.productsCount,
    required this.rating,
    required this.ratersCount,
    required this.completedOrdersCount,
    this.imageUrl,
    this.latitude,
    this.longitude,
  });
}

class HomeTailorModel {
  final String id;
  final String name;
  final String? imageUrl;
  final String role;
  final bool isAvailable;
  final String rank;
  final String rankLabel;
  final double rating;
  final int reviewCount;
  final int offersCount;
  final int ordersCount;
  final int completedOrdersCount;
  final double? latitude;
  final double? longitude;
  final double? distanceKm;

  const HomeTailorModel({
    required this.id,
    required this.name,
    required this.role,
    required this.isAvailable,
    required this.rank,
    required this.rankLabel,
    required this.rating,
    required this.reviewCount,
    required this.offersCount,
    required this.ordersCount,
    required this.completedOrdersCount,
    this.imageUrl,
    this.latitude,
    this.longitude,
    this.distanceKm,
  });
}

class HomeModel {
  final List<HomeProductModel> latestProducts;
  final List<HomeShopModel> shops;
  final List<HomeTailorModel> bestTailors;
  final List<HomeTailorModel> nearbyTailors;
  final int availableTailorsCount;

  const HomeModel({
    required this.latestProducts,
    required this.shops,
    required this.bestTailors,
    this.nearbyTailors = const [],
    this.availableTailorsCount = 0,
  });
}

class NearbyTailorsResultModel {
  final List<HomeTailorModel> items;
  final double radiusKm;

  const NearbyTailorsResultModel({
    required this.items,
    required this.radiusKm,
  });
}
