import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../repository/search_repository.dart';

class DeleteSearchHistoryItemUseCase implements BaseUseCase<String, Unit> {
  final SearchRepository _repository;

  DeleteSearchHistoryItemUseCase(this._repository);

  @override
  Future<Either<Failure, Unit>> execute(String historyId) {
    return _repository.deleteSearchHistoryItem(historyId);
  }
}
