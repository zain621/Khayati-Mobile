import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/error_handler/type_handler_enum.dart';
import 'package:app_mobile/core/error_handler/data_source_extension.dart';
import 'package:app_mobile/core/internet_checker/interent_checker.dart';
import '../data_source/loyalty_data_source.dart';
import '../mapper/loyalty_mapper.dart';
import '../request/redeem_loyalty_request.dart';
import '../../domain/model/loyalty_points_model.dart';
import '../../domain/model/loyalty_reward_model.dart';
import '../../domain/model/redeem_loyalty_model.dart';
import '../../domain/model/unused_loyalty_code_model.dart';

abstract class LoyaltyRepository {
  Future<Either<Failure, LoyaltyPointsModel>> getLoyaltyPoints();
  Future<Either<Failure, List<LoyaltyRewardModel>>> getLoyaltyRewards();
  Future<Either<Failure, RedeemLoyaltyModel>> redeemLoyalty(
      RedeemLoyaltyRequest request);
  Future<Either<Failure, List<UnusedLoyaltyCodeModel>>> getUnusedCodes();
}

class LoyaltyRepositoryImplement implements LoyaltyRepository {
  final LoyaltyDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  LoyaltyRepositoryImplement(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, LoyaltyPointsModel>> getLoyaltyPoints() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getLoyaltyPoints();
        return Right(response.toDomain());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(TypeHandlerEnum.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<LoyaltyRewardModel>>> getLoyaltyRewards() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getLoyaltyRewards();
        return Right(response.toDomain());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(TypeHandlerEnum.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, RedeemLoyaltyModel>> redeemLoyalty(
      RedeemLoyaltyRequest request) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.redeemLoyalty(request);
        return Right(response.toDomain());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(TypeHandlerEnum.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<UnusedLoyaltyCodeModel>>> getUnusedCodes() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getUnusedCodes();
        return Right(response.toDomain());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(TypeHandlerEnum.noInternetConnection.getFailure());
    }
  }
}
