class UpdateCartItemRequest {
  final String cartItemId;
  final int quantity;

  const UpdateCartItemRequest({
    required this.cartItemId,
    required this.quantity,
  });
}
