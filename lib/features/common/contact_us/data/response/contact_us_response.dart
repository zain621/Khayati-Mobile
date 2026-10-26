import 'package:json_annotation/json_annotation.dart';
import 'package:app_mobile/constants/response_constants/response_constants.dart';

part 'contact_us_response.g.dart';

@JsonSerializable()
class ContactUsResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;

  @JsonKey(name: ResponseConstants.code)
  int? code;

  @JsonKey(name: ResponseConstants.message)
  String? message;

  @JsonKey(name: ResponseConstants.data)
  ContactUsDataResponse? data;

  ContactUsResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory ContactUsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactUsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContactUsResponseToJson(this);
}

@JsonSerializable()
class ContactUsDataResponse {
  @JsonKey(name: ResponseConstants.entityId)
  String? id;

  ContactUsDataResponse({this.id});

  factory ContactUsDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactUsDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContactUsDataResponseToJson(this);
}
