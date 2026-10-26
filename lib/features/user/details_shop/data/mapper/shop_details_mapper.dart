import 'package:app_mobile/core/extensions/extensions.dart';
import '../response/shop_details_response.dart';
import '../../domain/model/shop_details_model.dart';

extension ShopDetailsMapper on ShopDetailsResponse {
  ShopDetailsModel toDomain() {
    return ShopDetailsModel(
      id: data?.id.onNull() ?? '',
      tailorUserId: data?.userId.onNull() ?? '',
      name: data?.name.onNull() ?? '',
      imageUrl: data?.imageUrl,
      coverImageUrl: data?.coverImageUrl,
      isOpen: data?.isAvailable ?? true,
      rating: _toDouble(data?.rating),
      ratersCount: data?.ratersCount ?? 0,
      completedOrdersCount: data?.completedOrdersCount ?? 0,
      productsCount: data?.productsCount ?? 0,
      bio: data?.bio.onNull() ?? '',
      specializations: data?.specializations ?? [],
      address: data?.address.onNull() ?? '',
      categories:
          data?.categories?.map((e) => e.toDomain()).toList() ?? [],
      products: data?.products?.map((e) => e.toDomain()).toList() ?? [],
      createdAt: data?.createdAt.onNull() ?? '',
    );
  }
}

extension ShopCategoryMapper on ShopCategoryResponse {
  ShopCategoryModel toDomain() {
    return ShopCategoryModel(
      id: id.onNull(),
      name: name.onNull(),
      productsCount: productsCount ?? 0,
      products: products?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

extension ShopProductMapper on ShopProductResponse {
  ShopProductModel toDomain() {
    return ShopProductModel(
      id: id.onNull(),
      variantId: variantId,
      variantColor: variantColor,
      variantSize: variantSize,
      name: name.onNull(),
      shopName: shopName.onNull(),
      shopId: shopId.onNull(),
      price: _toDouble(price),
      priceBeforeDiscount:
          priceBeforeDiscount == null ? null : _toDouble(priceBeforeDiscount),
      imageUrl: imageUrl,
      isBestSelling: isBestSelling ?? false,
      rating: _toDouble(rating),
      ratersCount: ratersCount ?? 0,
      isAvailable: isAvailable ?? true,
      categoryId: categoryId,
      categoryName: categoryName,
    );
  }
}

double _toDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}
