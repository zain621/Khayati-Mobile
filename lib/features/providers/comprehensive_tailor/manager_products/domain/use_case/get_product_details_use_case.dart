import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';
import '../../data/repository/products_repository.dart';
import '../model/product_model.dart';

/// Use case for fetching a single product's full details.
class GetProductDetailsUseCase implements BaseUseCase<String, ProductModel> {
  final ProductsRepository _repository;

  GetProductDetailsUseCase(this._repository);

  @override
  Future<Either<Failure, ProductModel>> execute(String productId) async {
    return await _repository.getProductDetails(productId);
  }
}
