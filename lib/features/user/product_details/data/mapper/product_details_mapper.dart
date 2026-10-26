import 'package:app_mobile/core/extensions/extensions.dart';
import '../response/product_details_response.dart';
import '../../domain/model/product_details_model.dart';

extension ProductDetailsResponseMapper on ProductDetailsResponse {
  ProductDetailsModel toDomain() {
    final d = data;
    return ProductDetailsModel(
      id: d?.id.onNull() ?? '',
      shopId: d?.shopId.onNull() ?? '',
      shopName: d?.shopName.onNull() ?? '',
      name: d?.name.onNull() ?? '',
      description: d?.description,
      category: d?.category != null
          ? ProductCategoryModel(
              id: d!.category!.id.onNull(),
              name: d.category!.name.onNull(),
            )
          : null,
      price: d?.price ?? 0.0,
      priceBeforeDiscount: d?.priceBeforeDiscount,
      careInstructions: d?.careInstructions ?? [],
      features: d?.features ?? [],
      deliveryTimeMin: d?.deliveryTimeMin ?? 0,
      deliveryTimeMax: d?.deliveryTimeMax ?? 0,
      status: d?.status,
      isAvailable: d?.isAvailable ?? false,
      images: ((d?.images ?? [])
            ..sort((a, b) => (a.sortOrder ?? 0).compareTo(b.sortOrder ?? 0)))
          .map((i) => i.imageUrl.onNull())
          .where((url) => url.isNotEmpty)
          .toList(),
      variants: d?.variants?.map((v) => v.toDomain()).toList() ?? [],
      rating: d?.rating ?? 0.0,
      ratersCount: d?.ratersCount ?? 0,
      isBestSelling: d?.isBestSelling ?? false,
      createdAt: d?.createdAt,
    );
  }
}

extension ProductVariantResponseMapper on ProductVariantResponse {
  ProductVariantModel toDomain() => ProductVariantModel(
        id: id.onNull(),
        color: color,
        size: size,
        quantity: quantity ?? 0,
      );
}
