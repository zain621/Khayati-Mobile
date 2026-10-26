import 'package:json_annotation/json_annotation.dart';
import '../../../../../../constants/response_constants/response_constants.dart';

part 'product_action_response.g.dart';

/// Generic response for product actions (delete, activate, cancel).
@JsonSerializable()
class ProductActionResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;
  @JsonKey(name: ResponseConstants.code)
  int? code;
  @JsonKey(name: ResponseConstants.message)
  String? message;

  ProductActionResponse({
    this.status,
    this.code,
    this.message,
  });

  factory ProductActionResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductActionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductActionResponseToJson(this);
}
