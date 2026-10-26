// ─────────────────────────────────────────────────────────────────────────────
// Stage keys as constants
// ─────────────────────────────────────────────────────────────────────────────

class ShopOrderStageKeys {
  static const String started     = 'started';
  static const String readyToShip = 'ready_to_ship';
  static const String shipped     = 'shipped';
  static const String inDelivery  = 'in_delivery';
}

// ─────────────────────────────────────────────────────────────────────────────
// Derived current-stage enum (for UI filtering & status badge)
// ─────────────────────────────────────────────────────────────────────────────

enum ShopOrderCurrentStage {
  newOrder,      // 0 stages completed
  inPreparation, // "started" done, "ready_to_ship" not done
  readyToShip,   // "ready_to_ship" done, "shipped" not done
  shipped,       // "shipped" done, "in_delivery" not done
  inDelivery,    // all stages done
}

// ─────────────────────────────────────────────────────────────────────────────
// Buyer
// ─────────────────────────────────────────────────────────────────────────────

class ShopOrderBuyerModel {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String? imageUrl;

  const ShopOrderBuyerModel({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    this.imageUrl,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// Order item
// ─────────────────────────────────────────────────────────────────────────────

class ShopOrderItemModel {
  final String id;
  final String productName;
  final String color;
  final String size;
  final int quantity;
  final double unitPrice;
  final double totalPrice;

  const ShopOrderItemModel({
    required this.id,
    required this.productName,
    required this.color,
    required this.size,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
  });

  String get formattedUnitPrice => '${unitPrice.toInt()} د.إ';
  String get formattedTotalPrice => '${totalPrice.toInt()} د.إ';
}

// ─────────────────────────────────────────────────────────────────────────────
// Stage
// ─────────────────────────────────────────────────────────────────────────────

class ShopOrderStageModel {
  final String key;
  final String label;
  final bool completed;
  final String? statusDate;

  const ShopOrderStageModel({
    required this.key,
    required this.label,
    required this.completed,
    this.statusDate,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// Main order model
// ─────────────────────────────────────────────────────────────────────────────

class ShopOwnerOrderModel {
  final String id;
  final String orderNumber;
  final String status;
  final String paymentStatus;
  final double totalAmount;
  final int itemsCount;
  final String createdAt;
  final ShopOrderBuyerModel buyer;
  final List<ShopOrderItemModel> items;
  final List<ShopOrderStageModel> stages;
  final int completedStagesCount;

  const ShopOwnerOrderModel({
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

  String get formattedTotal => '${totalAmount.toInt()} د.إ';

  bool get isPaid => paymentStatus == 'paid';

  // Returns the current visual stage for badge/filter display.
  ShopOrderCurrentStage get currentStage {
    if (completedStagesCount == 0) return ShopOrderCurrentStage.newOrder;

    final started     = _isCompleted(ShopOrderStageKeys.started);
    final readyToShip = _isCompleted(ShopOrderStageKeys.readyToShip);
    final shippedDone = _isCompleted(ShopOrderStageKeys.shipped);
    final inDelivery  = _isCompleted(ShopOrderStageKeys.inDelivery);

    if (inDelivery) return ShopOrderCurrentStage.inDelivery;
    if (shippedDone) return ShopOrderCurrentStage.shipped;
    if (readyToShip) return ShopOrderCurrentStage.readyToShip;
    if (started) return ShopOrderCurrentStage.inPreparation;
    return ShopOrderCurrentStage.newOrder;
  }

  // Returns the key of the next incomplete stage, or null if all done.
  String? get nextStageKey {
    for (final stage in stages) {
      if (!stage.completed) return stage.key;
    }
    return null;
  }

  // Returns the label of the next incomplete stage, or null if all done.
  String? get nextStageLabel {
    for (final stage in stages) {
      if (!stage.completed) return stage.label;
    }
    return null;
  }

  bool _isCompleted(String key) {
    return stages.any((s) => s.key == key && s.completed);
  }
}
