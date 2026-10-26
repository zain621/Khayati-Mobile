import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../../data/repository/products_repository.dart';
import '../model/product_action_model.dart';

/// Use case for deleting a variant from a product.
class DeleteVariantUseCase {
  final ProductsRepository _repository;

  DeleteVariantUseCase(this._repository);

  Future<Either<Failure, ProductActionModel>> execute(
    String productId,
    String variantId,
  ) async {
    return await _repository.deleteVariant(productId, variantId);
  }
}
