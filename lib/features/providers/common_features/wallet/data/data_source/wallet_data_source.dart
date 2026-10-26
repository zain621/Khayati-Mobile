import 'package:app_mobile/core/network/app_api.dart';
import '../request/add_bank_account_request.dart';
import '../request/withdrawal_request.dart';
import '../response/wallet_response.dart';
import '../response/transactions_response.dart';
import '../response/bank_account_response.dart';
import '../response/wallet_action_response.dart';

abstract class WalletDataSource {
  Future<WalletResponse> getWallet();
  Future<TransactionsResponse> getTransactions();
  Future<BankAccountsResponse> getBankAccounts();
  Future<BankAccountActionResponse> addBankAccount(AddBankAccountRequest request);
  Future<BankAccountActionResponse> updateBankAccount(
      String bankAccountId, AddBankAccountRequest request);
  Future<WalletActionResponse> withdraw(WithdrawalRequest request);
}

class WalletDataSourceImplement implements WalletDataSource {
  final AppService _appService;

  WalletDataSourceImplement(this._appService);

  @override
  Future<WalletResponse> getWallet() => _appService.getTraderWallet();

  @override
  Future<TransactionsResponse> getTransactions() =>
      _appService.getWalletTransactions();

  @override
  Future<BankAccountsResponse> getBankAccounts() =>
      _appService.getBankAccounts();

  @override
  Future<BankAccountActionResponse> addBankAccount(
          AddBankAccountRequest request) =>
      _appService.addBankAccount(request.toMap());

  @override
  Future<BankAccountActionResponse> updateBankAccount(
          String bankAccountId, AddBankAccountRequest request) =>
      _appService.updateBankAccount(bankAccountId, request.toMap());

  @override
  Future<WalletActionResponse> withdraw(WithdrawalRequest request) =>
      _appService.requestWithdrawal(request.toMap());
}
