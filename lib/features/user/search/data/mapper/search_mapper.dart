import '../response/search_response.dart';
import '../response/search_history_response.dart';
import '../../domain/model/search_model.dart';
import '../../domain/model/search_history_model.dart';

extension SearchResponseMapper on SearchDataResponse {
  SearchModel toDomain() {
    return SearchModel(
      query: query ?? '',
      type: type ?? 'all',
      counts: counts?.toDomain() ?? const SearchCountsModel(shops: 0, products: 0, tailors: 0, total: 0),
      globalCounts: globalCounts?.toDomain() ?? const SearchCountsModel(shops: 0, products: 0, tailors: 0, total: 0),
      products: results?.products?.map((e) => e.toDomain()).toList() ?? [],
      shops: results?.shops?.map((e) => e.toDomain()).toList() ?? [],
      tailors: results?.tailors?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

extension SearchCountsResponseMapper on SearchCountsResponse {
  SearchCountsModel toDomain() {
    return SearchCountsModel(
      shops: shops ?? 0,
      products: products ?? 0,
      tailors: tailors ?? 0,
      total: total ?? 0,
    );
  }
}

extension SearchProductResponseMapper on SearchProductResponse {
  SearchProductModel toDomain() {
    return SearchProductModel(
      id: id ?? '',
      name: name ?? '',
      imageUrl: imageUrl,
      images: images ?? [],
      categoryId: category?.id,
      categoryName: category?.name,
      shopId: shop?.id,
      shopName: shop?.name,
      price: _toDouble(price),
      priceBeforeDiscount: priceBeforeDiscount != null ? _toDouble(priceBeforeDiscount) : null,
      isBestSelling: isBestSelling ?? false,
      isAvailable: isAvailable ?? true,
      deliveryTimeMin: deliveryTimeMin ?? 0,
      deliveryTimeMax: deliveryTimeMax ?? 0,
      variants: variants?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

extension SearchProductVariantResponseMapper on SearchProductVariantResponse {
  SearchProductVariantModel toDomain() {
    return SearchProductVariantModel(
      id: id ?? '',
      color: color,
      colorHexCode: colorHexCode,
      size: size,
      quantity: quantity ?? 0,
    );
  }
}

extension SearchShopResponseMapper on SearchShopResponse {
  SearchShopModel toDomain() {
    return SearchShopModel(
      id: id ?? '',
      name: name ?? '',
      imageUrl: imageUrl,
      coverImageUrl: coverImageUrl,
      rating: _toDouble(rating),
      ratersCount: ratersCount ?? 0,
      location: location,
    );
  }
}

extension SearchTailorResponseMapper on SearchTailorResponse {
  SearchTailorModel toDomain() {
    return SearchTailorModel(
      id: id ?? '',
      name: name ?? '',
      imageUrl: imageUrl,
      rating: _toDouble(rating),
      ratersCount: ratersCount ?? 0,
      rankLabel: rankLabel,
      specializations: specializations ?? [],
    );
  }
}

extension SearchHistoryItemResponseMapper on SearchHistoryItemResponse {
  SearchHistoryModel toDomain() {
    return SearchHistoryModel(
      id: id ?? '',
      query: query ?? '',
      createdAt: createdAt,
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
