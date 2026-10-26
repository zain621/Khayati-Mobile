import 'package:get/get.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import '../../data/request/add_bank_account_request.dart';
import '../../data/request/withdrawal_request.dart';
import '../../domain/model/wallet_model.dart';
import '../../domain/model/transaction_model.dart';
import '../../domain/model/bank_account_model.dart';
import '../../domain/use_case/get_wallet_use_case.dart';
import '../../domain/use_case/get_transactions_use_case.dart';
import '../../domain/use_case/get_bank_accounts_use_case.dart';
import '../../domain/use_case/add_bank_account_use_case.dart';
import '../../domain/use_case/update_bank_account_use_case.dart';
import '../../domain/use_case/withdraw_use_case.dart';

class WalletController extends GetxController {
  final GetWalletUseCase getWalletUseCase;
  final GetTransactionsUseCase getTransactionsUseCase;
  final GetBankAccountsUseCase getBankAccountsUseCase;
  final AddBankAccountUseCase addBankAccountUseCase;
  final UpdateBankAccountUseCase updateBankAccountUseCase;
  final WithdrawUseCase withdrawUseCase;

  WalletController({
    required this.getWalletUseCase,
    required this.getTransactionsUseCase,
    required this.getBankAccountsUseCase,
    required this.addBankAccountUseCase,
    required this.updateBankAccountUseCase,
    required this.withdrawUseCase,
  });

  // ─── State ───────────────────────────────────────────────────────────────

  final Rxn<WalletModel> wallet = Rxn();
  final RxList<TransactionModel> transactions = <TransactionModel>[].obs;
  final RxList<BankAccountModel> bankAccounts = <BankAccountModel>[].obs;

  final RxBool isLoadingWallet = false.obs;
  final RxBool isLoadingTransactions = false.obs;
  final RxBool isLoadingBankAccounts = false.obs;
  final RxBool isSaving = false.obs;

  // ─── Derived ─────────────────────────────────────────────────────────────

  BankAccountModel? get primaryBankAccount =>
      bankAccounts.isNotEmpty ? bankAccounts.first : null;

  bool get hasBankAccount => bankAccounts.isNotEmpty;

  // ─── Lifecycle ───────────────────────────────────────────────────────────

  @override
  void onInit() {
    super.onInit();
    loadAll();
  }

  // ─── Load ─────────────────────────────────────────────────────────────────

  void loadAll() {
    loadWallet();
    loadTransactions();
    loadBankAccounts();
  }

  Future<void> loadWallet() async {
    isLoadingWallet.value = true;
    final result = await getWalletUseCase.execute();
    result.fold(
      (Failure failure) => AppSnackbar.error(failure.message),
      (WalletModel model) => wallet.value = model,
    );
    isLoadingWallet.value = false;
  }

  Future<void> loadTransactions() async {
    isLoadingTransactions.value = true;
    final result = await getTransactionsUseCase.execute();
    result.fold(
      (Failure failure) => AppSnackbar.error(failure.message),
      (List<TransactionModel> items) => transactions.assignAll(items),
    );
    isLoadingTransactions.value = false;
  }

  Future<void> loadBankAccounts() async {
    isLoadingBankAccounts.value = true;
    final result = await getBankAccountsUseCase.execute();
    result.fold(
      (Failure failure) => AppSnackbar.error(failure.message),
      (List<BankAccountModel> items) => bankAccounts.assignAll(items),
    );
    isLoadingBankAccounts.value = false;
  }

  // ─── Add bank account ────────────────────────────────────────────────────

  Future<bool> addBankAccount(AddBankAccountRequest request) async {
    isSaving.value = true;
    final result = await addBankAccountUseCase.execute(request);
    isSaving.value = false;
    return result.fold(
      (Failure failure) {
        AppSnackbar.error(failure.message);
        return false;
      },
      (BankAccountModel account) {
        bankAccounts.add(account);
        AppSnackbar.success(
          ManagerStrings.walletBankAccountAddSuccess,
          englishMessage: ManagerStrings.walletBankAccountAddSuccessEn,
        );
        return true;
      },
    );
  }

  // ─── Update bank account ─────────────────────────────────────────────────

  Future<bool> updateBankAccount(
      String bankAccountId, AddBankAccountRequest request) async {
    isSaving.value = true;
    final result =
        await updateBankAccountUseCase.execute(bankAccountId, request);
    isSaving.value = false;
    return result.fold(
      (Failure failure) {
        AppSnackbar.error(failure.message);
        return false;
      },
      (BankAccountModel updated) {
        final idx = bankAccounts.indexWhere((a) => a.id == bankAccountId);
        if (idx >= 0) {
          bankAccounts[idx] = updated;
        } else {
          bankAccounts.add(updated);
        }
        AppSnackbar.success(
          ManagerStrings.walletBankAccountUpdateSuccess,
          englishMessage: ManagerStrings.walletBankAccountUpdateSuccessEn,
        );
        return true;
      },
    );
  }

  // ─── Withdraw ────────────────────────────────────────────────────────────

  Future<bool> withdraw(WithdrawalRequest request) async {
    isSaving.value = true;
    final result = await withdrawUseCase.execute(request);
    isSaving.value = false;
    return result.fold(
      (Failure failure) {
        AppSnackbar.error(failure.message);
        return false;
      },
      (_) {
        AppSnackbar.success(
          ManagerStrings.walletWithdrawSuccess,
          englishMessage: ManagerStrings.walletWithdrawSuccessEn,
        );
        loadWallet();
        loadTransactions();
        return true;
      },
    );
  }
}
