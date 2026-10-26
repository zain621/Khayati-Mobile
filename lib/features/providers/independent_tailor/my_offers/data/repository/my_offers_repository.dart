import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../data_source/my_offers_data_source.dart';
import '../mapper/get_my_offers_mapper.dart';
import '../mapper/order_detail_mapper.dart';
import '../request/update_my_offer_request.dart';
import '../../domain/model/my_offer_model.dart';
import '../../domain/model/order_detail_model.dart';

abstract class MyOffersRepository {
  Future<Either<Failure, List<MyOfferModel>>> fetchMyOffers();
  Future<Either<Failure, MyOfferModel>> updateMyOffer(UpdateMyOfferRequest req);
  Future<Either<Failure, bool>> deleteMyOffer(String offerId);
  Future<Either<Failure, OrderDetailModel>> getOrderDetail(String orderId);
}

class MyOffersRepositoryImplement implements MyOffersRepository {
  final MyOffersDataSource _remoteDataSource;

  MyOffersRepositoryImplement(this._remoteDataSource);

  @override
  Future<Either<Failure, List<MyOfferModel>>> fetchMyOffers() async {
    try {
      final response = await _remoteDataSource.fetchMyOffers();
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, MyOfferModel>> updateMyOffer(
      UpdateMyOfferRequest req) async {
    try {
      final response = await _remoteDataSource.updateMyOffer(req);
      final item = response.data;
      if (item != null) {
        return Right(item.toDomain());
      }
      return Left(ErrorHandler.handle(Exception('No data')).failure);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, bool>> deleteMyOffer(String offerId) async {
    try {
      await _remoteDataSource.deleteMyOffer(offerId);
      return const Right(true);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, OrderDetailModel>> getOrderDetail(
      String orderId) async {
    try {
      final response = await _remoteDataSource.getOrderDetail(orderId);
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}

