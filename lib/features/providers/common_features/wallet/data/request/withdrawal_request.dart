import '../../../../../../constants/request_constants/request_constants.dart';

class WithdrawalRequest {
  final double amount;
  final String? notes;
  final String bankAccountId;

  WithdrawalRequest({
    required this.amount,
    this.notes,
    required this.bankAccountId,
  });

  Map<String, dynamic> toMap() => {
        RequestConstants.amount: amount,
        RequestConstants.notes: notes,
        RequestConstants.bankAccountId: bankAccountId,
      };
}
