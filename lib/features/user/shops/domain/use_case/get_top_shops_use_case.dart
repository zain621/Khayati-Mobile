import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../model/shop_model.dart';
import '../../data/repository/shops_repository.dart';

class GetTopShopsUseCase implements BaseGetUseCase<TopShopsListModel> {
  final ShopsRepository _repository;

  GetTopShopsUseCase(this._repository);

  @override
  Future<Either<Failure, TopShopsListModel>> execute() =>
      _repository.getTopShops();
}
