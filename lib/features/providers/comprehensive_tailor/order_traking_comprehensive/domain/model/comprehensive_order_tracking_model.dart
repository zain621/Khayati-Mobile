// ─────────────────────────────────────────────────────────────────────────────
// Stage key constants
// ─────────────────────────────────────────────────────────────────────────────

import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:flutter/material.dart';

class ComprehensiveOrderStageKeys {
  static const String started = 'started';
  static const String readyToShip = 'ready_to_ship';
  static const String shipped = 'shipped';
  static const String inDelivery = 'in_delivery';
}

// ─────────────────────────────────────────────────────────────────────────────
// Derived stage enum (for UI filtering & badge)
// ─────────────────────────────────────────────────────────────────────────────

enum ComprehensiveShopOrderStage {
  newOrder,
  inPreparation,
  readyToShip,
  shipped,
  inDelivery,
}

// ─────────────────────────────────────────────────────────────────────────────
// Zoqak order status enum
// ─────────────────────────────────────────────────────────────────────────────

enum ComprehensiveZoqakStatus {
  pending,
  accepted,
  completed,
  cancelled,
  unknown,
}

// ─────────────────────────────────────────────────────────────────────────────
// Buyer/Requester model
// ─────────────────────────────────────────────────────────────────────────────

class ComprehensiveOrderBuyerModel {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String? imageUrl;

  const ComprehensiveOrderBuyerModel({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    this.imageUrl,
  });
}

class ComprehensiveRequesterModel {
  final String fullName;
  final String? image;
  final String phoneNumber;

  const ComprehensiveRequesterModel({
    required this.fullName,
    this.image,
    required this.phoneNumber,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// Seller model
// ─────────────────────────────────────────────────────────────────────────────

class ComprehensiveSellerModel {
  final String id;
  final String userId;
  final String nameAr;
  final String nameEn;

  const ComprehensiveSellerModel({
    required this.id,
    required this.userId,
    required this.nameAr,
    required this.nameEn,
  });

  String get displayName => nameAr;
}

// ─────────────────────────────────────────────────────────────────────────────
// Shop order item model
// ─────────────────────────────────────────────────────────────────────────────

class ComprehensiveShopItemModel {
  final String id;
  final String productName;
  final String color;
  final String size;
  final int quantity;
  final double unitPrice;
  final double totalPrice;

  const ComprehensiveShopItemModel({
    required this.id,
    required this.productName,
    required this.color,
    required this.size,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
  });

  String get formattedUnitPrice => '${unitPrice.toInt()} ${_currency}';
  String get formattedTotalPrice => '${totalPrice.toInt()} ${_currency}';
}

const _currency = 'د.إ';

// ─────────────────────────────────────────────────────────────────────────────
// Stage model (shared between shop & detail)
// ─────────────────────────────────────────────────────────────────────────────

class ComprehensiveStageModel {
  final String key;
  final String label;
  final bool completed;
  final String? statusDate;

  const ComprehensiveStageModel({
    required this.key,
    required this.label,
    required this.completed,
    this.statusDate,
  });
}

class ComprehensiveStagesSummaryModel {
  final int totalStages;
  final int completedStagesCount;
  final int incompleteStagesCount;

  const ComprehensiveStagesSummaryModel({
    required this.totalStages,
    required this.completedStagesCount,
    required this.incompleteStagesCount,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// Shop order model
// ─────────────────────────────────────────────────────────────────────────────

class ComprehensiveShopOrderModel {
  final String id;
  final String orderNumber;
  final String status;
  final String paymentStatus;
  final double totalAmount;
  final int itemsCount;
  final String createdAt;
  final ComprehensiveOrderBuyerModel buyer;
  final List<ComprehensiveShopItemModel> items;
  final List<ComprehensiveStageModel> stages;
  final int completedStagesCount;

  const ComprehensiveShopOrderModel({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.paymentStatus,
    required this.totalAmount,
    required this.itemsCount,
    required this.createdAt,
    required this.buyer,
    required this.items,
    required this.stages,
    required this.completedStagesCount,
  });

  String get formattedTotal => '${totalAmount.toInt()} $_currency';

  bool get isPaid => paymentStatus.toLowerCase() == 'paid';

  ComprehensiveShopOrderStage get currentStage {
    if (completedStagesCount == 0) {
      return ComprehensiveShopOrderStage.newOrder;
    }
    final started = _isCompleted(ComprehensiveOrderStageKeys.started);
    final readyToShip = _isCompleted(ComprehensiveOrderStageKeys.readyToShip);
    final shippedDone = _isCompleted(ComprehensiveOrderStageKeys.shipped);
    final inDelivery = _isCompleted(ComprehensiveOrderStageKeys.inDelivery);

    if (inDelivery) return ComprehensiveShopOrderStage.inDelivery;
    if (shippedDone) return ComprehensiveShopOrderStage.shipped;
    if (readyToShip) return ComprehensiveShopOrderStage.readyToShip;
    if (started) return ComprehensiveShopOrderStage.inPreparation;
    return ComprehensiveShopOrderStage.newOrder;
  }

  String? get nextStageKey {
    for (final stage in stages) {
      if (!stage.completed) return stage.key;
    }
    return null;
  }

  String? get nextStageLabel {
    for (final stage in stages) {
      if (!stage.completed) return stage.label;
    }
    return null;
  }

  bool _isCompleted(String key) =>
      stages.any((s) => s.key == key && s.completed);
}

// ─────────────────────────────────────────────────────────────────────────────
// Zoqak order model
// ─────────────────────────────────────────────────────────────────────────────

class ComprehensiveZoqakOrderModel {
  final String id;
  final String orderNumber;
  final String productName;
  final String? description;
  final String? specialRequests;
  final String? fabricType;
  final double minBudget;
  final double maxBudget;
  final String? deliveryDate;
  final List<String> similarImages;
  final ComprehensiveZoqakStatus status;
  final String statusKey;
  final String createdAt;
  final String userName;
  final String? userImage;
  final int offersCount;
  final String? paymentStatus;
  final String? acceptedByProviderId;
  final String? userId;
  final ComprehensiveZoqakOfferModel? offer;
  final List<ComprehensiveTimelineModel> timeline;

  const ComprehensiveZoqakOrderModel({
    required this.id,
    required this.orderNumber,
    required this.productName,
    this.description,
    this.specialRequests,
    this.fabricType,
    required this.minBudget,
    required this.maxBudget,
    this.deliveryDate,
    required this.similarImages,
    required this.status,
    this.statusKey = '',
    required this.createdAt,
    required this.userName,
    this.userImage,
    required this.offersCount,
    this.paymentStatus,
    this.acceptedByProviderId,
    this.userId,
    this.offer,
    this.timeline = const [],
  });

  String get budgetRange =>
      '${minBudget.toInt()} - ${maxBudget.toInt()} $_currency';

  bool get isPaid => paymentStatus?.toLowerCase() == 'paid';
}

// ─────────────────────────────────────────────────────────────────────────────
// Zoqak offer model
// ─────────────────────────────────────────────────────────────────────────────

class ComprehensiveZoqakOfferModel {
  final String id;
  final String orderId;
  final double proposedPrice;
  final int executionDays;
  final String details;
  final String status;
  final String createdAt;
  final String updatedAt;

  const ComprehensiveZoqakOfferModel({
    required this.id,
    required this.orderId,
    required this.proposedPrice,
    required this.executionDays,
    required this.details,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  String get formattedPrice => '${proposedPrice.toInt()} $_currency';
  String get executionText => '$executionDays ${ManagerStrings.daysShort}';
}

// ─────────────────────────────────────────────────────────────────────────────
// Timeline event model
// ─────────────────────────────────────────────────────────────────────────────

class ComprehensiveTimelineModel {
  final String code;
  final String occurredAt;

  const ComprehensiveTimelineModel({
    required this.code,
    required this.occurredAt,
  });

  String get displayLabel {
    switch (code) {
      case 'order_created':
        return ManagerStrings.timelineOrderCreated;
      case 'my_offer_submitted':
        return ManagerStrings.timelineOfferSubmitted;
      case 'offer_accepted':
        return ManagerStrings.timelineOfferAccepted;
      case 'work_started':
        return ManagerStrings.timelineWorkStarted;
      case 'work_completed':
        return ManagerStrings.timelineWorkCompleted;
      case 'order_delivered':
        return ManagerStrings.timelineOrderDelivered;
      default:
        return code;
    }
  }

  IconData get displayIcon {
    switch (code) {
      case 'order_created':
        return Icons.add_circle_outline;
      case 'my_offer_submitted':
        return Icons.send;
      case 'offer_accepted':
        return Icons.check_circle_outline;
      case 'work_started':
        return Icons.play_arrow;
      case 'work_completed':
        return Icons.task_alt;
      case 'order_delivered':
        return Icons.local_shipping;
      default:
        return Icons.info_outline;
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Combined model returned from the list API
// ─────────────────────────────────────────────────────────────────────────────

// ─────────────────────────────────────────────────────────────────────────────
// Zoqak offer detail (fetched from GET /my-offers/by-order/:orderId)
// ─────────────────────────────────────────────────────────────────────────────

class ZoqakOfferDetailModel {
  final ComprehensiveZoqakOfferModel offer;
  final ZoqakOfferDetailOrderModel order;
  final List<ComprehensiveTimelineModel> timeline;

  const ZoqakOfferDetailModel({
    required this.offer,
    required this.order,
    required this.timeline,
  });
}

class ZoqakOfferDetailOrderModel {
  final String id;
  final String orderNumber;
  final String productName;
  final String? description;
  final String? specialRequests;
  final String? fabricType;
  final double minBudget;
  final double maxBudget;
  final String? deliveryDate;
  final List<String> similarImages;
  final ComprehensiveZoqakStatus status;
  final ComprehensiveRequesterModel requester;

  const ZoqakOfferDetailOrderModel({
    required this.id,
    required this.orderNumber,
    required this.productName,
    this.description,
    this.specialRequests,
    this.fabricType,
    required this.minBudget,
    required this.maxBudget,
    this.deliveryDate,
    required this.similarImages,
    required this.status,
    required this.requester,
  });

  String get budgetRange =>
      '${minBudget.toInt()} - ${maxBudget.toInt()} $_currency';
}

// ─────────────────────────────────────────────────────────────────────────────
// Combined model returned from the list API
// ─────────────────────────────────────────────────────────────────────────────

class ComprehensiveOrdersModel {
  final List<ComprehensiveShopOrderModel> shopOrders;
  final List<ComprehensiveZoqakOrderModel> zoqakOrders;

  const ComprehensiveOrdersModel({
    required this.shopOrders,
    required this.zoqakOrders,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// Order detail model
// ─────────────────────────────────────────────────────────────────────────────

class ComprehensiveOrderDetailModel {
  final String source; // 'shop' | 'zoqak'
  final ComprehensiveShopOrderModel? shopOrder;

  const ComprehensiveOrderDetailModel({
    required this.source,
    this.shopOrder,
  });

  bool get isShop => source == 'shop';
}
