import 'package:dartz/dartz.dart';
import '../../../../../core/error_handler/data_source_extension.dart';
import '../../../../../core/error_handler/error_handler.dart';
import '../../../../../core/error_handler/failure.dart';
import '../../../../../core/error_handler/type_handler_enum.dart';
import '../../../../../core/internet_checker/interent_checker.dart';
import '../data_source/search_data_source.dart';
import '../mapper/search_mapper.dart';
import '../../domain/model/search_model.dart';
import '../../domain/model/search_history_model.dart';
import '../../domain/repository/search_repository.dart';

class SearchRepositoryImplement implements SearchRepository {
  final SearchDataSource _dataSource;
  final NetworkInfo _networkInfo;

  SearchRepositoryImplement(this._dataSource, this._networkInfo);

  @override
  Future<Either<Failure, SearchModel>> search({
    required String query,
    required String type,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final data = await _dataSource.search(query: query, type: type);
        return Right(data.toDomain());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(TypeHandlerEnum.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<SearchHistoryModel>>> getSearchHistory() async {
    if (await _networkInfo.isConnected) {
      try {
        final items = await _dataSource.getSearchHistory();
        return Right(items.map((e) => e.toDomain()).toList());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(TypeHandlerEnum.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteSearchHistoryItem(
      String historyId) async {
    if (await _networkInfo.isConnected) {
      try {
        await _dataSource.deleteSearchHistoryItem(historyId);
        return const Right(unit);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(TypeHandlerEnum.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> clearSearchHistory() async {
    if (await _networkInfo.isConnected) {
      try {
        await _dataSource.clearSearchHistory();
        return const Right(unit);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(TypeHandlerEnum.noInternetConnection.getFailure());
    }
  }
}
