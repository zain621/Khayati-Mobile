/// Status of a submitted offer (maps from API "pending" → underReview).
enum OfferStatus {
  accepted,
  underReview,
  rejected,
}

/// Nested offer detail (the tailor's own offer on an order).
class OfferDetailModel {
  final String id;
  final double proposedPrice;
  final int executionDays;
  final String details;
  final OfferStatus status;
  final String createdAt;

  const OfferDetailModel({
    required this.id,
    required this.proposedPrice,
    required this.executionDays,
    required this.details,
    required this.status,
    required this.createdAt,
  });

  String get formattedPrice {
    final priceInt = proposedPrice.toInt();
    if (priceInt >= 1000) {
      return '${priceInt ~/ 1000},${(priceInt % 1000).toString().padLeft(3, '0')}';
    }
    return priceInt.toString();
  }
}

/// Nested client budget range.
class ClientBudgetModel {
  final double minExpectedBudget;
  final double maxExpectedBudget;

  const ClientBudgetModel({
    required this.minExpectedBudget,
    required this.maxExpectedBudget,
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

/// Domain model for a single record in the my-offers list.
class MyOfferModel {
  final String orderId;
  final String orderNumber;
  final String? requesterImage;
  final String requesterName;
  final String? requesterDescription;
  final OfferDetailModel myOffer;
  final ClientBudgetModel clientBudget;
  final int competitorsCount;

  const MyOfferModel({
    required this.orderId,
    required this.orderNumber,
    this.requesterImage,
    required this.requesterName,
    this.requesterDescription,
    required this.myOffer,
    required this.clientBudget,
    required this.competitorsCount,
  });
}
