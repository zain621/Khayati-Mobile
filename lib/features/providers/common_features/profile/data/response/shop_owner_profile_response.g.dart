// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_owner_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopOwnerProfileDataResponse _$ShopOwnerProfileDataResponseFromJson(
        Map<String, dynamic> json) =>
    ShopOwnerProfileDataResponse(
      id: json['id'] as String?,
      nameAr: json['nameAr'] as String?,
      nameEn: json['nameEn'] as String?,
      imageUrl: json['imageUrl'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
      bio: json['bio'] as String?,
      isAvailable: json['isAvailable'] as bool?,
      rating: (json['rating'] as num?)?.toDouble(),
      ratersCount: (json['ratersCount'] as num?)?.toInt(),
      productsCount: (json['productsCount'] as num?)?.toInt(),
      completedOrdersCount: (json['completedOrdersCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ShopOwnerProfileDataResponseToJson(
        ShopOwnerProfileDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nameAr': instance.nameAr,
      'nameEn': instance.nameEn,
      'imageUrl': instance.imageUrl,
      'coverImageUrl': instance.coverImageUrl,
      'bio': instance.bio,
      'isAvailable': instance.isAvailable,
      'rating': instance.rating,
      'ratersCount': instance.ratersCount,
      'productsCount': instance.productsCount,
      'completedOrdersCount': instance.completedOrdersCount,
    };

ShopOwnerProfileResponse _$ShopOwnerProfileResponseFromJson(
        Map<String, dynamic> json) =>
    ShopOwnerProfileResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : ShopOwnerProfileDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShopOwnerProfileResponseToJson(
        ShopOwnerProfileResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
