import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/shop_owner_home_repository.dart';

class ChangeShopOwnerAvailabilityUseCase implements BaseUseCase<bool, bool> {
  final ShopOwnerHomeRepository _repository;

  ChangeShopOwnerAvailabilityUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> execute(bool request) =>
      _repository.changeAvailability(request);
}
