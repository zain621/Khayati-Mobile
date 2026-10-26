import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/comprehensive_home_repository.dart';
import '../model/comprehensive_home_model.dart';

class GetComprehensiveHomeUseCase implements BaseGetUseCase<ComprehensiveHomeModel> {
  final ComprehensiveHomeRepository _repository;

  GetComprehensiveHomeUseCase(this._repository);

  @override
  Future<Either<Failure, ComprehensiveHomeModel>> execute() =>
      _repository.fetchHome();
}
