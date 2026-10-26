/// Status of an order in the tracking system.
enum OrderStatus {
  inProgress,
  ready,
  readyForDelivery,
}

/// Model representing an order for tracking.
class OrderTrackingModel {
  final String orderId;
  final String customerName;
  final String customerImage;
  final String orderType;
  final double price;
  final String orderDate;
  final String deadline;
  final OrderStatus status;
  final bool hasFabric;
  final int? deadlineWarningDays;

  const OrderTrackingModel({
    required this.orderId,
    required this.customerName,
    required this.customerImage,
    required this.orderType,
    required this.price,
    required this.orderDate,
    required this.deadline,
    required this.status,
    this.hasFabric = true,
    this.deadlineWarningDays,
  });

  String get formattedPrice {
    final priceInt = price.toInt();
    if (priceInt >= 1000) {
      return '${(priceInt / 1000).toStringAsFixed(0)},${(priceInt % 1000).toString().padLeft(3, '0')}';
    }
    return priceInt.toString();
  }
}

/// Mock data for development.
class OrderTrackingMockData {
  static const List<OrderTrackingModel> orders = [
    OrderTrackingModel(
      orderId: 'ORD-2024-001',
      customerName: 'فاطمة أحمد',
      customerImage: 'assets/images_remove/remove1.png',
      orderType: 'عباية سهرة مختصرة',
      price: 950,
      orderDate: '2024-02-03',
      deadline: '2024-02-15',
      status: OrderStatus.inProgress,
      hasFabric: true,
    ),
    OrderTrackingModel(
      orderId: 'ORD-2024-002',
      customerName: 'نورة محمد',
      customerImage: 'assets/images_remove/remove1.png',
      orderType: 'عباية يومية',
      price: 400,
      orderDate: '2024-02-03',
      deadline: '2024-02-15',
      status: OrderStatus.ready,
      hasFabric: true,
    ),
    OrderTrackingModel(
      orderId: 'ORD-2024-003',
      customerName: 'مريم سالم',
      customerImage: 'assets/images_remove/remove1.png',
      orderType: 'عباية للمناسبات',
      price: 1200,
      orderDate: '2024-02-03',
      deadline: '2024-02-15',
      status: OrderStatus.readyForDelivery,
      hasFabric: true,
      deadlineWarningDays: 3,
    ),
  ];
}
