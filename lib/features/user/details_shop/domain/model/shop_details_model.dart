import 'package:app_mobile/core/widgets/product_card_widget.dart';

class ShopDetailsModel {
  final String id;
  final String tailorUserId;
  final String name;
  final String? imageUrl;
  final String? coverImageUrl;
  final bool isOpen;
  final double rating;
  final int ratersCount;
  final int completedOrdersCount;
  final int productsCount;
  final String bio;
  final List<String> specializations;
  final String address;
  final List<ShopCategoryModel> categories;
  final List<ShopProductModel> products;
  final String createdAt;

  const ShopDetailsModel({
    required this.id,
    required this.tailorUserId,
    required this.name,
    this.imageUrl,
    this.coverImageUrl,
    required this.isOpen,
    required this.rating,
    required this.ratersCount,
    required this.completedOrdersCount,
    required this.productsCount,
    required this.bio,
    required this.specializations,
    required this.address,
    required this.categories,
    required this.products,
    required this.createdAt,
  });
}

class ShopCategoryModel {
  final String id;
  final String name;
  final int productsCount;
  final List<ShopProductModel> products;

  const ShopCategoryModel({
    required this.id,
    required this.name,
    required this.productsCount,
    required this.products,
  });
}

class ShopProductModel {
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

  const ShopProductModel({
    required this.id,
    this.variantId,
    this.variantColor,
    this.variantSize,
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
    this.categoryId,
    this.categoryName,
  });

  ProductItemModel toProductItemModel() => ProductItemModel(
        id: id,
        name: name,
        shopName: shopName,
        imageUrl: imageUrl ?? '',
        price: price,
        isBestSeller: isBestSelling,
      );
}
