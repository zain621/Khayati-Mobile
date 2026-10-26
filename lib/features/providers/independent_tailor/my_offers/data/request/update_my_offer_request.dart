/// Request params for updating (PATCH) a submitted offer.
class UpdateMyOfferRequest {
  final String offerId;
  final double proposedPrice;
  final int executionDays;
  final String details;

  const UpdateMyOfferRequest({
    required this.offerId,
    required this.proposedPrice,
    required this.executionDays,
    required this.details,
  });
}
