import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../../data/repository/portfolio_repository.dart';

class DeletePortfolioImageUseCase {
  final PortfolioRepository _repository;

  DeletePortfolioImageUseCase(this._repository);

  Future<Either<Failure, void>> execute(String imageId) async {
    return await _repository.deleteImage(imageId);
  }
}
