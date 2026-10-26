// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tailor_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TailorDetailsResponse _$TailorDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    TailorDetailsResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : TailorDetailsDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$TailorDetailsResponseToJson(
        TailorDetailsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };

TailorDetailsDataResponse _$TailorDetailsDataResponseFromJson(
        Map<String, dynamic> json) =>
    TailorDetailsDataResponse(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      image: json['image'] as String?,
      bio: json['bio'] as String?,
      role: json['role'] as String?,
      isAvailable: json['isAvailable'] as bool?,
      rank: json['rank'] as String?,
      rankLabel: json['rankLabel'] as String?,
      rating: json['rating'],
      ratersCount: (json['ratersCount'] as num?)?.toInt(),
      offersCount: (json['offersCount'] as num?)?.toInt(),
      completedOrdersCount: (json['completedOrdersCount'] as num?)?.toInt(),
      portfolio: json['portfolio'] == null
          ? null
          : TailorPortfolioResponse.fromJson(
              json['portfolio'] as Map<String, dynamic>),
      address: _addressFromJson(json['address']),
    );

Map<String, dynamic> _$TailorDetailsDataResponseToJson(
        TailorDetailsDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'image': instance.image,
      'bio': instance.bio,
      'role': instance.role,
      'isAvailable': instance.isAvailable,
      'rank': instance.rank,
      'rankLabel': instance.rankLabel,
      'rating': instance.rating,
      'ratersCount': instance.ratersCount,
      'offersCount': instance.offersCount,
      'completedOrdersCount': instance.completedOrdersCount,
      'portfolio': instance.portfolio,
      'address': instance.address,
    };

TailorPortfolioResponse _$TailorPortfolioResponseFromJson(
        Map<String, dynamic> json) =>
    TailorPortfolioResponse(
      images: (json['images'] as List<dynamic>?)
          ?.map((e) =>
              TailorPortfolioImageResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      specializations: (json['specializations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$TailorPortfolioResponseToJson(
        TailorPortfolioResponse instance) =>
    <String, dynamic>{
      'images': instance.images,
      'specializations': instance.specializations,
    };

TailorPortfolioImageResponse _$TailorPortfolioImageResponseFromJson(
        Map<String, dynamic> json) =>
    TailorPortfolioImageResponse(
      id: json['id'] as String?,
      imageUrl: json['imageUrl'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TailorPortfolioImageResponseToJson(
        TailorPortfolioImageResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'sortOrder': instance.sortOrder,
    };
