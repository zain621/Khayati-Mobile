/// Domain model for a created zoqak order.
class CreateOrderModel {
  final String id;
  final String orderNumber;
  final String productName;
  final String description;
  final String specialRequests;
  final String fabricType;
  final double minExpectedBudget;
  final double maxExpectedBudget;
  final String deliveryDate;
  final List<String> similarImages;
  final String status;
  final String createdAt;
  final String userName;

  const CreateOrderModel({
    required this.id,
    required this.orderNumber,
    required this.productName,
    required this.description,
    required this.specialRequests,
    required this.fabricType,
    required this.minExpectedBudget,
    required this.maxExpectedBudget,
    required this.deliveryDate,
    required this.similarImages,
    required this.status,
    required this.createdAt,
    required this.userName,
  });
}
