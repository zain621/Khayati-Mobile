import 'package:app_mobile/core/extensions/extensions.dart';
import '../response/get_shops_response.dart';
import '../response/get_top_shops_response.dart';
import '../../domain/model/shop_model.dart';

extension ShopItemMapper on ShopItemResponse {
  ShopModel toDomain() {
    return ShopModel(
      id: id.onNull(),
      name: name.onNull(),
      imageUrl: imageUrl,
      userId: userId,
      productsCount: productsCount ?? 0,
      rating: rating?.toDouble() ?? 0.0,
      ratersCount: ratersCount ?? 0,
      completedOrdersCount: completedOrdersCount ?? 0,
      latitude: latitude,
      longitude: longitude,
    );
  }
}

extension AdItemMapper on AdItemResponse {
  AdModel toDomain() {
    return AdModel(
      id: id.onNull(),
      imageUrl: imageUrl,
      linkUrl: linkUrl,
      title: title,
      subtitle: subtitle,
    );
  }
}

extension GetShopsMapper on GetShopsResponse {
  ShopsListModel toDomain() {
    return ShopsListModel(
      items: data?.items?.map((e) => e.toDomain()).toList() ?? [],
      total: data?.total ?? 0,
      ads: data?.ads?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

// ─── Top Shops Mappers ────────────────────────────────────────────────────────

extension TopShopProductMapper on TopShopProductResponse {
  TopShopProductModel toDomain() {
    return TopShopProductModel(
      id: id.onNull(),
      variantId: variantId,
      variantColor: variantColor,
      variantSize: variantSize,
      name: name.onNull(),
      shopName: shopName.onNull(),
      shopId: shopId.onNull(),
      price: price?.toDouble() ?? 0.0,
      priceBeforeDiscount: priceBeforeDiscount?.toDouble(),
      imageUrl: imageUrl,
      isBestSelling: isBestSelling ?? false,
      rating: rating?.toDouble() ?? 0.0,
      ratersCount: ratersCount ?? 0,
      isAvailable: isAvailable ?? true,
      categoryId: categoryId,
      categoryName: categoryName,
      status: status,
    );
  }
}

extension TopShopItemMapper on TopShopItemResponse {
  TopShopModel toDomain() {
    return TopShopModel(
      id: id.onNull(),
      userId: userId,
      name: name.onNull(),
      imageUrl: imageUrl,
      coverImageUrl: coverImageUrl,
      isAvailable: isAvailable ?? true,
      rating: rating?.toDouble() ?? 0.0,
      ratersCount: ratersCount ?? 0,
      completedOrdersCount: completedOrdersCount ?? 0,
      productsCount: productsCount ?? 0,
      bio: bio,
      specializations: specializations ?? [],
      address: address,
      products: products?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

extension GetTopShopsMapper on GetTopShopsResponse {
  TopShopsListModel toDomain() {
    return TopShopsListModel(
      items: data?.items?.map((e) => e.toDomain()).toList() ?? [],
      total: data?.total ?? 0,
    );
  }
}
