import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/products_repository.dart';
import '../model/product_action_model.dart';

/// Use case for deleting a product.
class DeleteProductUseCase implements BaseUseCase<String, ProductActionModel> {
  final ProductsRepository _repository;

  DeleteProductUseCase(this._repository);

  @override
  Future<Either<Failure, ProductActionModel>> execute(String productId) async {
    return await _repository.deleteProduct(productId);
  }
}
