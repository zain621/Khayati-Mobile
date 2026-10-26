import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';
import '../../data/repository/products_repository.dart';
import '../model/product_model.dart';

/// Use case for fetching shop owner products.
class GetProductsUseCase implements BaseGetUseCase<ProductsListModel> {
  final ProductsRepository _repository;

  GetProductsUseCase(this._repository);

  @override
  Future<Either<Failure, ProductsListModel>> execute() async {
    return await _repository.getProducts();
  }
}
