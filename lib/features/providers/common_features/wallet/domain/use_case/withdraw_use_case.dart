import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../../data/repository/wallet_repository.dart';
import '../../data/request/withdrawal_request.dart';

class WithdrawUseCase {
  final WalletRepository _repository;

  WithdrawUseCase(this._repository);

  Future<Either<Failure, void>> execute(WithdrawalRequest request) =>
      _repository.withdraw(request);
}
