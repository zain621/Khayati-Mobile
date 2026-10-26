import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/products_repository.dart';
import '../model/product_action_model.dart';

/// Use case for activating a product.
class ActivateProductUseCase implements BaseUseCase<String, ProductActionModel> {
  final ProductsRepository _repository;

  ActivateProductUseCase(this._repository);

  @override
  Future<Either<Failure, ProductActionModel>> execute(String productId) async {
    return await _repository.activateProduct(productId);
  }
}
