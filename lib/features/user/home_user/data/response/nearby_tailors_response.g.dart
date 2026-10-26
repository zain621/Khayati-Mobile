// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearby_tailors_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NearbyTailorsResponse _$NearbyTailorsResponseFromJson(
        Map<String, dynamic> json) =>
    NearbyTailorsResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : NearbyTailorsDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$NearbyTailorsResponseToJson(
        NearbyTailorsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };

NearbyTailorsDataResponse _$NearbyTailorsDataResponseFromJson(
        Map<String, dynamic> json) =>
    NearbyTailorsDataResponse(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) =>
              NearbyTailorItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      radiusKm: json['radiusKm'],
    );

Map<String, dynamic> _$NearbyTailorsDataResponseToJson(
        NearbyTailorsDataResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
      'radiusKm': instance.radiusKm,
    };

NearbyTailorItemResponse _$NearbyTailorItemResponseFromJson(
        Map<String, dynamic> json) =>
    NearbyTailorItemResponse(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      image: json['image'] as String?,
      role: json['role'] as String?,
      isAvailable: json['isAvailable'] as bool?,
      rank: json['rank'] as String?,
      rankLabel: json['rankLabel'] as String?,
      rating: json['rating'],
      ratersCount: (json['ratersCount'] as num?)?.toInt(),
      offersCount: (json['offersCount'] as num?)?.toInt(),
      completedOrdersCount: (json['completedOrdersCount'] as num?)?.toInt(),
      address: json['address'] == null
          ? null
          : NearbyTailorAddressResponse.fromJson(
              json['address'] as Map<String, dynamic>),
      distanceKm: json['distanceKm'],
    );

Map<String, dynamic> _$NearbyTailorItemResponseToJson(
        NearbyTailorItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'image': instance.image,
      'role': instance.role,
      'isAvailable': instance.isAvailable,
      'rank': instance.rank,
      'rankLabel': instance.rankLabel,
      'rating': instance.rating,
      'ratersCount': instance.ratersCount,
      'offersCount': instance.offersCount,
      'completedOrdersCount': instance.completedOrdersCount,
      'address': instance.address,
      'distanceKm': instance.distanceKm,
    };

NearbyTailorAddressResponse _$NearbyTailorAddressResponseFromJson(
        Map<String, dynamic> json) =>
    NearbyTailorAddressResponse(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );

Map<String, dynamic> _$NearbyTailorAddressResponseToJson(
        NearbyTailorAddressResponse instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
