// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutResponse _$CheckoutResponseFromJson(Map<String, dynamic> json) =>
    CheckoutResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : CheckoutDataResponse.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$CheckoutResponseToJson(CheckoutResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };

CheckoutDataResponse _$CheckoutDataResponseFromJson(
        Map<String, dynamic> json) =>
    CheckoutDataResponse(
      orders: (json['orders'] as List<dynamic>?)
          ?.map(
              (e) => CheckoutOrderResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      payment: json['payment'] == null
          ? null
          : CheckoutPaymentResponse.fromJson(
              json['payment'] as Map<String, dynamic>),
      userLoyaltyPoints: (json['userLoyaltyPoints'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CheckoutDataResponseToJson(
        CheckoutDataResponse instance) =>
    <String, dynamic>{
      'orders': instance.orders,
      'payment': instance.payment,
      'userLoyaltyPoints': instance.userLoyaltyPoints,
    };

CheckoutOrderResponse _$CheckoutOrderResponseFromJson(
        Map<String, dynamic> json) =>
    CheckoutOrderResponse(
      id: json['_id'] as String?,
      orderNumber: json['orderNumber'] as String?,
      shopId: json['shopId'] as String?,
      shopName: json['shopName'] as String?,
      status: json['status'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
      totalAmount: (json['totalAmount'] as num?)?.toDouble(),
      itemsCount: (json['itemsCount'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$CheckoutOrderResponseToJson(
        CheckoutOrderResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'orderNumber': instance.orderNumber,
      'shopId': instance.shopId,
      'shopName': instance.shopName,
      'status': instance.status,
      'paymentStatus': instance.paymentStatus,
      'totalAmount': instance.totalAmount,
      'itemsCount': instance.itemsCount,
      'createdAt': instance.createdAt,
    };

CheckoutPaymentResponse _$CheckoutPaymentResponseFromJson(
        Map<String, dynamic> json) =>
    CheckoutPaymentResponse(
      paymentSessionId: json['paymentSessionId'] as String?,
      provider: json['provider'] as String?,
      status: json['status'] as String?,
      paymentUrl: json['paymentUrl'] as String?,
      invoiceUrl: json['invoiceUrl'] as String?,
    );

Map<String, dynamic> _$CheckoutPaymentResponseToJson(
        CheckoutPaymentResponse instance) =>
    <String, dynamic>{
      'paymentSessionId': instance.paymentSessionId,
      'provider': instance.provider,
      'status': instance.status,
      'paymentUrl': instance.paymentUrl,
      'invoiceUrl': instance.invoiceUrl,
    };
