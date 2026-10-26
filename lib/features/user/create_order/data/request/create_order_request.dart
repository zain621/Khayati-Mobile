import 'dart:io';

/// Payload sent to POST /zoqak.
class CreateOrderRequest {
  final String productName;
  final String description;
  final String specialRequests;
  final String fabricType;
  final String deliveryDate;
  final double minExpectedBudget;
  final double maxExpectedBudget;
  final List<File>? similarImages;

  const CreateOrderRequest({
    required this.productName,
    required this.description,
    required this.specialRequests,
    required this.fabricType,
    required this.deliveryDate,
    required this.minExpectedBudget,
    required this.maxExpectedBudget,
    this.similarImages,
  });
}
