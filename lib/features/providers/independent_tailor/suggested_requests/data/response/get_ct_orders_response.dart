import 'package:json_annotation/json_annotation.dart';
import '../../../../../../constants/response_constants/response_constants.dart';
import 'get_orders_response.dart';

part 'get_ct_orders_response.g.dart';

/// Nested data object for the comprehensive-tailor orders endpoint.
/// The API returns: { "shopOrders": [...], "zoqakOrders": [...] }
@JsonSerializable()
class GetCTOrdersDataResponse {
  @JsonKey(name: ResponseConstants.zoqakOrders)
  List<OrderDataResponse>? zoqakOrders;

  @JsonKey(name: ResponseConstants.shopOrders)
  List<OrderDataResponse>? shopOrders;

  GetCTOrdersDataResponse({this.zoqakOrders, this.shopOrders});

  factory GetCTOrdersDataResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCTOrdersDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetCTOrdersDataResponseToJson(this);
}

/// Top-level response wrapper for the comprehensive-tailor orders endpoint.
@JsonSerializable()
class GetCTOrdersResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;

  @JsonKey(name: ResponseConstants.code)
  int? code;

  @JsonKey(name: ResponseConstants.message)
  String? message;

  @JsonKey(name: ResponseConstants.data)
  GetCTOrdersDataResponse? data;

  GetCTOrdersResponse({this.status, this.code, this.message, this.data});

  factory GetCTOrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCTOrdersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetCTOrdersResponseToJson(this);
}
