import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../../data/repository/home_repository.dart';
import '../model/home_model.dart';

class GetNearbyTailorsUseCase {
  final HomeRepository _repository;

  GetNearbyTailorsUseCase(this._repository);

  Future<Either<Failure, NearbyTailorsResultModel>> execute({
    required double latitude,
    required double longitude,
    int limit = 5,
  }) {
    return _repository.getNearbyTailors(
      latitude: latitude,
      longitude: longitude,
      limit: limit,
    );
  }
}
