import 'package:json_annotation/json_annotation.dart';
import '../../../../../../constants/response_constants/response_constants.dart';

part 'provider_profile_response.g.dart';

// ── Portfolio image item (embedded in profile) ─────────────────────────────

@JsonSerializable()
class ProfilePortfolioImageResponse {
  @JsonKey(name: ResponseConstants.entityId)
  String? id;

  @JsonKey(name: ResponseConstants.imageUrl)
  String? imageUrl;

  @JsonKey(name: ResponseConstants.sortOrder)
  int? sortOrder;

  @JsonKey(name: ResponseConstants.createdAt)
  String? createdAt;

  ProfilePortfolioImageResponse({this.id, this.imageUrl, this.sortOrder, this.createdAt});

  factory ProfilePortfolioImageResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfilePortfolioImageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfilePortfolioImageResponseToJson(this);
}

// ── Specialization item (embedded in profile) ──────────────────────────────

@JsonSerializable()
class ProfileSpecializationResponse {
  @JsonKey(name: ResponseConstants.entityId)
  String? id;

  @JsonKey(name: ResponseConstants.name)
  String? name;

  @JsonKey(name: ResponseConstants.createdAt)
  String? createdAt;

  ProfileSpecializationResponse({this.id, this.name, this.createdAt});

  factory ProfileSpecializationResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileSpecializationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileSpecializationResponseToJson(this);
}

// ── Portfolio wrapper (embedded in profile) ────────────────────────────────

@JsonSerializable()
class ProfilePortfolioResponse {
  @JsonKey(name: ResponseConstants.entityId)
  String? id;

  @JsonKey(name: ResponseConstants.images)
  List<ProfilePortfolioImageResponse>? images;

  @JsonKey(name: ResponseConstants.specializations)
  List<ProfileSpecializationResponse>? specializations;

  ProfilePortfolioResponse({this.id, this.images, this.specializations});

  factory ProfilePortfolioResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfilePortfolioResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfilePortfolioResponseToJson(this);
}

// ── Provider profile data ──────────────────────────────────────────────────

@JsonSerializable()
class ProviderProfileDataResponse {
  @JsonKey(name: ResponseConstants.entityId)
  String? id;

  @JsonKey(name: ResponseConstants.fullName)
  String? fullName;

  @JsonKey(name: ResponseConstants.phoneNumber)
  String? phoneNumber;

  @JsonKey(name: ResponseConstants.image)
  String? image;

  @JsonKey(name: ResponseConstants.bio)
  String? bio;

  @JsonKey(name: ResponseConstants.role)
  String? role;

  @JsonKey(name: ResponseConstants.isAvailable)
  bool? isAvailable;

  @JsonKey(name: ResponseConstants.rank)
  String? rank;

  @JsonKey(name: ResponseConstants.rankLabel)
  String? rankLabel;

  @JsonKey(name: ResponseConstants.portfolio)
  ProfilePortfolioResponse? portfolio;

  ProviderProfileDataResponse({
    this.id,
    this.fullName,
    this.phoneNumber,
    this.image,
    this.bio,
    this.role,
    this.isAvailable,
    this.rank,
    this.rankLabel,
    this.portfolio,
  });

  factory ProviderProfileDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ProviderProfileDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProviderProfileDataResponseToJson(this);
}

// ── Top-level provider profile response ───────────────────────────────────

@JsonSerializable()
class ProviderProfileResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;

  @JsonKey(name: ResponseConstants.code)
  int? code;

  @JsonKey(name: ResponseConstants.message)
  String? message;

  @JsonKey(name: ResponseConstants.data)
  ProviderProfileDataResponse? data;

  ProviderProfileResponse({this.status, this.code, this.message, this.data});

  factory ProviderProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProviderProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProviderProfileResponseToJson(this);
}
