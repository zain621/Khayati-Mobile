class SearchHistoryModel {
  final String id;
  final String query;
  final String? createdAt;

  const SearchHistoryModel({
    required this.id,
    required this.query,
    this.createdAt,
  });
}
