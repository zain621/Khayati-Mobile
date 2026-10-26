import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../data_source/wallet_data_source.dart';
import '../mapper/wallet_mapper.dart';
import '../request/add_bank_account_request.dart';
import '../request/withdrawal_request.dart';
import '../../domain/model/wallet_model.dart';
import '../../domain/model/transaction_model.dart';
import '../../domain/model/bank_account_model.dart';

abstract class WalletRepository {
  Future<Either<Failure, WalletModel>> getWallet();
  Future<Either<Failure, List<TransactionModel>>> getTransactions();
  Future<Either<Failure, List<BankAccountModel>>> getBankAccounts();
  Future<Either<Failure, BankAccountModel>> addBankAccount(
      AddBankAccountRequest request);
  Future<Either<Failure, BankAccountModel>> updateBankAccount(
      String bankAccountId, AddBankAccountRequest request);
  Future<Either<Failure, void>> withdraw(WithdrawalRequest request);
}

class WalletRepositoryImplement implements WalletRepository {
  final WalletDataSource _dataSource;

  WalletRepositoryImplement(this._dataSource);

  @override
  Future<Either<Failure, WalletModel>> getWallet() async {
    try {
      final response = await _dataSource.getWallet();
      return Right(response.data!.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, List<TransactionModel>>> getTransactions() async {
    try {
      final response = await _dataSource.getTransactions();
      final items = response.data?.items ?? [];
      return Right(items.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, List<BankAccountModel>>> getBankAccounts() async {
    try {
      final response = await _dataSource.getBankAccounts();
      final items = response.data ?? [];
      return Right(items.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, BankAccountModel>> addBankAccount(
      AddBankAccountRequest request) async {
    try {
      final response = await _dataSource.addBankAccount(request);
      return Right(response.data!.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, BankAccountModel>> updateBankAccount(
      String bankAccountId, AddBankAccountRequest request) async {
    try {
      final response = await _dataSource.updateBankAccount(bankAccountId, request);
      return Right(response.data!.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> withdraw(WithdrawalRequest request) async {
    try {
      await _dataSource.withdraw(request);
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
