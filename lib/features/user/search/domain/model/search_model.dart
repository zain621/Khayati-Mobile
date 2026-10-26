class SearchModel {
  final String query;
  final String type;
  final SearchCountsModel counts;
  final SearchCountsModel globalCounts;
  final List<SearchProductModel> products;
  final List<SearchShopModel> shops;
  final List<SearchTailorModel> tailors;

  const SearchModel({
    required this.query,
    required this.type,
    required this.counts,
    required this.globalCounts,
    required this.products,
    required this.shops,
    required this.tailors,
  });
}

class SearchCountsModel {
  final int shops;
  final int products;
  final int tailors;
  final int total;

  const SearchCountsModel({
    required this.shops,
    required this.products,
    required this.tailors,
    required this.total,
  });
}

class SearchProductModel {
  final String id;
  final String name;
  final String? imageUrl;
  final List<String> images;
  final String? categoryId;
  final String? categoryName;
  final String? shopId;
  final String? shopName;
  final double price;
  final double? priceBeforeDiscount;
  final bool isBestSelling;
  final bool isAvailable;
  final int deliveryTimeMin;
  final int deliveryTimeMax;
  final List<SearchProductVariantModel> variants;

  const SearchProductModel({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.images,
    this.categoryId,
    this.categoryName,
    this.shopId,
    this.shopName,
    required this.price,
    this.priceBeforeDiscount,
    required this.isBestSelling,
    required this.isAvailable,
    required this.deliveryTimeMin,
    required this.deliveryTimeMax,
    required this.variants,
  });
}

class SearchProductVariantModel {
  final String id;
  final String? color;
  final String? colorHexCode;
  final String? size;
  final int quantity;

  const SearchProductVariantModel({
    required this.id,
    this.color,
    this.colorHexCode,
    this.size,
    required this.quantity,
  });
}

class SearchShopModel {
  final String id;
  final String name;
  final String? imageUrl;
  final String? coverImageUrl;
  final double rating;
  final int ratersCount;
  final String? location;

  const SearchShopModel({
    required this.id,
    required this.name,
    this.imageUrl,
    this.coverImageUrl,
    required this.rating,
    required this.ratersCount,
    this.location,
  });
}

class SearchTailorModel {
  final String id;
  final String name;
  final String? imageUrl;
  final double rating;
  final int ratersCount;
  final String? rankLabel;
  final List<String> specializations;

  const SearchTailorModel({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.rating,
    required this.ratersCount,
    this.rankLabel,
    required this.specializations,
  });
}
