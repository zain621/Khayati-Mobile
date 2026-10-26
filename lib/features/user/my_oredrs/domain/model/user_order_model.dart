// ──────────────────────────────────────────────────────────────────────────────
// User Order — data model
// ──────────────────────────────────────────────────────────────────────────────

/// The type / origin of the order.
enum UserOrderType {
  /// "على ذوقك" — user described a custom garment
  custom,

  /// "طلب مباشر" — ordered directly from a tailor's service
  direct,

  /// "قطع جاهزة" — one or more ready-made pieces
  readyPieces,
}

/// Current lifecycle status of the order (from the user's perspective).
enum UserOrderStatus {
  /// No tailor has submitted an offer yet
  waitingOffers,

  /// At least one offer received, user has not picked yet
  hasOffers,

  /// Tailor accepted / order is being worked on
  inProgress,

  /// Tailor finished — waiting for customer pick-up or delivery
  readyForDelivery,

  /// Delivered and closed
  completed,
}

/// Data model for a single customer order card.
class UserOrderModel {
  final String orderId;
  final String title;
  final String imageUrl;
  final UserOrderType orderType;
  final UserOrderStatus status;
  final double price;
  final String orderDate;
  final String deadline;

  /// Non-null when [status] == [UserOrderStatus.hasOffers].
  final int? offersCount;

  /// For readyPieces orders — bundle size (e.g. 3 pieces).
  final int? piecesCount;

  /// Tailor / shop name shown when a direct or ready-pieces order is confirmed.
  final String? confirmedTailorName;

  const UserOrderModel({
    required this.orderId,
    required this.title,
    required this.imageUrl,
    required this.orderType,
    required this.status,
    required this.price,
    required this.orderDate,
    required this.deadline,
    this.offersCount,
    this.piecesCount,
    this.confirmedTailorName,
  });

  String get formattedPrice {
    final p = price.toInt();
    if (p >= 1000) {
      return '${(p / 1000).toStringAsFixed(0)},${(p % 1000).toString().padLeft(3, '0')}';
    }
    return p.toString();
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Mock data — remove once real API is wired
// ──────────────────────────────────────────────────────────────────────────────

class UserOrderMockData {
  static const List<UserOrderModel> orders = [
    // 1 — waitingOffers (custom)
    UserOrderModel(
      orderId: 'USR-2024-001',
      title: 'عباية سوداء فاخرة مع تطريز ذهبي',
      imageUrl:
          'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?w=300&q=80',
      orderType: UserOrderType.custom,
      status: UserOrderStatus.waitingOffers,
      price: 850,
      orderDate: '2024-01-15',
      deadline: '2024-02-15',
    ),

    // 2 — hasOffers (custom)
    UserOrderModel(
      orderId: 'USR-2024-002',
      title: 'عباية سوداء فاخرة مع تطريز ذهبي',
      imageUrl:
          'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?w=300&q=80',
      orderType: UserOrderType.custom,
      status: UserOrderStatus.hasOffers,
      price: 850,
      orderDate: '2024-01-15',
      deadline: '2024-02-15',
      offersCount: 5,
    ),

    // 3 — inProgress (direct)
    UserOrderModel(
      orderId: 'USR-2024-003',
      title: 'عباية كحلي عصرية مع تفاصيل لؤلؤية',
      imageUrl:
          'https://images.unsplash.com/photo-1567401893414-76b7b1e5a7a5?w=300&q=80',
      orderType: UserOrderType.direct,
      status: UserOrderStatus.inProgress,
      price: 850,
      orderDate: '2024-01-15',
      deadline: '2024-02-15',
    ),

    // 4 — readyForDelivery (ready pieces, single)
    UserOrderModel(
      orderId: 'USR-2024-004',
      title: 'عباية بنفسجية مخملية مع تفاصيل ذهبية',
      imageUrl:
          'https://images.unsplash.com/photo-1604176354204-9268737828e4?w=300&q=80',
      orderType: UserOrderType.readyPieces,
      status: UserOrderStatus.readyForDelivery,
      price: 850,
      orderDate: '2024-01-15',
      deadline: '2024-02-15',
    ),

    // 5 — readyForDelivery (bundle — 3 pieces)
    UserOrderModel(
      orderId: 'USR-2024-005',
      title: 'مجموعة عبايات متنوعة',
      imageUrl:
          'https://images.unsplash.com/photo-1558769132-cb1aea458c5e?w=300&q=80',
      orderType: UserOrderType.readyPieces,
      status: UserOrderStatus.readyForDelivery,
      price: 1350,
      orderDate: '2024-01-08',
      deadline: '2024-02-08',
      piecesCount: 3,
      confirmedTailorName: 'مشغل الناقة الملكية',
    ),
  ];
}
