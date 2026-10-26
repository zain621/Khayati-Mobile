import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../../data/repository/products_repository.dart';
import '../../data/request/add_variant_request.dart';
import '../model/product_action_model.dart';

/// Use case for adding a new variant to an existing product.
class AddVariantUseCase {
  final ProductsRepository _repository;

  AddVariantUseCase(this._repository);

  Future<Either<Failure, ProductActionModel>> execute(
    String productId,
    AddVariantRequest request,
  ) async {
    return await _repository.addVariant(productId, request);
  }
}
