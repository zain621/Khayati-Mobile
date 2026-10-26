import '../response/wallet_response.dart';
import '../response/transactions_response.dart';
import '../response/bank_account_response.dart';
import '../../domain/model/wallet_model.dart';
import '../../domain/model/transaction_model.dart';
import '../../domain/model/bank_account_model.dart';

// ── WalletDataResponse → WalletModel ─────────────────────────────────────

extension WalletDataResponseMapper on WalletDataResponse {
  WalletModel toDomain() => WalletModel(
        pendingBalance: pendingBalance ?? 0,
        withdrawableBalance: withdrawableBalance ?? 0,
        totalBalance: totalBalance ?? 0,
      );
}

// ── TransactionItemResponse → TransactionModel ───────────────────────────

extension TransactionItemResponseMapper on TransactionItemResponse {
  TransactionModel toDomain() => TransactionModel(
        id: id ?? '',
        type: type ?? '',
        typeLabel: typeLabel ?? '',
        amount: amount ?? 0,
        description: description ?? '',
        createdAt: createdAt ?? '',
      );
}

extension TransactionItemListMapper on List<TransactionItemResponse> {
  List<TransactionModel> toDomain() => map((e) => e.toDomain()).toList();
}

// ── BankAccountDataResponse → BankAccountModel ───────────────────────────

extension BankAccountDataResponseMapper on BankAccountDataResponse {
  BankAccountModel toDomain() => BankAccountModel(
        id: id ?? '',
        bankName: bankName ?? '',
        accountHolderName: accountHolderName ?? '',
        accountNumber: accountNumber ?? '',
        iban: iban ?? '',
        createdAt: createdAt,
      );
}

extension BankAccountDataListMapper on List<BankAccountDataResponse> {
  List<BankAccountModel> toDomain() => map((e) => e.toDomain()).toList();
}
