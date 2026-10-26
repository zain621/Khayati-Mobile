/// Domain model for product action operations (delete, activate, cancel).
class ProductActionModel {
  final String status;
  final String message;

  const ProductActionModel({
    required this.status,
    required this.message,
  });
}
