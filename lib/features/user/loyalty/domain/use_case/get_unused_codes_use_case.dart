import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/loyalty_repository.dart';
import '../model/unused_loyalty_code_model.dart';

class GetUnusedCodesUseCase
    implements BaseGetUseCase<List<UnusedLoyaltyCodeModel>> {
  final LoyaltyRepository _repository;

  GetUnusedCodesUseCase(this._repository);

  @override
  Future<Either<Failure, List<UnusedLoyaltyCodeModel>>> execute() =>
      _repository.getUnusedCodes();
}
