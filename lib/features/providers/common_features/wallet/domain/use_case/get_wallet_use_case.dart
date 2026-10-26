import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../../data/repository/wallet_repository.dart';
import '../model/wallet_model.dart';

class GetWalletUseCase {
  final WalletRepository _repository;

  GetWalletUseCase(this._repository);

  Future<Either<Failure, WalletModel>> execute() => _repository.getWallet();
}
