/// Domain model for a single zoqak offer from a tailor / provider.

enum ZoqakOfferStatus { pending, accepted, rejected, unknown }

class ZoqakOfferDomainModel {
  final String id;
  final String? orderId;
  final String? providerId;
  final double proposedPrice;
  final int executionDays;
  final String? details;
  final ZoqakOfferStatus status;
  final String? createdAt;

  // Provider info
  final String providerName;
  final String? providerImage;
  final bool providerIsAvailable;
  final String? providerRank;
  final String? providerRankLabel;
  final double providerRating;
  final int providerRatersCount;
  final int providerOffersCount;
  final int orderOffersCount;

  const ZoqakOfferDomainModel({
    required this.id,
    this.orderId,
    this.providerId,
    required this.proposedPrice,
    required this.executionDays,
    this.details,
    required this.status,
    this.createdAt,
    required this.providerName,
    this.providerImage,
    required this.providerIsAvailable,
    this.providerRank,
    this.providerRankLabel,
    required this.providerRating,
    required this.providerRatersCount,
    required this.providerOffersCount,
    required this.orderOffersCount,
  });
}
