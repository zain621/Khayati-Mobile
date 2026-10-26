import 'package:app_mobile/core/network/app_api.dart';
import '../response/search_response.dart';
import '../response/search_history_response.dart';

abstract class SearchDataSource {
  Future<SearchDataResponse> search({
    required String query,
    required String type,
  });

  Future<List<SearchHistoryItemResponse>> getSearchHistory();

  Future<void> deleteSearchHistoryItem(String historyId);

  Future<void> clearSearchHistory();
}

class SearchDataSourceImplement implements SearchDataSource {
  final AppService _appService;

  SearchDataSourceImplement(this._appService);

  @override
  Future<SearchDataResponse> search({
    required String query,
    required String type,
  }) async {
    final response = await _appService.search(query, type);
    return response.data!;
  }

  @override
  Future<List<SearchHistoryItemResponse>> getSearchHistory() async {
    final response = await _appService.getSearchHistory();
    return response.data ?? [];
  }

  @override
  Future<void> deleteSearchHistoryItem(String historyId) async {
    await _appService.deleteSearchHistoryItem(historyId);
  }

  @override
  Future<void> clearSearchHistory() async {
    await _appService.clearSearchHistory();
  }
}
