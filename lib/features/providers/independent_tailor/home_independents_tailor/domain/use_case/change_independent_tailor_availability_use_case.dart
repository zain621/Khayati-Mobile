import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/independent_tailor_home_repository.dart';

class ChangeIndependentTailorAvailabilityUseCase
    implements BaseUseCase<bool, bool> {
  final IndependentTailorHomeRepository _repository;

  ChangeIndependentTailorAvailabilityUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> execute(bool request) =>
      _repository.changeAvailability(request);
}
