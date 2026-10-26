// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfilePortfolioImageResponse _$ProfilePortfolioImageResponseFromJson(
        Map<String, dynamic> json) =>
    ProfilePortfolioImageResponse(
      id: json['id'] as String?,
      imageUrl: json['imageUrl'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$ProfilePortfolioImageResponseToJson(
        ProfilePortfolioImageResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'sortOrder': instance.sortOrder,
      'createdAt': instance.createdAt,
    };

ProfileSpecializationResponse _$ProfileSpecializationResponseFromJson(
        Map<String, dynamic> json) =>
    ProfileSpecializationResponse(
      id: json['id'] as String?,
      name: json['name'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$ProfileSpecializationResponseToJson(
        ProfileSpecializationResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt,
    };

ProfilePortfolioResponse _$ProfilePortfolioResponseFromJson(
        Map<String, dynamic> json) =>
    ProfilePortfolioResponse(
      id: json['id'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) =>
              ProfilePortfolioImageResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      specializations: (json['specializations'] as List<dynamic>?)
          ?.map((e) =>
              ProfileSpecializationResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProfilePortfolioResponseToJson(
        ProfilePortfolioResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'images': instance.images,
      'specializations': instance.specializations,
    };

ProviderProfileDataResponse _$ProviderProfileDataResponseFromJson(
        Map<String, dynamic> json) =>
    ProviderProfileDataResponse(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      image: json['image'] as String?,
      bio: json['bio'] as String?,
      role: json['role'] as String?,
      isAvailable: json['isAvailable'] as bool?,
      rank: json['rank'] as String?,
      rankLabel: json['rankLabel'] as String?,
      portfolio: json['portfolio'] == null
          ? null
          : ProfilePortfolioResponse.fromJson(
              json['portfolio'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProviderProfileDataResponseToJson(
        ProviderProfileDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'image': instance.image,
      'bio': instance.bio,
      'role': instance.role,
      'isAvailable': instance.isAvailable,
      'rank': instance.rank,
      'rankLabel': instance.rankLabel,
      'portfolio': instance.portfolio,
    };

ProviderProfileResponse _$ProviderProfileResponseFromJson(
        Map<String, dynamic> json) =>
    ProviderProfileResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : ProviderProfileDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProviderProfileResponseToJson(
        ProviderProfileResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
