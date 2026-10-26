import 'package:dartz/dartz.dart';
import '../../../../../core/error_handler/data_source_extension.dart';
import '../../../../../core/error_handler/error_handler.dart';
import '../../../../../core/error_handler/failure.dart';
import '../../../../../core/error_handler/type_handler_enum.dart';
import '../../../../../core/internet_checker/interent_checker.dart';
import '../../../cart/domain/model/checkout_model.dart';
import '../data_source/my_orders_data_source.dart';
import '../mapper/my_orders_mapper.dart';
import '../../domain/model/user_order_domain_model.dart';
import '../../domain/model/zoqak_offer_domain_model.dart';

abstract class MyOrdersRepository {
  Future<Either<Failure, List<UserOrderDomainModel>>> getUserOrders();
  Future<Either<Failure, List<ZoqakOfferDomainModel>>> getZoqakOffers(String orderId);
  Future<Either<Failure, UserOrderDomainModel>> getOrderDetail(String orderId);
  Future<Either<Failure, CheckoutPaymentModel?>> acceptZoqakOffer(
    String orderId,
    String offerId,
  );
}

class MyOrdersRepositoryImplement implements MyOrdersRepository {
  final MyOrdersDataSource _dataSource;
  final NetworkInfo _networkInfo;

  MyOrdersRepositoryImplement(this._dataSource, this._networkInfo);

  @override
  Future<Either<Failure, List<UserOrderDomainModel>>> getUserOrders() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _dataSource.getUserOrders();
        final orders = (response.data?.orders ?? [])
            .map((item) => item.toDomain())
            .toList();
        return Right(orders);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(TypeHandlerEnum.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<ZoqakOfferDomainModel>>> getZoqakOffers(
      String orderId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _dataSource.getZoqakOffers(orderId);
        final offers = (response.data ?? [])
            .map((item) => item.toDomain())
            .toList();
        return Right(offers);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(TypeHandlerEnum.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, CheckoutPaymentModel?>> acceptZoqakOffer(
      String orderId, String offerId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _dataSource.acceptZoqakOffer(orderId, offerId);
        final payment = response.data?.payment;
        if (payment == null) {
          return const Right(null);
        }
        return Right(
          CheckoutPaymentModel(
            paymentSessionId: payment.paymentSessionId ?? '',
            provider: payment.provider ?? '',
            status: payment.status ?? 'pending',
            paymentUrl: payment.paymentUrl ?? '',
            invoiceUrl: payment.invoiceUrl,
          ),
        );
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(TypeHandlerEnum.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserOrderDomainModel>> getOrderDetail(
      String orderId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _dataSource.getOrderDetail(orderId);
        if (response.data == null) {
          return Left(TypeHandlerEnum.badRequest.getFailure());
        }
        return Right(response.data!.toDomain());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(TypeHandlerEnum.noInternetConnection.getFailure());
    }
  }
}
