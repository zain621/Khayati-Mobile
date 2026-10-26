import 'package:app_mobile/core/extensions/extensions.dart';
import '../response/get_products_response.dart';
import '../../domain/model/product_model.dart';

/// Mapper extension for GetProductsResponse → ProductsListModel.
extension GetProductsMapper on GetProductsResponse {
  ProductsListModel toDomain() {
    return ProductsListModel(
      items: data?.items?.map((item) => item.toDomain()).toList() ?? [],
      total: data?.total.onNull() ?? 0,
    );
  }
}

/// Mapper extension for GetProductDetailsResponse → ProductModel.
extension GetProductDetailsMapper on GetProductDetailsResponse {
  ProductModel toDomain() {
    return data?.toDomain() ??
        ProductModel(
          id: '',
          shopId: '',
          nameAr: '',
          categoryId: '',
          category: const ProductCategoryModel(id: '', name: ''),
          price: 0,
          deliveryTimeMin: 0,
          deliveryTimeMax: 0,
          status: ProductStatus.active,
          createdAt: '',
          updatedAt: '',
        );
  }
}

/// Mapper extension for ProductImageResponse → ProductImageModel.
extension ProductImageMapper on ProductImageResponse {
  ProductImageModel toDomain() {
    return ProductImageModel(
      id: id.onNull(),
      imageUrl: imageUrl.onNull(),
      sortOrder: sortOrder ?? 0,
    );
  }
}

/// Mapper extension for ProductItemResponse → ProductModel.
extension ProductItemMapper on ProductItemResponse {
  ProductModel toDomain() {
    return ProductModel(
      id: id.onNull(),
      shopId: shopId.onNull(),
      nameAr: nameAr.onNull().isNotEmpty ? nameAr.onNull() : name.onNull(),
      nameEn: nameEn.onNull(),
      nameUr: nameUr.onNull(),
      categoryId: categoryId.onNull(),
      category: category?.toDomain() ??
          const ProductCategoryModel(id: '', name: ''),
      price: price ?? 0.0,
      priceBeforeDiscount: priceBeforeDiscount,
      careInstructions: careInstructions ?? [],
      features: features ?? [],
      deliveryTimeMin: deliveryTimeMin.onNull(),
      deliveryTimeMax: deliveryTimeMax.onNull(),
      status: ProductStatus.fromString(status.onNull()),
      images: images?.map((img) => img.toDomain()).toList() ?? [],
      variants: variants?.map((v) => v.toDomain()).toList() ?? [],
      createdAt: createdAt.onNull(),
      updatedAt: updatedAt.onNull(),
    );
  }
}

/// Mapper extension for ProductCategoryResponse → ProductCategoryModel.
extension ProductCategoryMapper on ProductCategoryResponse {
  ProductCategoryModel toDomain() {
    return ProductCategoryModel(
      id: id.onNull(),
      name: name.onNull(),
    );
  }
}

/// Mapper extension for ProductVariantResponse → ProductVariantModel.
extension ProductVariantMapper on ProductVariantResponse {
  ProductVariantModel toDomain() {
    return ProductVariantModel(
      id: id.onNull(),
      color: color.onNull(),
      hexCode: hexCode.onNull(),
      size: size.onNull(),
      quantity: quantity.onNull(),
    );
  }
}
