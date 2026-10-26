import 'package:app_mobile/core/extensions/extensions.dart';
import '../../domain/model/order_tracking_model.dart';
import '../response/order_tracking_response.dart';

extension MyOrdersDataMapper on MyOrdersDataResponse {
  OrderTrackingDataModel toDomain() {
    return OrderTrackingDataModel(
      items: items.onNull().map((e) => e.toDomain()).toList(),
      counts: (counts ?? OrderCountsResponse()).toDomain(),
    );
  }
}

extension MyOrderItemMapper on MyOrderItemResponse {
  OrderTrackingItemModel toDomain() {
    return OrderTrackingItemModel(
      orderId: orderId.onNull(),
      orderNumber: orderNumber.onNull(),
      userName: userName.onNull(),
      userImage: userImage,
      price: price.onNull(),
      statusPayment: statusPayment.onNull(),
      status: status.toDomainStatus(),
      stages: stages.onNull().map((e) => e.toDomain()).toList(),
      stagesSummary: (stagesSummary ?? OrderStagesSummaryResponse()).toDomain(),
      latestStatus: (latestStatus ?? OrderLatestStatusResponse()).toDomain(),
      orderDate: orderDate.onNull(),
      deliveryDeadline: deliveryDeadline.onNull(),
    );
  }
}

extension OrderStageMapper on OrderStageResponse {
  OrderTrackingStageModel toDomain() {
    return OrderTrackingStageModel(
      key: key.onNull(),
      label: label.onNull(),
      completed: completed.onNull(),
      statusDate: statusDate.onNull(),
    );
  }
}

extension OrderStagesSummaryMapper on OrderStagesSummaryResponse {
  OrderTrackingStagesSummaryModel toDomain() {
    return OrderTrackingStagesSummaryModel(
      totalStages: totalStages.onNull(),
      completedStagesCount: completedStagesCount.onNull(),
      incompleteStagesCount: incompleteStagesCount.onNull(),
    );
  }
}

extension OrderLatestStatusMapper on OrderLatestStatusResponse {
  OrderTrackingLatestStatusModel toDomain() {
    return OrderTrackingLatestStatusModel(
      key: key.onNull(),
      label: label.onNull(),
      statusDate: statusDate.onNull(),
    );
  }
}

extension OrderCountsMapper on OrderCountsResponse {
  OrderTrackingCountsModel toDomain() {
    return OrderTrackingCountsModel(
      all: all.onNull(),
      accepted: accepted.onNull(),
      inProgress: inProgress.onNull(),
      ready: ready.onNull(),
      readyForDelivery: readyForDelivery.onNull(),
      completed: completed.onNull(),
    );
  }
}

extension _StatusMapper on String? {
  OrderTrackingStatus toDomainStatus() {
    switch ((this ?? '').toLowerCase()) {
      case 'accepted':
        return OrderTrackingStatus.accepted;
      case 'in_progress':
        return OrderTrackingStatus.inProgress;
      case 'ready':
        return OrderTrackingStatus.ready;
      case 'ready_for_delivery':
        return OrderTrackingStatus.readyForDelivery;
      case 'completed':
        return OrderTrackingStatus.completed;
      default:
        return OrderTrackingStatus.unknown;
    }
  }
}

extension AcceptedOrderDetailMapper on AcceptedOrderDetailResponse {
  OrderTrackingDetailModel toDomain() {
    final d = data ?? AcceptedOrderDetailDataResponse();
    return d.toDomain();
  }
}

extension AcceptedOrderDetailDataMapper on AcceptedOrderDetailDataResponse {
  OrderTrackingDetailModel toDomain() {
    return OrderTrackingDetailModel(
      orderId: orderId.onNull(),
      orderNumber: orderNumber.onNull(),
      status: status.toDomainStatus(),
      stages: stages.onNull().map((e) => e.toDomain()).toList(),
      stagesSummary: (stagesSummary ?? OrderStagesSummaryResponse()).toDomain(),
      latestStatus: (latestStatus ?? OrderLatestStatusResponse()).toDomain(),
      paymentStatus: paymentStatus.onNull(),
      orderDate: orderDate.onNull(),
      deliveryDeadline: deliveryDeadline.onNull(),
      userName: userName.onNull(),
      userImage: userImage,
      userPhone: userPhone.onNull(),
      productName: productName.onNull(),
      description: description.onNull(),
      specialRequests: specialRequests.onNull(),
      fabricType: fabricType.onNull(),
      minExpectedBudget: minExpectedBudget.onNull(),
      maxExpectedBudget: maxExpectedBudget.onNull(),
      similarImages: similarImages.onNull(),
      myOffer: myOffer?.toDomain(),
    );
  }
}

extension AcceptedOrderMyOfferMapper on AcceptedOrderMyOfferResponse {
  OrderTrackingDetailMyOfferModel toDomain() {
    return OrderTrackingDetailMyOfferModel(
      proposedPrice: proposedPrice.onNull(),
      executionDays: executionDays.onNull(),
      details: details.onNull(),
      createdAt: createdAt.onNull(),
    );
  }
}
