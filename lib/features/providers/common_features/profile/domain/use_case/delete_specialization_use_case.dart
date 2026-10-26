import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../../data/repository/portfolio_repository.dart';

class DeleteSpecializationUseCase {
  final PortfolioRepository _repository;

  DeleteSpecializationUseCase(this._repository);

  Future<Either<Failure, void>> execute(String specializationId) async {
    return await _repository.deleteSpecialization(specializationId);
  }
}
