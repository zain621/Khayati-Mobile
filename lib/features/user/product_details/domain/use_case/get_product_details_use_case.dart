import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/product_details_repository.dart';
import '../model/product_details_model.dart';

class GetProductDetailsUseCase
    implements BaseUseCase<String, ProductDetailsModel> {
  final ProductDetailsRepository _repository;

  GetProductDetailsUseCase(this._repository);

  @override
  Future<Either<Failure, ProductDetailsModel>> execute(String productId) =>
      _repository.getProductDetails(productId);
}
