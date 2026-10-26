import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/independent_tailor_home_repository.dart';
import '../model/independent_tailor_home_model.dart';

class GetIndependentTailorHomeUseCase
    implements BaseGetUseCase<IndependentTailorHomeModel> {
  final IndependentTailorHomeRepository _repository;

  GetIndependentTailorHomeUseCase(this._repository);

  @override
  Future<Either<Failure, IndependentTailorHomeModel>> execute() =>
      _repository.fetchHome();
}
