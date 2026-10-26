/// Model representing a single customer review.
class CustomerReviewModel {
  final String reviewId;
  final String customerName;
  final String customerImage;
  final String orderType;
  final String orderId;
  final double rating;
  final String reviewText;
  final String date;
  final String? productImage;

  const CustomerReviewModel({
    required this.reviewId,
    required this.customerName,
    required this.customerImage,
    required this.orderType,
    required this.orderId,
    required this.rating,
    required this.reviewText,
    required this.date,
    this.productImage,
  });
}

/// Mock data for development.
class CustomerReviewMockData {
  static const List<CustomerReviewModel> reviews = [
    CustomerReviewModel(
      reviewId: 'REV-001',
      customerName: 'فاطمة أحمد',
      customerImage: 'assets/images_remove/remove1.png',
      orderType: 'عباية سهرة مطرزة',
      orderId: 'ORD-2024-001',
      rating: 5.0,
      reviewText:
          'عمل رائع جداً التطريز كان أجمل مما توقعت والقماش فاخر التسليم كان في الموعد المحدد شكراً جزيلاً على الاهتمام بالتفاصيل',
      date: '2024-02-05',
      productImage: 'assets/images_remove/remove1.png',
    ),
    CustomerReviewModel(
      reviewId: 'REV-002',
      customerName: 'نورة محمد',
      customerImage: 'assets/images_remove/remove1.png',
      orderType: 'عباية يومية',
      orderId: 'ORD-2024-002',
      rating: 5.0,
      reviewText:
          'ممتازة القصة مريحة جداً والقماش خفيف ومناسب للصيف، التعامل راقي والتسليم سريع.',
      date: '2024-02-04',
    ),
    CustomerReviewModel(
      reviewId: 'REV-003',
      customerName: 'مريم سالم',
      customerImage: 'assets/images_remove/remove1.png',
      orderType: 'عباية مناسبات',
      orderId: 'ORD-2024-003',
      rating: 4.0,
      reviewText:
          'جميلة جداً والتصميم راقي، كنت أفضل الدانتيل يكون أكثر كثافة لكن بشكل عام راضية عن النتيجة.',
      date: '2024-01-30',
    ),
  ];
}
