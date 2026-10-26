import 'package:json_annotation/json_annotation.dart';
import '../../../../../constants/response_constants/response_constants.dart';

part 'loyalty_rewards_response.g.dart';

@JsonSerializable()
class LoyaltyRewardsResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.data)
  final List<LoyaltyRewardItemResponse>? data;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  const LoyaltyRewardsResponse({
    this.status,
    this.code,
    this.data,
    this.message,
  });

  factory LoyaltyRewardsResponse.fromJson(Map<String, dynamic> json) =>
      _$LoyaltyRewardsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoyaltyRewardsResponseToJson(this);
}

@JsonSerializable()
class LoyaltyRewardItemResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.titleAr)
  final String? titleAr;

  @JsonKey(name: ResponseConstants.titleEn)
  final String? titleEn;

  @JsonKey(name: ResponseConstants.titleUr)
  final String? titleUr;

  @JsonKey(name: ResponseConstants.pointsRequired)
  final int? pointsRequired;

  @JsonKey(name: ResponseConstants.discountType)
  final String? discountType;

  @JsonKey(name: ResponseConstants.discountValue)
  final double? discountValue;

  @JsonKey(name: ResponseConstants.isAvailable)
  final bool? isActive;

  @JsonKey(name: ResponseConstants.createdAt)
  final String? createdAt;

  @JsonKey(name: ResponseConstants.updatedAt)
  final String? updatedAt;

  const LoyaltyRewardItemResponse({
    this.id,
    this.titleAr,
    this.titleEn,
    this.titleUr,
    this.pointsRequired,
    this.discountType,
    this.discountValue,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory LoyaltyRewardItemResponse.fromJson(Map<String, dynamic> json) =>
      _$LoyaltyRewardItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoyaltyRewardItemResponseToJson(this);
}
