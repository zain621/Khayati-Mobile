// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortfolioActionResponse _$PortfolioActionResponseFromJson(
        Map<String, dynamic> json) =>
    PortfolioActionResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$PortfolioActionResponseToJson(
        PortfolioActionResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
    };
