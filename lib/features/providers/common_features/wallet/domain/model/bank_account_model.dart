class BankAccountModel {
  final String id;
  final String bankName;
  final String accountHolderName;
  final String accountNumber;
  final String iban;
  final String? createdAt;

  const BankAccountModel({
    required this.id,
    required this.bankName,
    required this.accountHolderName,
    required this.accountNumber,
    required this.iban,
    this.createdAt,
  });
}
