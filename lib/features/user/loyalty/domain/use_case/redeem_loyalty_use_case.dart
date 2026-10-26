import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/loyalty_repository.dart';
import '../../data/request/redeem_loyalty_request.dart';
import '../model/redeem_loyalty_model.dart';

class RedeemLoyaltyUseCase
    implements BaseUseCase<RedeemLoyaltyRequest, RedeemLoyaltyModel> {
  final LoyaltyRepository _repository;

  RedeemLoyaltyUseCase(this._repository);

  @override
  Future<Either<Failure, RedeemLoyaltyModel>> execute(
          RedeemLoyaltyRequest input) =>
      _repository.redeemLoyalty(input);
}
