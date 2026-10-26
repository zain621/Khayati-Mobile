import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../../data/repository/wallet_repository.dart';
import '../model/transaction_model.dart';

class GetTransactionsUseCase {
  final WalletRepository _repository;

  GetTransactionsUseCase(this._repository);

  Future<Either<Failure, List<TransactionModel>>> execute() =>
      _repository.getTransactions();
}
