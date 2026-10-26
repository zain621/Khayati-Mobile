import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/comprehensive_home_repository.dart';

class ChangeAvailabilityUseCase implements BaseUseCase<bool, bool> {
  final ComprehensiveHomeRepository _repository;

  ChangeAvailabilityUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> execute(bool request) =>
      _repository.changeAvailability(request);
}
