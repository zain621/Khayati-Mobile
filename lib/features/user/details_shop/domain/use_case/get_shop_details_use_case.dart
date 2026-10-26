import 'package:dartz/dartz.dart';
import '../../../../../core/error_handler/failure.dart';
import '../../../../../core/usecase/base_usecase.dart';
import '../../data/repository/shop_details_repository.dart';
import '../model/shop_details_model.dart';

class GetShopDetailsUseCase implements BaseUseCase<String, ShopDetailsModel> {
  final ShopDetailsRepository _repository;

  GetShopDetailsUseCase(this._repository);

  @override
  Future<Either<Failure, ShopDetailsModel>> execute(String shopId) =>
      _repository.getShopDetails(shopId);
}
