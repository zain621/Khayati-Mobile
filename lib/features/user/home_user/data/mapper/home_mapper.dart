import 'package:app_mobile/core/extensions/extensions.dart';
import '../response/home_response.dart';
import '../response/nearby_tailors_response.dart';
import '../../domain/model/home_model.dart';

extension HomeMapper on HomeResponse {
  HomeModel toDomain() {
    return HomeModel(
      latestProducts:
          data?.latestProducts?.map((e) => e.toDomain()).toList() ?? [],
      shops: data?.shops?.map((e) => e.toDomain()).toList() ?? [],
      bestTailors: data?.bestTailors?.map((e) => e.toDomain()).toList() ?? [],
      nearbyTailors:
          data?.nearbyTailors?.map((e) => e.toDomain()).toList() ?? [],
      availableTailorsCount: data?.availableTailorsCount ?? 0,
    );
  }
}

extension HomeProductMapper on HomeProductResponse {
  HomeProductModel toDomain() {
    return HomeProductModel(
      id: id.onNull(),
      variantId: variantId,
      variantColor: variantColor,
      variantSize: variantSize,
      name: name.onNull(),
      shopName: shopName.onNull(),
      shopId: shopId.onNull(),
      price: (price as num?)?.toDouble() ?? 0.0,
      priceBeforeDiscount: (priceBeforeDiscount as num?)?.toDouble(),
      imageUrl: imageUrl,
      isBestSelling: isBestSelling ?? false,
      rating: (rating as num?)?.toDouble() ?? 0.0,
      ratersCount: ratersCount ?? 0,
      isAvailable: isAvailable ?? true,
      categoryId: categoryId,
      categoryName: categoryName,
    );
  }
}

extension HomeShopMapper on HomeShopResponse {
  HomeShopModel toDomain() {
    return HomeShopModel(
      id: id.onNull(),
      name: name.onNull(),
      imageUrl: imageUrl,
      productsCount: productsCount ?? 0,
      rating: (rating as num?)?.toDouble() ?? 0.0,
      ratersCount: ratersCount ?? 0,
      completedOrdersCount: completedOrdersCount ?? 0,
      latitude: (latitude as num?)?.toDouble(),
      longitude: (longitude as num?)?.toDouble(),
    );
  }
}

extension HomeTailorMapper on HomeTailorResponse {
  HomeTailorModel toDomain() {
    return HomeTailorModel(
      id: id.onNull(),
      name: fullName.onNull(),
      imageUrl: image,
      role: role.onNull(),
      isAvailable: isAvailable ?? true,
      rank: rank.onNull(),
      rankLabel: rankLabel.onNull(),
      rating: (rating as num?)?.toDouble() ?? 0.0,
      reviewCount: ratersCount ?? 0,
      offersCount: offersCount ?? 0,
      ordersCount: ordersCount ?? 0,
      completedOrdersCount: completedOrdersCount ?? 0,
      latitude: (latitude as num?)?.toDouble(),
      longitude: (longitude as num?)?.toDouble(),
      distanceKm: (distanceKm as num?)?.toDouble(),
    );
  }
}

extension NearbyTailorsMapper on NearbyTailorsResponse {
  NearbyTailorsResultModel toDomain() {
    return NearbyTailorsResultModel(
      items: data?.items?.map((e) => e.toDomain()).toList() ?? [],
      radiusKm: (data?.radiusKm as num?)?.toDouble() ?? 0.0,
    );
  }
}

extension NearbyTailorItemMapper on NearbyTailorItemResponse {
  HomeTailorModel toDomain() {
    return HomeTailorModel(
      id: id.onNull(),
      name: fullName.onNull(),
      imageUrl: image,
      role: role.onNull(),
      isAvailable: isAvailable ?? true,
      rank: rank.onNull(),
      rankLabel: rankLabel.onNull(),
      rating: (rating as num?)?.toDouble() ?? 0.0,
      reviewCount: ratersCount ?? 0,
      offersCount: offersCount ?? 0,
      ordersCount: completedOrdersCount ?? 0,
      completedOrdersCount: completedOrdersCount ?? 0,
      latitude: (address?.latitude as num?)?.toDouble(),
      longitude: (address?.longitude as num?)?.toDouble(),
      distanceKm: (distanceKm as num?)?.toDouble(),
    );
  }
}
