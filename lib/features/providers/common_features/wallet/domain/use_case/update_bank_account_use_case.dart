import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../../data/repository/wallet_repository.dart';
import '../../data/request/add_bank_account_request.dart';
import '../model/bank_account_model.dart';

class UpdateBankAccountUseCase {
  final WalletRepository _repository;

  UpdateBankAccountUseCase(this._repository);

  Future<Either<Failure, BankAccountModel>> execute(
          String bankAccountId, AddBankAccountRequest request) =>
      _repository.updateBankAccount(bankAccountId, request);
}
