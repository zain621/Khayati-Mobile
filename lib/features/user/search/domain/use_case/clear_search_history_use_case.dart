import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../repository/search_repository.dart';

class ClearSearchHistoryUseCase implements BaseGetUseCase<Unit> {
  final SearchRepository _repository;

  ClearSearchHistoryUseCase(this._repository);

  @override
  Future<Either<Failure, Unit>> execute() {
    return _repository.clearSearchHistory();
  }
}
