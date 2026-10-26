// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartResponse _$CartResponseFromJson(Map<String, dynamic> json) => CartResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : CartDataResponse.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$CartResponseToJson(CartResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };

CartDataResponse _$CartDataResponseFromJson(Map<String, dynamic> json) =>
    CartDataResponse(
      shops: (json['shops'] as List<dynamic>?)
          ?.map((e) => CartShopResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      grandTotal: (json['grandTotal'] as num?)?.toDouble(),
      couponCode: json['couponCode'] as String?,
      discountAmount: (json['discountAmount'] as num?)?.toDouble(),
      grandTotalAfterDiscount:
          (json['grandTotalAfterDiscount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CartDataResponseToJson(CartDataResponse instance) =>
    <String, dynamic>{
      'shops': instance.shops,
      'grandTotal': instance.grandTotal,
      'couponCode': instance.couponCode,
      'discountAmount': instance.discountAmount,
      'grandTotalAfterDiscount': instance.grandTotalAfterDiscount,
    };

CartShopResponse _$CartShopResponseFromJson(Map<String, dynamic> json) =>
    CartShopResponse(
      shopId: json['shopId'] as String?,
      name: json['name'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => CartItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      subtotal: (json['subtotal'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CartShopResponseToJson(CartShopResponse instance) =>
    <String, dynamic>{
      'shopId': instance.shopId,
      'name': instance.name,
      'products': instance.products,
      'subtotal': instance.subtotal,
    };

CartItemResponse _$CartItemResponseFromJson(Map<String, dynamic> json) =>
    CartItemResponse(
      cartItemId: json['cartItemId'] as String?,
      productId: json['productId'] as String?,
      variantId: json['variantId'] as String?,
      name: json['name'] as String?,
      imageUrl: json['imageUrl'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      priceBeforeDiscount: (json['priceBeforeDiscount'] as num?)?.toDouble(),
      color: json['color'] as String?,
      size: json['size'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      maxQuantity: (json['maxQuantity'] as num?)?.toInt(),
      lineTotal: (json['lineTotal'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CartItemResponseToJson(CartItemResponse instance) =>
    <String, dynamic>{
      'cartItemId': instance.cartItemId,
      'productId': instance.productId,
      'variantId': instance.variantId,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'price': instance.price,
      'priceBeforeDiscount': instance.priceBeforeDiscount,
      'color': instance.color,
      'size': instance.size,
      'quantity': instance.quantity,
      'maxQuantity': instance.maxQuantity,
      'lineTotal': instance.lineTotal,
    };
