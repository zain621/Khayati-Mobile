// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comprehensive_orders_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComprehensiveOrdersResponse _$ComprehensiveOrdersResponseFromJson(
        Map<String, dynamic> json) =>
    ComprehensiveOrdersResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : ComprehensiveOrdersDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ComprehensiveOrdersResponseToJson(
        ComprehensiveOrdersResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

ComprehensiveOrdersDataResponse _$ComprehensiveOrdersDataResponseFromJson(
        Map<String, dynamic> json) =>
    ComprehensiveOrdersDataResponse(
      shopOrders: (json['shopOrders'] as List<dynamic>?)
          ?.map((e) => ComprehensiveShopOrderResponse.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      zoqakOrders: (json['zoqakOrders'] as List<dynamic>?)
          ?.map((e) => ComprehensiveZoqakOrderResponse.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ComprehensiveOrdersDataResponseToJson(
        ComprehensiveOrdersDataResponse instance) =>
    <String, dynamic>{
      'shopOrders': instance.shopOrders,
      'zoqakOrders': instance.zoqakOrders,
    };

ComprehensiveShopOrderResponse _$ComprehensiveShopOrderResponseFromJson(
        Map<String, dynamic> json) =>
    ComprehensiveShopOrderResponse(
      id: json['id'] as String?,
      orderNumber: json['orderNumber'] as String?,
      status: json['status'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
      totalAmount: json['totalAmount'] as num?,
      itemsCount: (json['itemsCount'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      buyer: json['buyer'] == null
          ? null
          : ComprehensiveBuyerResponse.fromJson(
              json['buyer'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) =>
              ComprehensiveShopItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      stages: (json['stages'] as List<dynamic>?)
          ?.map((e) =>
              ComprehensiveStageResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      stagesSummary: json['stagesSummary'] == null
          ? null
          : ComprehensiveStagesSummaryResponse.fromJson(
              json['stagesSummary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ComprehensiveShopOrderResponseToJson(
        ComprehensiveShopOrderResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderNumber': instance.orderNumber,
      'status': instance.status,
      'paymentStatus': instance.paymentStatus,
      'totalAmount': instance.totalAmount,
      'itemsCount': instance.itemsCount,
      'createdAt': instance.createdAt,
      'buyer': instance.buyer,
      'items': instance.items,
      'stages': instance.stages,
      'stagesSummary': instance.stagesSummary,
    };

ComprehensiveBuyerResponse _$ComprehensiveBuyerResponseFromJson(
        Map<String, dynamic> json) =>
    ComprehensiveBuyerResponse(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$ComprehensiveBuyerResponseToJson(
        ComprehensiveBuyerResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'image': instance.image,
    };

ComprehensiveShopItemResponse _$ComprehensiveShopItemResponseFromJson(
        Map<String, dynamic> json) =>
    ComprehensiveShopItemResponse(
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

Map<String, dynamic> _$ComprehensiveShopItemResponseToJson(
        ComprehensiveShopItemResponse instance) =>
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

ComprehensiveStageResponse _$ComprehensiveStageResponseFromJson(
        Map<String, dynamic> json) =>
    ComprehensiveStageResponse(
      key: json['key'] as String?,
      label: json['label'] as String?,
      completed: json['completed'] as bool?,
      statusDate: json['statusDate'] as String?,
    );

Map<String, dynamic> _$ComprehensiveStageResponseToJson(
        ComprehensiveStageResponse instance) =>
    <String, dynamic>{
      'key': instance.key,
      'label': instance.label,
      'completed': instance.completed,
      'statusDate': instance.statusDate,
    };

ComprehensiveStagesSummaryResponse _$ComprehensiveStagesSummaryResponseFromJson(
        Map<String, dynamic> json) =>
    ComprehensiveStagesSummaryResponse(
      totalStages: (json['totalStages'] as num?)?.toInt(),
      completedStagesCount: (json['completedStagesCount'] as num?)?.toInt(),
      incompleteStagesCount: (json['incompleteStagesCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ComprehensiveStagesSummaryResponseToJson(
        ComprehensiveStagesSummaryResponse instance) =>
    <String, dynamic>{
      'totalStages': instance.totalStages,
      'completedStagesCount': instance.completedStagesCount,
      'incompleteStagesCount': instance.incompleteStagesCount,
    };

ComprehensiveZoqakOrderResponse _$ComprehensiveZoqakOrderResponseFromJson(
        Map<String, dynamic> json) =>
    ComprehensiveZoqakOrderResponse(
      id: json['id'] as String?,
      orderNumber: json['orderNumber'] as String?,
      productName: json['productName'] as String?,
      description: json['description'] as String?,
      specialRequests: json['specialRequests'] as String?,
      fabricType: json['fabricType'] as String?,
      minExpectedBudget: json['minExpectedBudget'] as num?,
      maxExpectedBudget: json['maxExpectedBudget'] as num?,
      deliveryDate: json['deliveryDate'] as String?,
      similarImages: (json['similarImages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      userName: json['userName'] as String?,
      userImage: json['userImage'] as String?,
      offersCount: (json['offersCount'] as num?)?.toInt(),
      paymentStatus: json['paymentStatus'] as String?,
      acceptedByProviderId: json['acceptedByProviderId'] as String?,
      userId: json['userId'] as String?,
      myOffer: json['myOffer'] == null
          ? null
          : ComprehensiveZoqakOfferResponse.fromJson(
              json['myOffer'] as Map<String, dynamic>),
      timeline: (json['timeline'] as List<dynamic>?)
          ?.map((e) => ComprehensiveTimelineEventResponse.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ComprehensiveZoqakOrderResponseToJson(
        ComprehensiveZoqakOrderResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderNumber': instance.orderNumber,
      'productName': instance.productName,
      'description': instance.description,
      'specialRequests': instance.specialRequests,
      'fabricType': instance.fabricType,
      'minExpectedBudget': instance.minExpectedBudget,
      'maxExpectedBudget': instance.maxExpectedBudget,
      'deliveryDate': instance.deliveryDate,
      'similarImages': instance.similarImages,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'userName': instance.userName,
      'userImage': instance.userImage,
      'offersCount': instance.offersCount,
      'paymentStatus': instance.paymentStatus,
      'acceptedByProviderId': instance.acceptedByProviderId,
      'userId': instance.userId,
      'myOffer': instance.myOffer,
      'timeline': instance.timeline,
    };

ComprehensiveZoqakOfferResponse _$ComprehensiveZoqakOfferResponseFromJson(
        Map<String, dynamic> json) =>
    ComprehensiveZoqakOfferResponse(
      id: json['id'] as String?,
      orderId: json['orderId'] as String?,
      proposedPrice: json['proposedPrice'] as num?,
      executionDays: (json['executionDays'] as num?)?.toInt(),
      details: json['details'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$ComprehensiveZoqakOfferResponseToJson(
        ComprehensiveZoqakOfferResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'proposedPrice': instance.proposedPrice,
      'executionDays': instance.executionDays,
      'details': instance.details,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

ComprehensiveTimelineEventResponse _$ComprehensiveTimelineEventResponseFromJson(
        Map<String, dynamic> json) =>
    ComprehensiveTimelineEventResponse(
      code: json['code'] as String?,
      occurredAt: json['occurredAt'] as String?,
    );

Map<String, dynamic> _$ComprehensiveTimelineEventResponseToJson(
        ComprehensiveTimelineEventResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'occurredAt': instance.occurredAt,
    };

ZoqakMyOfferByOrderResponse _$ZoqakMyOfferByOrderResponseFromJson(
        Map<String, dynamic> json) =>
    ZoqakMyOfferByOrderResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : ZoqakMyOfferByOrderDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ZoqakMyOfferByOrderResponseToJson(
        ZoqakMyOfferByOrderResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

ZoqakMyOfferByOrderDataResponse _$ZoqakMyOfferByOrderDataResponseFromJson(
        Map<String, dynamic> json) =>
    ZoqakMyOfferByOrderDataResponse(
      offer: json['offer'] == null
          ? null
          : ComprehensiveZoqakOfferResponse.fromJson(
              json['offer'] as Map<String, dynamic>),
      order: json['order'] == null
          ? null
          : ZoqakDetailOrderResponse.fromJson(
              json['order'] as Map<String, dynamic>),
      timeline: (json['timeline'] as List<dynamic>?)
          ?.map((e) => ComprehensiveTimelineEventResponse.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ZoqakMyOfferByOrderDataResponseToJson(
        ZoqakMyOfferByOrderDataResponse instance) =>
    <String, dynamic>{
      'offer': instance.offer,
      'order': instance.order,
      'timeline': instance.timeline,
    };

ZoqakDetailOrderResponse _$ZoqakDetailOrderResponseFromJson(
        Map<String, dynamic> json) =>
    ZoqakDetailOrderResponse(
      id: json['id'] as String?,
      orderNumber: json['orderNumber'] as String?,
      productName: json['productName'] as String?,
      description: json['description'] as String?,
      specialRequests: json['specialRequests'] as String?,
      fabricType: json['fabricType'] as String?,
      minExpectedBudget: json['minExpectedBudget'] as num?,
      maxExpectedBudget: json['maxExpectedBudget'] as num?,
      deliveryDate: json['deliveryDate'] as String?,
      similarImages: (json['similarImages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      status: json['status'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
      acceptedByProviderId: json['acceptedByProviderId'] as String?,
      requester: json['requester'] == null
          ? null
          : ZoqakRequesterResponse.fromJson(
              json['requester'] as Map<String, dynamic>),
      totalOffersOnOrder: (json['totalOffersOnOrder'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ZoqakDetailOrderResponseToJson(
        ZoqakDetailOrderResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderNumber': instance.orderNumber,
      'productName': instance.productName,
      'description': instance.description,
      'specialRequests': instance.specialRequests,
      'fabricType': instance.fabricType,
      'minExpectedBudget': instance.minExpectedBudget,
      'maxExpectedBudget': instance.maxExpectedBudget,
      'deliveryDate': instance.deliveryDate,
      'similarImages': instance.similarImages,
      'status': instance.status,
      'paymentStatus': instance.paymentStatus,
      'acceptedByProviderId': instance.acceptedByProviderId,
      'requester': instance.requester,
      'totalOffersOnOrder': instance.totalOffersOnOrder,
    };

ZoqakRequesterResponse _$ZoqakRequesterResponseFromJson(
        Map<String, dynamic> json) =>
    ZoqakRequesterResponse(
      fullName: json['fullName'] as String?,
      image: json['image'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$ZoqakRequesterResponseToJson(
        ZoqakRequesterResponse instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'image': instance.image,
      'phoneNumber': instance.phoneNumber,
    };
