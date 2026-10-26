import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/loyalty_repository.dart';
import '../model/loyalty_reward_model.dart';

class GetLoyaltyRewardsUseCase
    implements BaseGetUseCase<List<LoyaltyRewardModel>> {
  final LoyaltyRepository _repository;

  GetLoyaltyRewardsUseCase(this._repository);

  @override
  Future<Either<Failure, List<LoyaltyRewardModel>>> execute() =>
      _repository.getLoyaltyRewards();
}
