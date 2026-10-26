import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../data_source/products_data_source.dart';
import '../mapper/products_mapper.dart';
import '../mapper/product_action_mapper.dart';
import '../request/add_variant_request.dart';
import '../../domain/model/product_model.dart';
import '../../domain/model/product_action_model.dart';

/// Abstract repository for products operations.
abstract class ProductsRepository {
  Future<Either<Failure, ProductsListModel>> getProducts();
  Future<Either<Failure, ProductModel>> getProductDetails(String productId);
  Future<Either<Failure, ProductActionModel>> createProduct(FormData formData);
  Future<Either<Failure, ProductActionModel>> updateProduct(String productId, FormData formData);
  Future<Either<Failure, ProductActionModel>> deleteProduct(String productId);
  Future<Either<Failure, ProductActionModel>> activateProduct(String productId);
  Future<Either<Failure, ProductActionModel>> cancelProduct(String productId);
  Future<Either<Failure, ProductActionModel>> addVariant(String productId, AddVariantRequest req);
  Future<Either<Failure, ProductActionModel>> updateVariant(String productId, String variantId, AddVariantRequest req);
  Future<Either<Failure, ProductActionModel>> deleteVariant(String productId, String variantId);
  Future<Either<Failure, ProductActionModel>> deleteProductImage(String productId, String imageId);
}

/// Implementation of ProductsRepository.
class ProductsRepositoryImplement implements ProductsRepository {
  final ProductsDataSource _remoteDataSource;

  ProductsRepositoryImplement(this._remoteDataSource);

  @override
  Future<Either<Failure, ProductsListModel>> getProducts() async {
    try {
      final response = await _remoteDataSource.getProducts();
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, ProductModel>> getProductDetails(String productId) async {
    try {
      final response = await _remoteDataSource.getProductDetails(productId);
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, ProductActionModel>> createProduct(FormData formData) async {
    try {
      final response = await _remoteDataSource.createProduct(formData);
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, ProductActionModel>> updateProduct(String productId, FormData formData) async {
    try {
      final response = await _remoteDataSource.updateProduct(productId, formData);
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, ProductActionModel>> deleteProduct(String productId) async {
    try {
      final response = await _remoteDataSource.deleteProduct(productId);
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, ProductActionModel>> activateProduct(String productId) async {
    try {
      final response = await _remoteDataSource.activateProduct(productId);
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, ProductActionModel>> cancelProduct(String productId) async {
    try {
      final response = await _remoteDataSource.cancelProduct(productId);
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, ProductActionModel>> addVariant(String productId, AddVariantRequest req) async {
    try {
      final response = await _remoteDataSource.addVariant(productId, req);
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, ProductActionModel>> updateVariant(String productId, String variantId, AddVariantRequest req) async {
    try {
      final response = await _remoteDataSource.updateVariant(productId, variantId, req);
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, ProductActionModel>> deleteVariant(String productId, String variantId) async {
    try {
      final response = await _remoteDataSource.deleteVariant(productId, variantId);
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, ProductActionModel>> deleteProductImage(String productId, String imageId) async {
    try {
      final response = await _remoteDataSource.deleteProductImage(productId, imageId);
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}

