import 'package:json_annotation/json_annotation.dart';
import '../../../../../constants/response_constants/response_constants.dart';

part 'search_history_response.g.dart';

@JsonSerializable()
class SearchHistoryListResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  @JsonKey(name: ResponseConstants.data)
  final List<SearchHistoryItemResponse>? data;

  const SearchHistoryListResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory SearchHistoryListResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchHistoryListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchHistoryListResponseToJson(this);
}

@JsonSerializable()
class SearchHistoryItemResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.searchQuery)
  final String? query;

  @JsonKey(name: ResponseConstants.createdAt)
  final String? createdAt;

  @JsonKey(name: ResponseConstants.updatedAt)
  final String? updatedAt;

  const SearchHistoryItemResponse({
    this.id,
    this.query,
    this.createdAt,
    this.updatedAt,
  });

  factory SearchHistoryItemResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchHistoryItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchHistoryItemResponseToJson(this);
}
