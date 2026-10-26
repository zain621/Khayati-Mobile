import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/network/app_api.dart';
import '../../data/data_source/wallet_data_source.dart';
import '../../data/repository/wallet_repository.dart';
import '../../domain/use_case/get_wallet_use_case.dart';
import '../../domain/use_case/get_transactions_use_case.dart';
import '../../domain/use_case/get_bank_accounts_use_case.dart';
import '../../domain/use_case/add_bank_account_use_case.dart';
import '../../domain/use_case/update_bank_account_use_case.dart';
import '../../domain/use_case/withdraw_use_case.dart';
import '../../persentation/controller/wallet_controller.dart';

// ──────────────────────────────────────────────────────────────────────────
// Data-layer registrations
// ──────────────────────────────────────────────────────────────────────────

void _initWalletDeps() {
  if (!GetIt.I.isRegistered<WalletDataSource>()) {
    instance.registerLazySingleton<WalletDataSource>(
      () => WalletDataSourceImplement(instance<AppService>()),
    );
  }
  if (!GetIt.I.isRegistered<WalletRepository>()) {
    instance.registerLazySingleton<WalletRepository>(
      () => WalletRepositoryImplement(instance<WalletDataSource>()),
    );
  }
  if (!GetIt.I.isRegistered<GetWalletUseCase>()) {
    instance.registerFactory<GetWalletUseCase>(
      () => GetWalletUseCase(instance<WalletRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<GetTransactionsUseCase>()) {
    instance.registerFactory<GetTransactionsUseCase>(
      () => GetTransactionsUseCase(instance<WalletRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<GetBankAccountsUseCase>()) {
    instance.registerFactory<GetBankAccountsUseCase>(
      () => GetBankAccountsUseCase(instance<WalletRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<AddBankAccountUseCase>()) {
    instance.registerFactory<AddBankAccountUseCase>(
      () => AddBankAccountUseCase(instance<WalletRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<UpdateBankAccountUseCase>()) {
    instance.registerFactory<UpdateBankAccountUseCase>(
      () => UpdateBankAccountUseCase(instance<WalletRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<WithdrawUseCase>()) {
    instance.registerFactory<WithdrawUseCase>(
      () => WithdrawUseCase(instance<WalletRepository>()),
    );
  }
}

void _disposeWalletDeps() {
  if (GetIt.I.isRegistered<WithdrawUseCase>()) {
    instance.unregister<WithdrawUseCase>();
  }
  if (GetIt.I.isRegistered<UpdateBankAccountUseCase>()) {
    instance.unregister<UpdateBankAccountUseCase>();
  }
  if (GetIt.I.isRegistered<AddBankAccountUseCase>()) {
    instance.unregister<AddBankAccountUseCase>();
  }
  if (GetIt.I.isRegistered<GetBankAccountsUseCase>()) {
    instance.unregister<GetBankAccountsUseCase>();
  }
  if (GetIt.I.isRegistered<GetTransactionsUseCase>()) {
    instance.unregister<GetTransactionsUseCase>();
  }
  if (GetIt.I.isRegistered<GetWalletUseCase>()) {
    instance.unregister<GetWalletUseCase>();
  }
  if (GetIt.I.isRegistered<WalletRepository>()) {
    instance.unregister<WalletRepository>();
  }
  if (GetIt.I.isRegistered<WalletDataSource>()) {
    instance.unregister<WalletDataSource>();
  }
}

// ──────────────────────────────────────────────────────────────────────────
// Public API
// ──────────────────────────────────────────────────────────────────────────

void initWallet() {
  _initWalletDeps();
  if (!Get.isRegistered<WalletController>()) {
    Get.put(WalletController(
      getWalletUseCase: instance<GetWalletUseCase>(),
      getTransactionsUseCase: instance<GetTransactionsUseCase>(),
      getBankAccountsUseCase: instance<GetBankAccountsUseCase>(),
      addBankAccountUseCase: instance<AddBankAccountUseCase>(),
      updateBankAccountUseCase: instance<UpdateBankAccountUseCase>(),
      withdrawUseCase: instance<WithdrawUseCase>(),
    ));
  }
}

void disposeWallet() {
  if (Get.isRegistered<WalletController>()) {
    Get.delete<WalletController>();
  }
  _disposeWalletDeps();
}
