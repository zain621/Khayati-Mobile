import 'package:dartz/dartz.dart';
import '../../../../../core/error_handler/failure.dart';
import '../model/search_model.dart';
import '../model/search_history_model.dart';

abstract class SearchRepository {
  Future<Either<Failure, SearchModel>> search({
    required String query,
    required String type,
  });

  Future<Either<Failure, List<SearchHistoryModel>>> getSearchHistory();

  Future<Either<Failure, Unit>> deleteSearchHistoryItem(String historyId);

  Future<Either<Failure, Unit>> clearSearchHistory();
}
