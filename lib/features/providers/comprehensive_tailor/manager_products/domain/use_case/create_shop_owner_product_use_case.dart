import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../../data/repository/products_repository.dart';
import '../model/product_action_model.dart';

/// Use case for creating a new shop-owner product (multipart FormData).
class CreateShopOwnerProductUseCase {
  final ProductsRepository _repository;

  CreateShopOwnerProductUseCase(this._repository);

  Future<Either<Failure, ProductActionModel>> execute(FormData formData) async {
    return await _repository.createProduct(formData);
  }
}
