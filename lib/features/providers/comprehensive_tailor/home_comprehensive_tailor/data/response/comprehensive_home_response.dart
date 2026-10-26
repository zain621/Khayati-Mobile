import 'package:json_annotation/json_annotation.dart';
import '../../../../../../constants/response_constants/response_constants.dart';

part 'comprehensive_home_response.g.dart';

@JsonSerializable()
class ComprehensiveHomeResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  @JsonKey(name: ResponseConstants.data)
  final ComprehensiveHomeDataResponse? data;

  ComprehensiveHomeResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory ComprehensiveHomeResponse.fromJson(Map<String, dynamic> json) =>
      _$ComprehensiveHomeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ComprehensiveHomeResponseToJson(this);
}

@JsonSerializable()
class ComprehensiveHomeDataResponse {
  @JsonKey(name: ResponseConstants.profile)
  final ComprehensiveHomeProfileResponse? profile;

  @JsonKey(name: ResponseConstants.dashboard)
  final ComprehensiveHomeDashboardResponse? dashboard;

  @JsonKey(name: ResponseConstants.shop)
  final ComprehensiveHomeShopResponse? shop;

  ComprehensiveHomeDataResponse({
    this.profile,
    this.dashboard,
    this.shop,
  });

  factory ComprehensiveHomeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ComprehensiveHomeDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ComprehensiveHomeDataResponseToJson(this);
}

@JsonSerializable()
class ComprehensiveHomeProfileResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.fullName)
  final String? fullName;

  @JsonKey(name: ResponseConstants.email)
  final String? email;

  @JsonKey(name: ResponseConstants.phoneNumber)
  final String? phoneNumber;

  @JsonKey(name: ResponseConstants.image)
  final String? image;

  @JsonKey(name: ResponseConstants.bio)
  final String? bio;

  @JsonKey(name: ResponseConstants.role)
  final String? role;

  @JsonKey(name: ResponseConstants.isAvailable)
  final bool? isAvailable;

  ComprehensiveHomeProfileResponse({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.image,
    this.bio,
    this.role,
    this.isAvailable,
  });

  factory ComprehensiveHomeProfileResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ComprehensiveHomeProfileResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ComprehensiveHomeProfileResponseToJson(this);
}

@JsonSerializable()
class ComprehensiveHomeDashboardResponse {
  @JsonKey(name: ResponseConstants.shopOwnerShopStatus)
  final String? shopStatus;

  @JsonKey(name: ResponseConstants.isAcceptingOrders)
  final bool? isAcceptingOrders;

  @JsonKey(name: ResponseConstants.withdrawableBalance)
  final double? withdrawableBalance;

  @JsonKey(name: ResponseConstants.lastLoginAt)
  final String? lastLoginAt;

  @JsonKey(name: ResponseConstants.averageRating)
  final double? averageRating;

  @JsonKey(name: ResponseConstants.reviewsCount)
  final int? reviewsCount;

  @JsonKey(name: ResponseConstants.rank)
  final String? rank;

  @JsonKey(name: ResponseConstants.rankLabel)
  final String? rankLabel;

  @JsonKey(name: ResponseConstants.isAvailable)
  final bool? isAvailable;

  @JsonKey(name: ResponseConstants.zoqakOrdersCount)
  final int? zoqakOrdersCount;

  ComprehensiveHomeDashboardResponse({
    this.shopStatus,
    this.isAcceptingOrders,
    this.withdrawableBalance,
    this.lastLoginAt,
    this.averageRating,
    this.reviewsCount,
    this.rank,
    this.rankLabel,
    this.isAvailable,
    this.zoqakOrdersCount,
  });

  factory ComprehensiveHomeDashboardResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ComprehensiveHomeDashboardResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ComprehensiveHomeDashboardResponseToJson(this);
}

@JsonSerializable()
class ComprehensiveHomeShopResponse {
  @JsonKey(name: ResponseConstants.shopOwnerShopStatus)
  final String? shopStatus;

  @JsonKey(name: ResponseConstants.isAcceptingOrders)
  final bool? isAcceptingOrders;

  @JsonKey(name: ResponseConstants.withdrawableBalance)
  final double? withdrawableBalance;

  @JsonKey(name: ResponseConstants.lastLoginAt)
  final String? lastLoginAt;

  @JsonKey(name: ResponseConstants.averageRating)
  final double? averageRating;

  @JsonKey(name: ResponseConstants.reviewsCount)
  final int? reviewsCount;

  @JsonKey(name: ResponseConstants.rank)
  final String? rank;

  @JsonKey(name: ResponseConstants.rankLabel)
  final String? rankLabel;

  ComprehensiveHomeShopResponse({
    this.shopStatus,
    this.isAcceptingOrders,
    this.withdrawableBalance,
    this.lastLoginAt,
    this.averageRating,
    this.reviewsCount,
    this.rank,
    this.rankLabel,
  });

  factory ComprehensiveHomeShopResponse.fromJson(Map<String, dynamic> json) =>
      _$ComprehensiveHomeShopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ComprehensiveHomeShopResponseToJson(this);
}

// ── Availability PATCH response ───────────────────────────────────────────────

@JsonSerializable()
class ChangeAvailabilityResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  @JsonKey(name: ResponseConstants.data)
  final ChangeAvailabilityDataResponse? data;

  ChangeAvailabilityResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory ChangeAvailabilityResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangeAvailabilityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeAvailabilityResponseToJson(this);
}

@JsonSerializable()
class ChangeAvailabilityDataResponse {
  @JsonKey(name: ResponseConstants.isAcceptingOrders)
  final bool? isAcceptingOrders;

  ChangeAvailabilityDataResponse({this.isAcceptingOrders});

  factory ChangeAvailabilityDataResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ChangeAvailabilityDataResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ChangeAvailabilityDataResponseToJson(this);
}
