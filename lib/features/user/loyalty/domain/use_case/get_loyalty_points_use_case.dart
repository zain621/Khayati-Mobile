import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/loyalty_repository.dart';
import '../model/loyalty_points_model.dart';

class GetLoyaltyPointsUseCase implements BaseGetUseCase<LoyaltyPointsModel> {
  final LoyaltyRepository _repository;

  GetLoyaltyPointsUseCase(this._repository);

  @override
  Future<Either<Failure, LoyaltyPointsModel>> execute() =>
      _repository.getLoyaltyPoints();
}
