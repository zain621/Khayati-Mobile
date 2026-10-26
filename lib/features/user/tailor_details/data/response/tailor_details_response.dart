import 'package:json_annotation/json_annotation.dart';
import '../../../../../constants/response_constants/response_constants.dart';

part 'tailor_details_response.g.dart';

// ─── Root wrapper ─────────────────────────────────────────────────────────────

@JsonSerializable()
class TailorDetailsResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.data)
  final TailorDetailsDataResponse? data;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  const TailorDetailsResponse({
    this.status,
    this.code,
    this.data,
    this.message,
  });

  factory TailorDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$TailorDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TailorDetailsResponseToJson(this);
}

// ─── Data ─────────────────────────────────────────────────────────────────────

@JsonSerializable()
class TailorDetailsDataResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.fullName)
  final String? fullName;

  @JsonKey(name: ResponseConstants.image)
  final String? image;

  @JsonKey(name: ResponseConstants.bio)
  final String? bio;

  @JsonKey(name: ResponseConstants.role)
  final String? role;

  @JsonKey(name: ResponseConstants.isAvailable)
  final bool? isAvailable;

  @JsonKey(name: ResponseConstants.rank)
  final String? rank;

  @JsonKey(name: ResponseConstants.rankLabel)
  final String? rankLabel;

  @JsonKey(name: ResponseConstants.rating)
  final dynamic rating;

  @JsonKey(name: ResponseConstants.ratersCount)
  final int? ratersCount;

  @JsonKey(name: ResponseConstants.offersCount)
  final int? offersCount;

  @JsonKey(name: ResponseConstants.completedOrdersCount)
  final int? completedOrdersCount;

  @JsonKey(name: ResponseConstants.portfolio)
  final TailorPortfolioResponse? portfolio;

  /// API returns `{ latitude, longitude }` (or a string). Never crash-parse.
  @JsonKey(name: ResponseConstants.address, fromJson: _addressFromJson)
  final String? address;

  const TailorDetailsDataResponse({
    this.id,
    this.fullName,
    this.image,
    this.bio,
    this.role,
    this.isAvailable,
    this.rank,
    this.rankLabel,
    this.rating,
    this.ratersCount,
    this.offersCount,
    this.completedOrdersCount,
    this.portfolio,
    this.address,
  });

  factory TailorDetailsDataResponse.fromJson(Map<String, dynamic> json) =>
      _$TailorDetailsDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TailorDetailsDataResponseToJson(this);
}

String? _addressFromJson(Object? value) {
  if (value == null) return null;
  if (value is String) return value;
  if (value is Map) {
    final detailed = value['detailedAddress'] ?? value['address'];
    if (detailed is String && detailed.trim().isNotEmpty) {
      return detailed.trim();
    }
    final lat = value['latitude'];
    final lng = value['longitude'];
    if (lat != null && lng != null) {
      return '$lat, $lng';
    }
  }
  return null;
}

// ─── Portfolio ────────────────────────────────────────────────────────────────

@JsonSerializable()
class TailorPortfolioResponse {
  @JsonKey(name: ResponseConstants.images)
  final List<TailorPortfolioImageResponse>? images;

  @JsonKey(name: ResponseConstants.specializations)
  final List<String>? specializations;

  const TailorPortfolioResponse({
    this.images,
    this.specializations,
  });

  factory TailorPortfolioResponse.fromJson(Map<String, dynamic> json) =>
      _$TailorPortfolioResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TailorPortfolioResponseToJson(this);
}

// ─── Portfolio Image ──────────────────────────────────────────────────────────

@JsonSerializable()
class TailorPortfolioImageResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.imageUrl)
  final String? imageUrl;

  @JsonKey(name: ResponseConstants.sortOrder)
  final int? sortOrder;

  const TailorPortfolioImageResponse({
    this.id,
    this.imageUrl,
    this.sortOrder,
  });

  factory TailorPortfolioImageResponse.fromJson(Map<String, dynamic> json) =>
      _$TailorPortfolioImageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TailorPortfolioImageResponseToJson(this);
}
