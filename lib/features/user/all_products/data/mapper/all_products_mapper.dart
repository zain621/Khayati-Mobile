import '../../domain/model/product_list_item_model.dart';
import '../response/all_products_response.dart';

extension AllProductsMapper on AllProductsResponse {
  ProductsListModel toDomain() {
    final items = data?.items
            ?.map((e) => e.toDomain())
            .where((e) => e.id.isNotEmpty)
            .toList() ??
        [];
    return ProductsListModel(
      items: items,
      total: data?.total ?? items.length,
    );
  }
}

extension ProductItemMapper on ProductItemResponse {
  ProductListItemModel toDomain() {
    return ProductListItemModel(
      id: id ?? '',
      variantId: variantId ?? '',
      variantColor: variantColor ?? '',
      variantSize: variantSize ?? '',
      name: name ?? '',
      shopName: shopName ?? '',
      shopId: shopId ?? '',
      price: (price ?? 0).toDouble(),
      priceBeforeDiscount: priceBeforeDiscount?.toDouble(),
      imageUrl: (imageUrl?.isNotEmpty ?? false) ? imageUrl : null,
      isBestSelling: isBestSelling ?? false,
      rating: (rating ?? 0).toDouble(),
      ratersCount: ratersCount ?? 0,
      isAvailable: isAvailable ?? true,
      categoryId: categoryId ?? '',
      categoryName: categoryName ?? '',
      status: status ?? '',
    );
  }
}
