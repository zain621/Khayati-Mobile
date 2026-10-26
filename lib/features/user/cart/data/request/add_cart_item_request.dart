class AddCartItemRequest {
  final String productId;
  final String variantId;
  final int quantity;

  const AddCartItemRequest({
    required this.productId,
    required this.variantId,
    required this.quantity,
  });

  Map<String, dynamic> toBody() => {
        'productId': productId,
        'variantId': variantId,
        'quantity': quantity,
      };
}
