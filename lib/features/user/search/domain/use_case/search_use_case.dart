import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../model/search_model.dart';
import '../repository/search_repository.dart';

class SearchParams {
  final String query;
  final String type;

  const SearchParams({required this.query, required this.type});
}

class SearchUseCase implements BaseUseCase<SearchParams, SearchModel> {
  final SearchRepository _repository;

  SearchUseCase(this._repository);

  @override
  Future<Either<Failure, SearchModel>> execute(SearchParams request) {
    return _repository.search(query: request.query, type: request.type);
  }
}
