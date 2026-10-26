/// Domain model for a user order item (list view).
/// Supports both shop orders and zoqak (custom tailoring) orders.

enum UserOrderApiType { shop, zoqak }

enum UserOrderApiStatus {
  active,
  accepted,
  completed,
  cancelled,
  unknown,
}

class UserOrderDomainModel {
  final String id;
  final String orderNumber;
  final UserOrderApiType orderType;

  // Shop-specific
  final String? shopId;
  final String? shopName;
  final double? totalAmount;
  final String? paymentStatus;
  final List<OrderItemLineDomain>? items;

  // Zoqak-specific
  final String? productName;
  final String? description;
  final String? fabricType;
  final double? minBudget;
  final double? maxBudget;
  final String? deliveryDate;
  final List<String>? similarImages;
  final String? acceptedByProviderId;
  final String? acceptedByProviderName;

  // Common
  final UserOrderApiStatus status;
  final List<OrderStageDomain> stages;
  final int totalStages;
  final int completedStages;
  final String createdAt;
  final String? updatedAt;

  const UserOrderDomainModel({
    required this.id,
    required this.orderNumber,
    required this.orderType,
    this.shopId,
    this.shopName,
    this.totalAmount,
    this.paymentStatus,
    this.items,
    this.productName,
    this.description,
    this.fabricType,
    this.minBudget,
    this.maxBudget,
    this.deliveryDate,
    this.similarImages,
    this.acceptedByProviderId,
    this.acceptedByProviderName,
    required this.status,
    required this.stages,
    required this.totalStages,
    required this.completedStages,
    required this.createdAt,
    this.updatedAt,
  });

  /// Display title for the order (shop name or product name)
  String get displayTitle {
    if (orderType == UserOrderApiType.shop) {
      return shopName ?? orderNumber;
    }
    return productName ?? orderNumber;
  }

  /// First image URL for the order card thumbnail
  String? get thumbnailUrl {
    if (orderType == UserOrderApiType.shop) {
      return items?.isNotEmpty == true ? items!.first.imageUrl : null;
    }
    return similarImages?.isNotEmpty == true ? similarImages!.first : null;
  }

  bool get isZoqak => orderType == UserOrderApiType.zoqak;
  bool get isShop => orderType == UserOrderApiType.shop;

  /// Whether the order has an accepted provider (zoqak only)
  bool get hasAcceptedOffer => acceptedByProviderId?.isNotEmpty == true;
}

class OrderStageDomain {
  final String key;
  final String label;
  final bool completed;
  final String? statusDate;

  const OrderStageDomain({
    required this.key,
    required this.label,
    required this.completed,
    this.statusDate,
  });
}

class OrderItemLineDomain {
  final String id;
  final String? productId;
  final String? productName;
  final String? variantId;
  final String? color;
  final String? size;
  final int quantity;
  final double unitPrice;
  final double totalPrice;
  final String? imageUrl;

  const OrderItemLineDomain({
    required this.id,
    this.productId,
    this.productName,
    this.variantId,
    this.color,
    this.size,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    this.imageUrl,
  });
}
