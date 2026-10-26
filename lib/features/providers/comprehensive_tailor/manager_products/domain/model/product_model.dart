/// Status of a product in the manager.
enum ProductStatus {
  active,
  inactive,
  outOfStock;

  /// Parse status string from API to ProductStatus enum.
  static ProductStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return ProductStatus.active;
      case 'inactive':
      case 'stopped':
        return ProductStatus.inactive;
      case 'out_of_stock':
      case 'outofstock':
        return ProductStatus.outOfStock;
      default:
        return ProductStatus.active;
    }
  }
}

/// Model representing a single product image object from API.
class ProductImageModel {
  final String id;
  final String imageUrl;
  final int sortOrder;

  const ProductImageModel({
    required this.id,
    required this.imageUrl,
    required this.sortOrder,
  });
}

/// Model representing a product variant (color, size, quantity).
class ProductVariantModel {
  final String id;
  final String color;
  final String hexCode;
  final String size;
  final int quantity;

  const ProductVariantModel({
    required this.id,
    required this.color,
    required this.hexCode,
    required this.size,
    required this.quantity,
  });
}

/// Model representing product category.
class ProductCategoryModel {
  final String id;
  final String name;

  const ProductCategoryModel({
    required this.id,
    required this.name,
  });
}

/// Model representing a product for the manager screen.
class ProductModel {
  final String id;
  final String shopId;
  final String nameAr;
  final String nameEn;
  final String nameUr;
  final String categoryId;
  final ProductCategoryModel category;
  final double price;
  final double? priceBeforeDiscount;
  final List<String> careInstructions;
  final List<String> features;
  final int deliveryTimeMin;
  final int deliveryTimeMax;
  final ProductStatus status;
  final List<ProductImageModel> images;
  final List<ProductVariantModel> variants;
  final String createdAt;
  final String updatedAt;

  const ProductModel({
    required this.id,
    required this.shopId,
    required this.nameAr,
    this.nameEn = '',
    this.nameUr = '',
    required this.categoryId,
    required this.category,
    required this.price,
    this.priceBeforeDiscount,
    this.careInstructions = const [],
    this.features = const [],
    required this.deliveryTimeMin,
    required this.deliveryTimeMax,
    required this.status,
    this.images = const [],
    this.variants = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  /// Primary display name — Arabic.
  String get name => nameAr;

  /// Get formatted price as string.
  String get formattedPrice {
    final priceInt = price.toInt();
    return priceInt.toString();
  }

  /// Get formatted original price as string.
  String? get formattedOriginalPrice {
    if (priceBeforeDiscount == null) return null;
    return priceBeforeDiscount!.toInt().toString();
  }

  /// Check if product has a discount.
  bool get hasDiscount =>
      priceBeforeDiscount != null && priceBeforeDiscount! > price;

  /// Calculate discount percent.
  int? get discountPercent {
    if (!hasDiscount) return null;
    return (((priceBeforeDiscount! - price) / priceBeforeDiscount!) * 100)
        .round();
  }

  /// Get total stock count from all variants.
  int get stockCount {
    return variants.fold<int>(0, (sum, v) => sum + v.quantity);
  }

  /// Get all unique colors from variants.
  List<ProductVariantModel> get uniqueColors {
    final Map<String, ProductVariantModel> colorsMap = {};
    for (final variant in variants) {
      if (!colorsMap.containsKey(variant.hexCode)) {
        colorsMap[variant.hexCode] = variant;
      }
    }
    return colorsMap.values.toList();
  }

  /// Get all unique sizes from variants.
  List<String> get uniqueSizes {
    final Set<String> sizesSet = {};
    for (final variant in variants) {
      sizesSet.add(variant.size);
    }
    return sizesSet.toList();
  }

  /// Get first image URL or empty string.
  String get imageUrl => images.isNotEmpty ? images.first.imageUrl : '';
}

/// Model for paginated products response.
class ProductsListModel {
  final List<ProductModel> items;
  final int total;

  const ProductsListModel({
    required this.items,
    required this.total,
  });
}
