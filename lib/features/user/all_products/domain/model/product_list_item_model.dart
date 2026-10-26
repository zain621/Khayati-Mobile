class ProductListItemModel {
  final String id;
  final String variantId;
  final String variantColor;
  final String variantSize;
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
  final String categoryId;
  final String categoryName;
  final String status;

  const ProductListItemModel({
    required this.id,
    required this.variantId,
    required this.variantColor,
    required this.variantSize,
    required this.name,
    required this.shopName,
    required this.shopId,
    required this.price,
    this.priceBeforeDiscount,
    this.imageUrl,
    required this.isBestSelling,
    required this.rating,
    required this.ratersCount,
    required this.isAvailable,
    required this.categoryId,
    required this.categoryName,
    required this.status,
  });

  bool get hasDiscount =>
      priceBeforeDiscount != null && priceBeforeDiscount! > price;
}

class ProductsListModel {
  final List<ProductListItemModel> items;
  final int total;

  const ProductsListModel({required this.items, required this.total});
}
