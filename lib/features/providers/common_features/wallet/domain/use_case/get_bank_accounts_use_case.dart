import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../../data/repository/wallet_repository.dart';
import '../model/bank_account_model.dart';

class GetBankAccountsUseCase {
  final WalletRepository _repository;

  GetBankAccountsUseCase(this._repository);

  Future<Either<Failure, List<BankAccountModel>>> execute() =>
      _repository.getBankAccounts();
}
