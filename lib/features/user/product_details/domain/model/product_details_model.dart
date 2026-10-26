class ProductVariantModel {
  final String id;
  final String? color;
  final String? size;
  final int quantity;

  const ProductVariantModel({
    required this.id,
    this.color,
    this.size,
    required this.quantity,
  });

  bool get isAvailable => quantity > 0;
}

class ProductCategoryModel {
  final String id;
  final String name;

  const ProductCategoryModel({required this.id, required this.name});
}

class ProductDetailsModel {
  final String id;
  final String shopId;
  final String shopName;
  final String name;
  final String? description;
  final ProductCategoryModel? category;
  final double price;
  final double? priceBeforeDiscount;
  final List<String> careInstructions;
  final List<String> features;
  final int deliveryTimeMin;
  final int deliveryTimeMax;
  final String? status;
  final bool isAvailable;
  final List<String> images;
  final List<ProductVariantModel> variants;
  final double rating;
  final int ratersCount;
  final bool isBestSelling;
  final String? createdAt;

  const ProductDetailsModel({
    required this.id,
    required this.shopId,
    required this.shopName,
    required this.name,
    this.description,
    this.category,
    required this.price,
    this.priceBeforeDiscount,
    required this.careInstructions,
    required this.features,
    required this.deliveryTimeMin,
    required this.deliveryTimeMax,
    this.status,
    required this.isAvailable,
    required this.images,
    required this.variants,
    required this.rating,
    required this.ratersCount,
    required this.isBestSelling,
    this.createdAt,
  });

  List<String> get availableColors => variants
      .where((v) => v.isAvailable && v.color != null)
      .map((v) => v.color!)
      .toSet()
      .toList();

  List<String> sizesForColor(String color) => variants
      .where((v) => v.color == color && v.isAvailable && v.size != null)
      .map((v) => v.size!)
      .toList();

  ProductVariantModel? findVariant(String? color, String? size) {
    if (color == null || size == null) return null;
    try {
      return variants.firstWhere(
        (v) => v.color == color && v.size == size,
      );
    } catch (_) {
      return null;
    }
  }

  bool get hasDiscount =>
      priceBeforeDiscount != null && priceBeforeDiscount! > price;
}
