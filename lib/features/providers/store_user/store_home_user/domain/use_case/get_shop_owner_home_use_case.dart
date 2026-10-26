import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/shop_owner_home_repository.dart';
import '../model/shop_owner_home_model.dart';

class GetShopOwnerHomeUseCase implements BaseGetUseCase<ShopOwnerHomeModel> {
  final ShopOwnerHomeRepository _repository;

  GetShopOwnerHomeUseCase(this._repository);

  @override
  Future<Either<Failure, ShopOwnerHomeModel>> execute() =>
      _repository.fetchHome();
}
