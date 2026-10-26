// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_shop_owner_orders_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopOrderBuyerResponse _$ShopOrderBuyerResponseFromJson(
        Map<String, dynamic> json) =>
    ShopOrderBuyerResponse(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$ShopOrderBuyerResponseToJson(
        ShopOrderBuyerResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'image': instance.image,
    };

ShopOrderItemResponse _$ShopOrderItemResponseFromJson(
        Map<String, dynamic> json) =>
    ShopOrderItemResponse(
      id: json['id'] as String?,
      productId: json['productId'] as String?,
      variantId: json['variantId'] as String?,
      productName: json['productName'] as String?,
      color: json['color'] as String?,
      size: json['size'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      unitPrice: json['unitPrice'] as num?,
      totalPrice: json['totalPrice'] as num?,
    );

Map<String, dynamic> _$ShopOrderItemResponseToJson(
        ShopOrderItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'variantId': instance.variantId,
      'productName': instance.productName,
      'color': instance.color,
      'size': instance.size,
      'quantity': instance.quantity,
      'unitPrice': instance.unitPrice,
      'totalPrice': instance.totalPrice,
    };

ShopOrderStageResponse _$ShopOrderStageResponseFromJson(
        Map<String, dynamic> json) =>
    ShopOrderStageResponse(
      key: json['key'] as String?,
      label: json['label'] as String?,
      completed: json['completed'] as bool?,
      statusDate: json['statusDate'] as String?,
    );

Map<String, dynamic> _$ShopOrderStageResponseToJson(
        ShopOrderStageResponse instance) =>
    <String, dynamic>{
      'key': instance.key,
      'label': instance.label,
      'completed': instance.completed,
      'statusDate': instance.statusDate,
    };

ShopOrderStagesSummaryResponse _$ShopOrderStagesSummaryResponseFromJson(
        Map<String, dynamic> json) =>
    ShopOrderStagesSummaryResponse(
      totalStages: (json['totalStages'] as num?)?.toInt(),
      completedStagesCount: (json['completedStagesCount'] as num?)?.toInt(),
      incompleteStagesCount: (json['incompleteStagesCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ShopOrderStagesSummaryResponseToJson(
        ShopOrderStagesSummaryResponse instance) =>
    <String, dynamic>{
      'totalStages': instance.totalStages,
      'completedStagesCount': instance.completedStagesCount,
      'incompleteStagesCount': instance.incompleteStagesCount,
    };

ShopOrderDataResponse _$ShopOrderDataResponseFromJson(
        Map<String, dynamic> json) =>
    ShopOrderDataResponse(
      id: json['id'] as String?,
      orderNumber: json['orderNumber'] as String?,
      buyerId: json['buyerId'] as String?,
      status: json['status'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
      totalAmount: json['totalAmount'] as num?,
      itemsCount: (json['itemsCount'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      buyer: json['buyer'] == null
          ? null
          : ShopOrderBuyerResponse.fromJson(
              json['buyer'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map(
              (e) => ShopOrderItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      stages: (json['stages'] as List<dynamic>?)
          ?.map(
              (e) => ShopOrderStageResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      stagesSummary: json['stagesSummary'] == null
          ? null
          : ShopOrderStagesSummaryResponse.fromJson(
              json['stagesSummary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShopOrderDataResponseToJson(
        ShopOrderDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderNumber': instance.orderNumber,
      'buyerId': instance.buyerId,
      'status': instance.status,
      'paymentStatus': instance.paymentStatus,
      'totalAmount': instance.totalAmount,
      'itemsCount': instance.itemsCount,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'buyer': instance.buyer,
      'items': instance.items,
      'stages': instance.stages,
      'stagesSummary': instance.stagesSummary,
    };

GetShopOwnerOrdersResponse _$GetShopOwnerOrdersResponseFromJson(
        Map<String, dynamic> json) =>
    GetShopOwnerOrdersResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => ShopOrderDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$GetShopOwnerOrdersResponseToJson(
        GetShopOwnerOrdersResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };
