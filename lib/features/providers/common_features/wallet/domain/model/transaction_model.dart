class TransactionModel {
  final String id;
  final String type;
  final String typeLabel;
  final double amount;
  final String description;
  final String createdAt;

  const TransactionModel({
    required this.id,
    required this.type,
    required this.typeLabel,
    required this.amount,
    required this.description,
    required this.createdAt,
  });

  bool get isDebit =>
      type.contains('debit') || type.contains('withdrawal') || type.contains('withdraw');
}
