import 'package:json_annotation/json_annotation.dart';
import '../../../../../constants/response_constants/response_constants.dart';

part 'nearby_tailors_response.g.dart';

@JsonSerializable()
class NearbyTailorsResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.data)
  final NearbyTailorsDataResponse? data;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  const NearbyTailorsResponse({
    this.status,
    this.code,
    this.data,
    this.message,
  });

  factory NearbyTailorsResponse.fromJson(Map<String, dynamic> json) =>
      _$NearbyTailorsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NearbyTailorsResponseToJson(this);
}

@JsonSerializable()
class NearbyTailorsDataResponse {
  @JsonKey(name: ResponseConstants.items)
  final List<NearbyTailorItemResponse>? items;

  @JsonKey(name: ResponseConstants.radiusKm)
  final dynamic radiusKm;

  const NearbyTailorsDataResponse({this.items, this.radiusKm});

  factory NearbyTailorsDataResponse.fromJson(Map<String, dynamic> json) =>
      _$NearbyTailorsDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NearbyTailorsDataResponseToJson(this);
}

@JsonSerializable()
class NearbyTailorItemResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.fullName)
  final String? fullName;

  @JsonKey(name: ResponseConstants.image)
  final String? image;

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

  @JsonKey(name: ResponseConstants.address)
  final NearbyTailorAddressResponse? address;

  @JsonKey(name: ResponseConstants.distanceKm)
  final dynamic distanceKm;

  const NearbyTailorItemResponse({
    this.id,
    this.fullName,
    this.image,
    this.role,
    this.isAvailable,
    this.rank,
    this.rankLabel,
    this.rating,
    this.ratersCount,
    this.offersCount,
    this.completedOrdersCount,
    this.address,
    this.distanceKm,
  });

  factory NearbyTailorItemResponse.fromJson(Map<String, dynamic> json) =>
      _$NearbyTailorItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NearbyTailorItemResponseToJson(this);
}

@JsonSerializable()
class NearbyTailorAddressResponse {
  @JsonKey(name: ResponseConstants.latitude)
  final dynamic latitude;

  @JsonKey(name: ResponseConstants.longitude)
  final dynamic longitude;

  const NearbyTailorAddressResponse({this.latitude, this.longitude});

  factory NearbyTailorAddressResponse.fromJson(Map<String, dynamic> json) =>
      _$NearbyTailorAddressResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NearbyTailorAddressResponseToJson(this);
}
