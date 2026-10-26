import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../model/home_model.dart';
import '../../data/repository/home_repository.dart';

class GetHomeUseCase implements BaseGetUseCase<HomeModel> {
  final HomeRepository _repository;

  GetHomeUseCase(this._repository);

  @override
  Future<Either<Failure, HomeModel>> execute() => _repository.getHome();
}
