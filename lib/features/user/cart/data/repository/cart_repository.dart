import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/error_handler/type_handler_enum.dart';
import 'package:app_mobile/core/error_handler/data_source_extension.dart';
import 'package:app_mobile/core/internet_checker/interent_checker.dart';
import '../data_source/cart_data_source.dart';
import '../mapper/cart_mapper.dart';
import '../request/add_cart_item_request.dart';
import '../request/update_cart_item_request.dart';
import '../request/apply_coupon_request.dart';
import '../../domain/model/cart_model.dart';
import '../../domain/model/checkout_model.dart';

abstract class CartRepository {
  Future<Either<Failure, CartModel>> getCart();
  Future<Either<Failure, CartModel>> addCartItem(AddCartItemRequest request);
  Future<Either<Failure, CartModel>> updateCartItem(UpdateCartItemRequest request);
  Future<Either<Failure, CartModel>> removeCartItem(String cartItemId);
  Future<Either<Failure, CartModel>> applyCoupon(ApplyCouponRequest request);
  Future<Either<Failure, CartModel>> removeCoupon();
  Future<Either<Failure, CheckoutModel>> checkout();
}

class CartRepositoryImplement implements CartRepository {
  final CartDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  CartRepositoryImplement(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, CartModel>> getCart() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getCart();
        return Right(response.toDomain());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(TypeHandlerEnum.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, CartModel>> addCartItem(AddCartItemRequest request) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.addCartItem(request.toBody());
        return Right(response.toDomain());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(TypeHandlerEnum.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, CartModel>> updateCartItem(UpdateCartItemRequest request) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.updateCartItem(
          request.cartItemId,
          request.quantity,
        );
        return Right(response.toDomain());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(TypeHandlerEnum.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, CartModel>> removeCartItem(String cartItemId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.removeCartItem(cartItemId);
        return Right(response.toDomain());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(TypeHandlerEnum.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, CartModel>> applyCoupon(ApplyCouponRequest request) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.applyCoupon(request.code);
        return Right(response.toDomain());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(TypeHandlerEnum.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, CartModel>> removeCoupon() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.removeCoupon();
        return Right(response.toDomain());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(TypeHandlerEnum.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, CheckoutModel>> checkout() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.checkout();
        return Right(response.toDomain());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(TypeHandlerEnum.noInternetConnection.getFailure());
    }
  }
}
