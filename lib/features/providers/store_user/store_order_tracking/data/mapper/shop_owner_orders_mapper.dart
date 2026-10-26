import 'package:app_mobile/core/extensions/extensions.dart';
import '../response/get_shop_owner_orders_response.dart';
import '../../domain/model/shop_owner_order_model.dart';

extension ShopOrderBuyerMapper on ShopOrderBuyerResponse {
  ShopOrderBuyerModel toDomain() {
    return ShopOrderBuyerModel(
      id: id.onNull(),
      fullName: fullName.onNull(),
      phoneNumber: phoneNumber.onNull(),
      imageUrl: image,
    );
  }
}

extension ShopOrderItemMapper on ShopOrderItemResponse {
  ShopOrderItemModel toDomain() {
    return ShopOrderItemModel(
      id: id.onNull(),
      productName: productName.onNull(),
      color: color.onNull(),
      size: size.onNull(),
      quantity: quantity ?? 0,
      unitPrice: (unitPrice ?? 0).toDouble(),
      totalPrice: (totalPrice ?? 0).toDouble(),
    );
  }
}

extension ShopOrderStageMapper on ShopOrderStageResponse {
  ShopOrderStageModel toDomain() {
    return ShopOrderStageModel(
      key: key.onNull(),
      label: label.onNull(),
      completed: completed ?? false,
      statusDate: statusDate,
    );
  }
}

extension ShopOrderDataMapper on ShopOrderDataResponse {
  ShopOwnerOrderModel toDomain() {
    final mappedStages =
        stages?.map((s) => s.toDomain()).toList() ?? [];
    return ShopOwnerOrderModel(
      id: id.onNull(),
      orderNumber: orderNumber.onNull(),
      status: status.onNull(),
      paymentStatus: paymentStatus.onNull(),
      totalAmount: (totalAmount ?? 0).toDouble(),
      itemsCount: itemsCount ?? 0,
      createdAt: createdAt.onNull(),
      buyer: buyer?.toDomain() ??
          const ShopOrderBuyerModel(
            id: '',
            fullName: '',
            phoneNumber: '',
          ),
      items: items?.map((i) => i.toDomain()).toList() ?? [],
      stages: mappedStages,
      completedStagesCount:
          stagesSummary?.completedStagesCount ?? 0,
    );
  }
}

extension GetShopOwnerOrdersMapper on GetShopOwnerOrdersResponse {
  List<ShopOwnerOrderModel> toDomain() {
    return data?.map((o) => o.toDomain()).toList() ?? [];
  }
}
