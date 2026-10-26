import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../model/search_history_model.dart';
import '../repository/search_repository.dart';

class GetSearchHistoryUseCase
    implements BaseGetUseCase<List<SearchHistoryModel>> {
  final SearchRepository _repository;

  GetSearchHistoryUseCase(this._repository);

  @override
  Future<Either<Failure, List<SearchHistoryModel>>> execute() {
    return _repository.getSearchHistory();
  }
}
