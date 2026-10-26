import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../../data/repository/all_products_repository.dart';
import '../model/product_list_item_model.dart';

class GetAllProductsUseCase {
  final AllProductsRepository _repository;

  GetAllProductsUseCase(this._repository);

  Future<Either<Failure, ProductsListModel>> execute({
    required int page,
    required int perPage,
    String? shopSearch,
  }) =>
      _repository.getProducts(
        page: page,
        perPage: perPage,
        shopSearch: shopSearch,
      );
}
