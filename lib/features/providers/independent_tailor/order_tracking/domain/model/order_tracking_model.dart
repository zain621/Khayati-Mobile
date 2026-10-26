enum OrderTrackingStatus {
  accepted,
  inProgress,
  ready,
  readyForDelivery,
  completed,
  unknown,
}

class OrderTrackingStageModel {
  final String key;
  final String label;
  final bool completed;
  final String statusDate;

  const OrderTrackingStageModel({
    required this.key,
    required this.label,
    required this.completed,
    required this.statusDate,
  });
}

class OrderTrackingStagesSummaryModel {
  final int totalStages;
  final int completedStagesCount;
  final int incompleteStagesCount;

  const OrderTrackingStagesSummaryModel({
    required this.totalStages,
    required this.completedStagesCount,
    required this.incompleteStagesCount,
  });
}

class OrderTrackingLatestStatusModel {
  final String key;
  final String label;
  final String statusDate;

  const OrderTrackingLatestStatusModel({
    required this.key,
    required this.label,
    required this.statusDate,
  });
}

class OrderTrackingItemModel {
  final String orderId;
  final String orderNumber;
  final String userName;
  final String? userImage;
  final double price;
  final String statusPayment;
  final OrderTrackingStatus status;
  final List<OrderTrackingStageModel> stages;
  final OrderTrackingStagesSummaryModel stagesSummary;
  final OrderTrackingLatestStatusModel latestStatus;
  final String orderDate;
  final String deliveryDeadline;

  const OrderTrackingItemModel({
    required this.orderId,
    required this.orderNumber,
    required this.userName,
    required this.userImage,
    required this.price,
    required this.statusPayment,
    required this.status,
    required this.stages,
    required this.stagesSummary,
    required this.latestStatus,
    required this.orderDate,
    required this.deliveryDeadline,
  });

  String get formattedPrice {
    final priceInt = price.toInt();
    if (priceInt >= 1000) {
      return '${(priceInt / 1000).toStringAsFixed(0)},${(priceInt % 1000).toString().padLeft(3, '0')}';
    }
    return priceInt.toString();
  }
}

class OrderTrackingCountsModel {
  final int all;
  final int accepted;
  final int inProgress;
  final int ready;
  final int readyForDelivery;
  final int completed;

  const OrderTrackingCountsModel({
    required this.all,
    required this.accepted,
    required this.inProgress,
    required this.ready,
    required this.readyForDelivery,
    required this.completed,
  });
}

class OrderTrackingDataModel {
  final List<OrderTrackingItemModel> items;
  final OrderTrackingCountsModel counts;

  const OrderTrackingDataModel({
    required this.items,
    required this.counts,
  });
}

class OrderTrackingDetailMyOfferModel {
  final double proposedPrice;
  final int executionDays;
  final String details;
  final String createdAt;

  const OrderTrackingDetailMyOfferModel({
    required this.proposedPrice,
    required this.executionDays,
    required this.details,
    required this.createdAt,
  });
}

class OrderTrackingDetailModel {
  final String orderId;
  final String orderNumber;
  final OrderTrackingStatus status;
  final List<OrderTrackingStageModel> stages;
  final OrderTrackingStagesSummaryModel stagesSummary;
  final OrderTrackingLatestStatusModel latestStatus;
  final String paymentStatus;
  final String orderDate;
  final String deliveryDeadline;
  final String userName;
  final String? userImage;
  final String userPhone;
  final String productName;
  final String description;
  final String specialRequests;
  final String fabricType;
  final double minExpectedBudget;
  final double maxExpectedBudget;
  final List<String> similarImages;
  final OrderTrackingDetailMyOfferModel? myOffer;

  const OrderTrackingDetailModel({
    required this.orderId,
    required this.orderNumber,
    required this.status,
    required this.stages,
    required this.stagesSummary,
    required this.latestStatus,
    required this.paymentStatus,
    required this.orderDate,
    required this.deliveryDeadline,
    required this.userName,
    this.userImage,
    required this.userPhone,
    required this.productName,
    required this.description,
    required this.specialRequests,
    required this.fabricType,
    required this.minExpectedBudget,
    required this.maxExpectedBudget,
    required this.similarImages,
    this.myOffer,
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
