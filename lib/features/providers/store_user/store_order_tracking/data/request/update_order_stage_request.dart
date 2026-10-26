class UpdateOrderStageRequest {
  final String orderId;
  final String stageKey;

  const UpdateOrderStageRequest({
    required this.orderId,
    required this.stageKey,
  });
}
