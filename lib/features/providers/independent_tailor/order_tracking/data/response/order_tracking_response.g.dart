// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_tracking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyOrdersResponse _$MyOrdersResponseFromJson(Map<String, dynamic> json) =>
    MyOrdersResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : MyOrdersDataResponse.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MyOrdersResponseToJson(MyOrdersResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

MyOrdersDataResponse _$MyOrdersDataResponseFromJson(
        Map<String, dynamic> json) =>
    MyOrdersDataResponse(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => MyOrderItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      counts: json['counts'] == null
          ? null
          : OrderCountsResponse.fromJson(
              json['counts'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MyOrdersDataResponseToJson(
        MyOrdersDataResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
      'counts': instance.counts,
    };

MyOrderItemResponse _$MyOrderItemResponseFromJson(Map<String, dynamic> json) =>
    MyOrderItemResponse(
      orderId: json['orderId'] as String?,
      orderNumber: json['orderNumber'] as String?,
      userName: json['userName'] as String?,
      userImage: json['userImage'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      statusPayment: json['statusPayment'] as String?,
      status: json['status'] as String?,
      stages: (json['stages'] as List<dynamic>?)
          ?.map((e) => OrderStageResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      stagesSummary: json['stagesSummary'] == null
          ? null
          : OrderStagesSummaryResponse.fromJson(
              json['stagesSummary'] as Map<String, dynamic>),
      latestStatus: json['latestStatus'] == null
          ? null
          : OrderLatestStatusResponse.fromJson(
              json['latestStatus'] as Map<String, dynamic>),
      orderDate: json['orderDate'] as String?,
      deliveryDeadline: json['deliveryDeadline'] as String?,
    );

Map<String, dynamic> _$MyOrderItemResponseToJson(
        MyOrderItemResponse instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'orderNumber': instance.orderNumber,
      'userName': instance.userName,
      'userImage': instance.userImage,
      'price': instance.price,
      'statusPayment': instance.statusPayment,
      'status': instance.status,
      'stages': instance.stages,
      'stagesSummary': instance.stagesSummary,
      'latestStatus': instance.latestStatus,
      'orderDate': instance.orderDate,
      'deliveryDeadline': instance.deliveryDeadline,
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

OrderStagesSummaryResponse _$OrderStagesSummaryResponseFromJson(
        Map<String, dynamic> json) =>
    OrderStagesSummaryResponse(
      totalStages: (json['totalStages'] as num?)?.toInt(),
      completedStagesCount: (json['completedStagesCount'] as num?)?.toInt(),
      incompleteStagesCount: (json['incompleteStagesCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderStagesSummaryResponseToJson(
        OrderStagesSummaryResponse instance) =>
    <String, dynamic>{
      'totalStages': instance.totalStages,
      'completedStagesCount': instance.completedStagesCount,
      'incompleteStagesCount': instance.incompleteStagesCount,
    };

OrderLatestStatusResponse _$OrderLatestStatusResponseFromJson(
        Map<String, dynamic> json) =>
    OrderLatestStatusResponse(
      key: json['key'] as String?,
      label: json['label'] as String?,
      statusDate: json['statusDate'] as String?,
    );

Map<String, dynamic> _$OrderLatestStatusResponseToJson(
        OrderLatestStatusResponse instance) =>
    <String, dynamic>{
      'key': instance.key,
      'label': instance.label,
      'statusDate': instance.statusDate,
    };

OrderCountsResponse _$OrderCountsResponseFromJson(Map<String, dynamic> json) =>
    OrderCountsResponse(
      all: (json['all'] as num?)?.toInt(),
      accepted: (json['accepted'] as num?)?.toInt(),
      inProgress: (json['in_progress'] as num?)?.toInt(),
      ready: (json['ready'] as num?)?.toInt(),
      readyForDelivery: (json['ready_for_delivery'] as num?)?.toInt(),
      completed: (json['completed'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderCountsResponseToJson(
        OrderCountsResponse instance) =>
    <String, dynamic>{
      'all': instance.all,
      'accepted': instance.accepted,
      'in_progress': instance.inProgress,
      'ready': instance.ready,
      'ready_for_delivery': instance.readyForDelivery,
      'completed': instance.completed,
    };

UpdateOrderStatusResponse _$UpdateOrderStatusResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateOrderStatusResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$UpdateOrderStatusResponseToJson(
        UpdateOrderStatusResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
    };

AcceptedOrderDetailResponse _$AcceptedOrderDetailResponseFromJson(
        Map<String, dynamic> json) =>
    AcceptedOrderDetailResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : AcceptedOrderDetailDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AcceptedOrderDetailResponseToJson(
        AcceptedOrderDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

AcceptedOrderDetailDataResponse _$AcceptedOrderDetailDataResponseFromJson(
        Map<String, dynamic> json) =>
    AcceptedOrderDetailDataResponse(
      orderId: json['orderId'] as String?,
      orderNumber: json['orderNumber'] as String?,
      status: json['status'] as String?,
      stages: (json['stages'] as List<dynamic>?)
          ?.map((e) => OrderStageResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      stagesSummary: json['stagesSummary'] == null
          ? null
          : OrderStagesSummaryResponse.fromJson(
              json['stagesSummary'] as Map<String, dynamic>),
      latestStatus: json['latestStatus'] == null
          ? null
          : OrderLatestStatusResponse.fromJson(
              json['latestStatus'] as Map<String, dynamic>),
      paymentStatus: json['paymentStatus'] as String?,
      orderDate: json['orderDate'] as String?,
      deliveryDeadline: json['deliveryDeadline'] as String?,
      userName: json['userName'] as String?,
      userImage: json['userImage'] as String?,
      userPhone: json['userPhone'] as String?,
      productName: json['productName'] as String?,
      description: json['description'] as String?,
      specialRequests: json['specialRequests'] as String?,
      fabricType: json['fabricType'] as String?,
      minExpectedBudget: (json['minExpectedBudget'] as num?)?.toDouble(),
      maxExpectedBudget: (json['maxExpectedBudget'] as num?)?.toDouble(),
      similarImages: (json['similarImages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      myOffer: json['myOffer'] == null
          ? null
          : AcceptedOrderMyOfferResponse.fromJson(
              json['myOffer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AcceptedOrderDetailDataResponseToJson(
        AcceptedOrderDetailDataResponse instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'orderNumber': instance.orderNumber,
      'status': instance.status,
      'stages': instance.stages,
      'stagesSummary': instance.stagesSummary,
      'latestStatus': instance.latestStatus,
      'paymentStatus': instance.paymentStatus,
      'orderDate': instance.orderDate,
      'deliveryDeadline': instance.deliveryDeadline,
      'userName': instance.userName,
      'userImage': instance.userImage,
      'userPhone': instance.userPhone,
      'productName': instance.productName,
      'description': instance.description,
      'specialRequests': instance.specialRequests,
      'fabricType': instance.fabricType,
      'minExpectedBudget': instance.minExpectedBudget,
      'maxExpectedBudget': instance.maxExpectedBudget,
      'similarImages': instance.similarImages,
      'myOffer': instance.myOffer,
    };

AcceptedOrderMyOfferResponse _$AcceptedOrderMyOfferResponseFromJson(
        Map<String, dynamic> json) =>
    AcceptedOrderMyOfferResponse(
      proposedPrice: (json['proposedPrice'] as num?)?.toDouble(),
      executionDays: (json['executionDays'] as num?)?.toInt(),
      details: json['details'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$AcceptedOrderMyOfferResponseToJson(
        AcceptedOrderMyOfferResponse instance) =>
    <String, dynamic>{
      'proposedPrice': instance.proposedPrice,
      'executionDays': instance.executionDays,
      'details': instance.details,
      'createdAt': instance.createdAt,
    };
