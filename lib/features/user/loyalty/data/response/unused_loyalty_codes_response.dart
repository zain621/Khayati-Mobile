import 'package:json_annotation/json_annotation.dart';
import '../../../../../constants/response_constants/response_constants.dart';

part 'unused_loyalty_codes_response.g.dart';

@JsonSerializable()
class UnusedLoyaltyCodesResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.data)
  final List<UnusedCodeItemResponse>? data;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  const UnusedLoyaltyCodesResponse({
    this.status,
    this.code,
    this.data,
    this.message,
  });

  factory UnusedLoyaltyCodesResponse.fromJson(Map<String, dynamic> json) =>
      _$UnusedLoyaltyCodesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UnusedLoyaltyCodesResponseToJson(this);
}

@JsonSerializable()
class UnusedCodeItemResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.code)
  final String? code;

  @JsonKey(name: ResponseConstants.rewardId)
  final String? rewardId;

  @JsonKey(name: ResponseConstants.rewardTitleAr)
  final String? rewardTitleAr;

  @JsonKey(name: ResponseConstants.rewardTitleEn)
  final String? rewardTitleEn;

  @JsonKey(name: ResponseConstants.rewardTitleUr)
  final String? rewardTitleUr;

  @JsonKey(name: ResponseConstants.discountType)
  final String? discountType;

  @JsonKey(name: ResponseConstants.discountValue)
  final double? discountValue;

  @JsonKey(name: ResponseConstants.createdAt)
  final String? createdAt;

  const UnusedCodeItemResponse({
    this.id,
    this.code,
    this.rewardId,
    this.rewardTitleAr,
    this.rewardTitleEn,
    this.rewardTitleUr,
    this.discountType,
    this.discountValue,
    this.createdAt,
  });

  factory UnusedCodeItemResponse.fromJson(Map<String, dynamic> json) =>
      _$UnusedCodeItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UnusedCodeItemResponseToJson(this);
}
