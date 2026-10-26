// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_orders_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserOrdersResponse _$UserOrdersResponseFromJson(Map<String, dynamic> json) =>
    UserOrdersResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : UserOrdersDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$UserOrdersResponseToJson(UserOrdersResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };

UserOrdersDataResponse _$UserOrdersDataResponseFromJson(
        Map<String, dynamic> json) =>
    UserOrdersDataResponse(
      orders: (json['orders'] as List<dynamic>?)
          ?.map(
              (e) => UserOrderItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserOrdersDataResponseToJson(
        UserOrdersDataResponse instance) =>
    <String, dynamic>{
      'orders': instance.orders,
      'total': instance.total,
    };

UserOrderItemResponse _$UserOrderItemResponseFromJson(
        Map<String, dynamic> json) =>
    UserOrderItemResponse(
      id: json['id'] as String?,
      orderNumber: json['orderNumber'] as String?,
      orderType: json['orderType'] as String?,
      shopId: json['shopId'] as String?,
      shopName: json['shopName'] as String?,
      status: json['status'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
      totalAmount: json['totalAmount'],
      stages: (json['stages'] as List<dynamic>?)
          ?.map((e) => OrderStageResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      stagesSummary: json['stagesSummary'] == null
          ? null
          : StagesSummaryResponse.fromJson(
              json['stagesSummary'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map(
              (e) => OrderItemLineResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      zoqak: json['zoqak'] == null
          ? null
          : ZoqakDataResponse.fromJson(json['zoqak'] as Map<String, dynamic>),
      acceptedByProviderId: json['acceptedByProviderId'] as String?,
      acceptedByProviderName: json['acceptedByProviderName'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$UserOrderItemResponseToJson(
        UserOrderItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderNumber': instance.orderNumber,
      'orderType': instance.orderType,
      'shopId': instance.shopId,
      'shopName': instance.shopName,
      'status': instance.status,
      'paymentStatus': instance.paymentStatus,
      'totalAmount': instance.totalAmount,
      'stages': instance.stages,
      'stagesSummary': instance.stagesSummary,
      'items': instance.items,
      'zoqak': instance.zoqak,
      'acceptedByProviderId': instance.acceptedByProviderId,
      'acceptedByProviderName': instance.acceptedByProviderName,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

OrderStageResponse _$OrderStageResponseFromJson(Map<String, dynamic> json) =>
    OrderStageResponse(
      key: json['key'] as String?,
      label: json['label'] as String?,
      completed: json['completed'] as bool?,
      statusDate: json['statusDate'] as String?,
    );

Map<String, dynamic> _$OrderStageResponseToJson(OrderStageResponse instance) =>
    <String, dynamic>{
      'key': instance.key,
      'label': instance.label,
      'completed': instance.completed,
      'statusDate': instance.statusDate,
    };

StagesSummaryResponse _$StagesSummaryResponseFromJson(
        Map<String, dynamic> json) =>
    StagesSummaryResponse(
      totalStages: (json['totalStages'] as num?)?.toInt(),
      completedStagesCount: (json['completedStagesCount'] as num?)?.toInt(),
      incompleteStagesCount: (json['incompleteStagesCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StagesSummaryResponseToJson(
        StagesSummaryResponse instance) =>
    <String, dynamic>{
      'totalStages': instance.totalStages,
      'completedStagesCount': instance.completedStagesCount,
      'incompleteStagesCount': instance.incompleteStagesCount,
    };

OrderItemLineResponse _$OrderItemLineResponseFromJson(
        Map<String, dynamic> json) =>
    OrderItemLineResponse(
      id: json['id'] as String?,
      productId: json['productId'] as String?,
      productName: json['productName'] as String?,
      variantId: json['variantId'] as String?,
      color: json['color'] as String?,
      size: json['size'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      unitPrice: json['unitPrice'],
      totalPrice: json['totalPrice'],
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$OrderItemLineResponseToJson(
        OrderItemLineResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'productName': instance.productName,
      'variantId': instance.variantId,
      'color': instance.color,
      'size': instance.size,
      'quantity': instance.quantity,
      'unitPrice': instance.unitPrice,
      'totalPrice': instance.totalPrice,
      'imageUrl': instance.imageUrl,
    };

ZoqakDataResponse _$ZoqakDataResponseFromJson(Map<String, dynamic> json) =>
    ZoqakDataResponse(
      productName: json['productName'] as String?,
      description: json['description'] as String?,
      fabricType: json['fabricType'] as String?,
      minExpectedBudget: json['minExpectedBudget'],
      maxExpectedBudget: json['maxExpectedBudget'],
      deliveryDate: json['deliveryDate'] as String?,
      similarImages: (json['similarImages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      acceptedByProviderId: json['acceptedByProviderId'] as String?,
    );

Map<String, dynamic> _$ZoqakDataResponseToJson(ZoqakDataResponse instance) =>
    <String, dynamic>{
      'productName': instance.productName,
      'description': instance.description,
      'fabricType': instance.fabricType,
      'minExpectedBudget': instance.minExpectedBudget,
      'maxExpectedBudget': instance.maxExpectedBudget,
      'deliveryDate': instance.deliveryDate,
      'similarImages': instance.similarImages,
      'acceptedByProviderId': instance.acceptedByProviderId,
    };
