class ShopModel {
  final String id;
  final String name;
  final String? imageUrl;
  final String? userId;
  final int productsCount;
  final double rating;
  final int ratersCount;
  final int completedOrdersCount;
  final double? latitude;
  final double? longitude;

  const ShopModel({
    required this.id,
    required this.name,
    this.imageUrl,
    this.userId,
    required this.productsCount,
    required this.rating,
    required this.ratersCount,
    required this.completedOrdersCount,
    this.latitude,
    this.longitude,
  });
}

class AdModel {
  final String id;
  final String? imageUrl;
  final String? linkUrl;
  final String? title;
  final String? subtitle;

  const AdModel({
    required this.id,
    this.imageUrl,
    this.linkUrl,
    this.title,
    this.subtitle,
  });
}

class ShopsListModel {
  final List<ShopModel> items;
  final int total;
  final List<AdModel> ads;

  const ShopsListModel({
    required this.items,
    required this.total,
    this.ads = const [],
  });
}

// ─── Top Shops ───────────────────────────────────────────────────────────────

class TopShopProductModel {
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
  final String? status;

  const TopShopProductModel({
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
    this.status,
  });
}

class TopShopModel {
  final String id;
  final String? userId;
  final String name;
  final String? imageUrl;
  final String? coverImageUrl;
  final bool isAvailable;
  final double rating;
  final int ratersCount;
  final int completedOrdersCount;
  final int productsCount;
  final String? bio;
  final List<String> specializations;
  final String? address;
  final List<TopShopProductModel> products;

  const TopShopModel({
    required this.id,
    required this.name,
    required this.rating,
    required this.ratersCount,
    required this.completedOrdersCount,
    required this.productsCount,
    required this.isAvailable,
    required this.specializations,
    required this.products,
    this.userId,
    this.imageUrl,
    this.coverImageUrl,
    this.bio,
    this.address,
  });
}

class TopShopsListModel {
  final List<TopShopModel> items;
  final int total;

  const TopShopsListModel({
    required this.items,
    required this.total,
  });
}
