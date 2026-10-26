import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../../data/repository/products_repository.dart';
import '../../data/request/add_variant_request.dart';
import '../model/product_action_model.dart';

/// Use case for updating an existing product variant.
class UpdateVariantUseCase {
  final ProductsRepository _repository;

  UpdateVariantUseCase(this._repository);

  Future<Either<Failure, ProductActionModel>> execute(
    String productId,
    String variantId,
    AddVariantRequest request,
  ) async {
    return await _repository.updateVariant(productId, variantId, request);
  }
}
