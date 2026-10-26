import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../../data/repository/products_repository.dart';
import '../model/product_action_model.dart';

/// Use case for updating an existing shop-owner product (multipart FormData).
class UpdateShopOwnerProductUseCase {
  final ProductsRepository _repository;

  UpdateShopOwnerProductUseCase(this._repository);

  Future<Either<Failure, ProductActionModel>> execute(
    String productId,
    FormData formData,
  ) async {
    return await _repository.updateProduct(productId, formData);
  }
}
