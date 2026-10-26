import '../../../../../../constants/request_constants/request_constants.dart';

class AddBankAccountRequest {
  final String bankName;
  final String accountHolderName;
  final String accountNumber;
  final String iban;

  AddBankAccountRequest({
    required this.bankName,
    required this.accountHolderName,
    required this.accountNumber,
    required this.iban,
  });

  Map<String, dynamic> toMap() => {
        RequestConstants.bankName: bankName,
        RequestConstants.accountHolderName: accountHolderName,
        RequestConstants.accountNumber: accountNumber,
        RequestConstants.iban: iban,
      };
}
