import 'package:json_annotation/json_annotation.dart';
import '../../../../../constants/response_constants/response_constants.dart';

part 'cart_response.g.dart';

@JsonSerializable()
class CartResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.data)
  final CartDataResponse? data;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  const CartResponse({this.status, this.code, this.data, this.message});

  factory CartResponse.fromJson(Map<String, dynamic> json) =>
      _$CartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CartResponseToJson(this);
}

@JsonSerializable()
class CartDataResponse {
  @JsonKey(name: ResponseConstants.shops)
  final List<CartShopResponse>? shops;

  @JsonKey(name: ResponseConstants.grandTotal)
  final double? grandTotal;

  @JsonKey(name: ResponseConstants.couponCode)
  final String? couponCode;

  @JsonKey(name: ResponseConstants.discountAmount)
  final double? discountAmount;

  @JsonKey(name: ResponseConstants.grandTotalAfterDiscount)
  final double? grandTotalAfterDiscount;

  const CartDataResponse({
    this.shops,
    this.grandTotal,
    this.couponCode,
    this.discountAmount,
    this.grandTotalAfterDiscount,
  });

  factory CartDataResponse.fromJson(Map<String, dynamic> json) =>
      _$CartDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CartDataResponseToJson(this);
}

@JsonSerializable()
class CartShopResponse {
  @JsonKey(name: ResponseConstants.shopId)
  final String? shopId;

  @JsonKey(name: ResponseConstants.name)
  final String? name;

  @JsonKey(name: ResponseConstants.products)
  final List<CartItemResponse>? products;

  @JsonKey(name: ResponseConstants.subtotal)
  final double? subtotal;

  const CartShopResponse({this.shopId, this.name, this.products, this.subtotal});

  factory CartShopResponse.fromJson(Map<String, dynamic> json) =>
      _$CartShopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CartShopResponseToJson(this);
}

@JsonSerializable()
class CartItemResponse {
  @JsonKey(name: ResponseConstants.cartItemId)
  final String? cartItemId;

  @JsonKey(name: ResponseConstants.productId)
  final String? productId;

  @JsonKey(name: ResponseConstants.variantId)
  final String? variantId;

  @JsonKey(name: ResponseConstants.name)
  final String? name;

  @JsonKey(name: ResponseConstants.imageUrl)
  final String? imageUrl;

  @JsonKey(name: ResponseConstants.price)
  final double? price;

  @JsonKey(name: ResponseConstants.priceBeforeDiscount)
  final double? priceBeforeDiscount;

  @JsonKey(name: ResponseConstants.color)
  final String? color;

  @JsonKey(name: ResponseConstants.size)
  final String? size;

  @JsonKey(name: ResponseConstants.quantity)
  final int? quantity;

  @JsonKey(name: ResponseConstants.maxQuantity)
  final int? maxQuantity;

  @JsonKey(name: ResponseConstants.lineTotal)
  final double? lineTotal;

  const CartItemResponse({
    this.cartItemId,
    this.productId,
    this.variantId,
    this.name,
    this.imageUrl,
    this.price,
    this.priceBeforeDiscount,
    this.color,
    this.size,
    this.quantity,
    this.maxQuantity,
    this.lineTotal,
  });

  factory CartItemResponse.fromJson(Map<String, dynamic> json) =>
      _$CartItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemResponseToJson(this);
}
