import 'package:json_annotation/json_annotation.dart';
import '../../../../constants/response_constants/response_constants.dart';

part 'get_categories_response.g.dart';

/// Single category item from the API.
@JsonSerializable()
class CategoryItemResponse {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: ResponseConstants.name)
  String? name;

  @JsonKey(name: ResponseConstants.createdAt)
  String? createdAt;

  @JsonKey(name: ResponseConstants.updatedAt)
  String? updatedAt;

  CategoryItemResponse({this.id, this.name, this.createdAt, this.updatedAt});

  factory CategoryItemResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryItemResponseToJson(this);
}

/// Data wrapper for the paginated categories response.
@JsonSerializable()
class GetCategoriesDataResponse {
  @JsonKey(name: 'items')
  List<CategoryItemResponse>? items;

  @JsonKey(name: 'total')
  int? total;

  @JsonKey(name: 'limit')
  int? limit;

  @JsonKey(name: 'offset')
  int? offset;

  GetCategoriesDataResponse({this.items, this.total, this.limit, this.offset});

  factory GetCategoriesDataResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCategoriesDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetCategoriesDataResponseToJson(this);
}

/// Top-level get categories response wrapper.
@JsonSerializable()
class GetCategoriesResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;

  @JsonKey(name: ResponseConstants.code)
  int? code;

  @JsonKey(name: ResponseConstants.message)
  String? message;

  @JsonKey(name: ResponseConstants.data)
  GetCategoriesDataResponse? data;

  GetCategoriesResponse({this.status, this.code, this.message, this.data});

  factory GetCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetCategoriesResponseToJson(this);
}
