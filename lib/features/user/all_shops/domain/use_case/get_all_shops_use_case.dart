import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/features/user/shops/domain/model/shop_model.dart';
import 'package:app_mobile/features/user/all_shops/data/repository/all_shops_repository.dart';

class GetAllShopsUseCase {
  final AllShopsRepository _repository;

  GetAllShopsUseCase(this._repository);

  Future<Either<Failure, ShopsListModel>> execute({
    required int page,
    required int perPage,
    String? search,
    String? orderBy,
  }) =>
      _repository.getShops(
        page: page,
        perPage: perPage,
        search: search,
        orderBy: orderBy,
      );
}
