/// Full order detail domain model — used by the order detail screen.
class OrderDetailModel {
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
  final String? userImage;
  final int offersCount;

  const OrderDetailModel({
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
    this.userImage,
    required this.offersCount,
  });

  String get budgetRange {
    String fmt(double n) {
      final i = n.toInt();
      return i >= 1000
          ? '${i ~/ 1000},${(i % 1000).toString().padLeft(3, '0')}'
          : '$i';
    }
    return '${fmt(minExpectedBudget)} - ${fmt(maxExpectedBudget)}';
  }
}
