// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_shop_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateShopProfileRequest _$UpdateShopProfileRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateShopProfileRequest(
      nameAr: json['nameAr'] as String,
      nameEn: json['nameEn'] as String,
      bio: json['bio'] as String?,
    );

Map<String, dynamic> _$UpdateShopProfileRequestToJson(
        UpdateShopProfileRequest instance) =>
    <String, dynamic>{
      'nameAr': instance.nameAr,
      'nameEn': instance.nameEn,
      'bio': instance.bio,
    };
