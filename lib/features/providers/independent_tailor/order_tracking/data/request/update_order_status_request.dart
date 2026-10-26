class UpdateOrderStatusRequest {
  final String orderId;
  final String status;

  const UpdateOrderStatusRequest({
    required this.orderId,
    required this.status,
  });
}
