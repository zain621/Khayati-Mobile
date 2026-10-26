import 'package:app_mobile/core/extensions/extensions.dart';
import '../../domain/model/comprehensive_order_tracking_model.dart';
import '../response/comprehensive_orders_response.dart';
import '../response/comprehensive_order_detail_response.dart';

// ─── Buyer ────────────────────────────────────────────────────────────────────

extension ComprehensiveBuyerMapper on ComprehensiveBuyerResponse {
  ComprehensiveOrderBuyerModel toDomain() => ComprehensiveOrderBuyerModel(
        id: id.onNull(),
        fullName: fullName.onNull(),
        phoneNumber: phoneNumber.onNull(),
        imageUrl: image,
      );
}

// ─── Item ─────────────────────────────────────────────────────────────────────

extension ComprehensiveShopItemMapper on ComprehensiveShopItemResponse {
  ComprehensiveShopItemModel toDomain() => ComprehensiveShopItemModel(
        id: id.onNull(),
        productName: productName.onNull(),
        color: color.onNull(),
        size: size.onNull(),
        quantity: quantity ?? 0,
        unitPrice: (unitPrice ?? 0).toDouble(),
        totalPrice: (totalPrice ?? 0).toDouble(),
      );
}

// ─── Stage ────────────────────────────────────────────────────────────────────

extension ComprehensiveStageMapper on ComprehensiveStageResponse {
  ComprehensiveStageModel toDomain() => ComprehensiveStageModel(
        key: key.onNull(),
        label: label.onNull(),
        completed: completed ?? false,
        statusDate: statusDate,
      );
}

// ─── Shop order ───────────────────────────────────────────────────────────────

extension ComprehensiveShopOrderMapper on ComprehensiveShopOrderResponse {
  ComprehensiveShopOrderModel toDomain() {
    final mappedStages = stages?.map((s) => s.toDomain()).toList() ?? [];
    return ComprehensiveShopOrderModel(
      id: id.onNull(),
      orderNumber: orderNumber.onNull(),
      status: status.onNull(),
      paymentStatus: paymentStatus.onNull(),
      totalAmount: (totalAmount ?? 0).toDouble(),
      itemsCount: itemsCount ?? 0,
      createdAt: createdAt.onNull(),
      buyer: buyer?.toDomain() ??
          const ComprehensiveOrderBuyerModel(
            id: '',
            fullName: '',
            phoneNumber: '',
          ),
      items: items?.map((i) => i.toDomain()).toList() ?? [],
      stages: mappedStages,
      completedStagesCount: stagesSummary?.completedStagesCount ?? 0,
    );
  }
}

// ─── Zoqak order ─────────────────────────────────────────────────────────────

extension ComprehensiveZoqakOrderMapper on ComprehensiveZoqakOrderResponse {
  ComprehensiveZoqakOrderModel toDomain() => ComprehensiveZoqakOrderModel(
        id: id.onNull(),
        orderNumber: orderNumber.onNull(),
        productName: productName.onNull(),
        description: description,
        specialRequests: specialRequests,
        fabricType: fabricType,
        minBudget: (minExpectedBudget ?? 0).toDouble(),
        maxBudget: (maxExpectedBudget ?? 0).toDouble(),
        deliveryDate: deliveryDate,
        similarImages: similarImages ?? [],
        status: _toZoqakStatus(status),
        statusKey: status ?? '',
        createdAt: createdAt.onNull(),
        userName: userName.onNull(),
        userImage: userImage,
        offersCount: offersCount ?? 0,
        paymentStatus: paymentStatus,
        acceptedByProviderId: acceptedByProviderId,
        userId: userId,
        offer: myOffer?.toDomain(),
        timeline: timeline?.map((e) => e.toDomain()).toList() ?? const [],
      );
}

extension ComprehensiveZoqakOfferMapper on ComprehensiveZoqakOfferResponse {
  ComprehensiveZoqakOfferModel toDomain() => ComprehensiveZoqakOfferModel(
        id: id.onNull(),
        orderId: orderId.onNull(),
        proposedPrice: (proposedPrice ?? 0).toDouble(),
        executionDays: executionDays ?? 0,
        details: details.onNull(),
        status: status.onNull(),
        createdAt: createdAt.onNull(),
        updatedAt: updatedAt.onNull(),
      );
}

extension ComprehensiveTimelineMapper on ComprehensiveTimelineEventResponse {
  ComprehensiveTimelineModel toDomain() => ComprehensiveTimelineModel(
        code: code.onNull(),
        occurredAt: occurredAt.onNull(),
      );
}

// ─── Zoqak offer detail (by-order) ───────────────────────────────────────────

extension ZoqakRequesterMapper on ZoqakRequesterResponse {
  ComprehensiveRequesterModel toDomain() => ComprehensiveRequesterModel(
        fullName: fullName.onNull(),
        image: image,
        phoneNumber: phoneNumber.onNull(),
      );
}

extension ZoqakDetailOrderMapper on ZoqakDetailOrderResponse {
  ZoqakOfferDetailOrderModel toDomain() => ZoqakOfferDetailOrderModel(
        id: id.onNull(),
        orderNumber: orderNumber.onNull(),
        productName: productName.onNull(),
        description: description,
        specialRequests: specialRequests,
        fabricType: fabricType,
        minBudget: (minExpectedBudget ?? 0).toDouble(),
        maxBudget: (maxExpectedBudget ?? 0).toDouble(),
        deliveryDate: deliveryDate,
        similarImages: similarImages ?? [],
        status: _toZoqakStatus(status),
        requester: requester?.toDomain() ??
            const ComprehensiveRequesterModel(
              fullName: '',
              phoneNumber: '',
            ),
      );
}

extension ZoqakMyOfferByOrderMapper on ZoqakMyOfferByOrderResponse {
  ZoqakOfferDetailModel toDomain() {
    final d = data;
    return ZoqakOfferDetailModel(
      offer: d?.offer?.toDomain() ??
          ComprehensiveZoqakOfferModel(
            id: '',
            orderId: '',
            proposedPrice: 0,
            executionDays: 0,
            details: '',
            status: '',
            createdAt: '',
            updatedAt: '',
          ),
      order: d?.order?.toDomain() ??
          ZoqakOfferDetailOrderModel(
            id: '',
            orderNumber: '',
            productName: '',
            similarImages: [],
            status: ComprehensiveZoqakStatus.unknown,
            requester: const ComprehensiveRequesterModel(
              fullName: '',
              phoneNumber: '',
            ),
            minBudget: 0,
            maxBudget: 0,
          ),
      timeline: d?.timeline?.map((e) => e.toDomain()).toList() ?? const [],
    );
  }
}

ComprehensiveZoqakStatus _toZoqakStatus(String? raw) {
  switch ((raw ?? '').toLowerCase()) {
    case 'pending':
      return ComprehensiveZoqakStatus.pending;
    case 'accepted':
    case 'started':
    case 'in_progress':
    case 'in progress':
    case 'ready':
    case 'ready_for_delivery':
      return ComprehensiveZoqakStatus.accepted;
    case 'completed':
    case 'done':
      return ComprehensiveZoqakStatus.completed;
    case 'cancelled':
    case 'canceled':
    case 'rejected':
      return ComprehensiveZoqakStatus.cancelled;
    default:
      return ComprehensiveZoqakStatus.unknown;
  }
}

// ─── Orders list ─────────────────────────────────────────────────────────────

extension ComprehensiveOrdersMapper on ComprehensiveOrdersResponse {
  ComprehensiveOrdersModel toDomain() {
    final d = data;
    return ComprehensiveOrdersModel(
      shopOrders: d?.shopOrders?.map((o) => o.toDomain()).toList() ?? [],
      zoqakOrders: d?.zoqakOrders?.map((o) => o.toDomain()).toList() ?? [],
    );
  }
}

// ─── Order detail ─────────────────────────────────────────────────────────────

extension ComprehensiveOrderDetailMapper on ComprehensiveOrderDetailResponse {
  ComprehensiveOrderDetailModel toDomain() {
    final d = data;
    final src = d?.source ?? 'shop';
    return ComprehensiveOrderDetailModel(
      source: src,
      shopOrder: d?.shopOrder?.toDomain(),
    );
  }
}
