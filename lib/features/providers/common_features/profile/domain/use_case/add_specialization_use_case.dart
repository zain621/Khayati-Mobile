import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../../data/repository/portfolio_repository.dart';

class AddSpecializationUseCase {
  final PortfolioRepository _repository;

  AddSpecializationUseCase(this._repository);

  Future<Either<Failure, void>> execute(String name) async {
    return await _repository.addSpecialization(name);
  }
}
