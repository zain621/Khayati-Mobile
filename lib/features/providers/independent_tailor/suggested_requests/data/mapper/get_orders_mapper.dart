import 'package:app_mobile/core/extensions/extensions.dart';
import '../response/get_orders_response.dart';
import '../../domain/model/suggested_order_model.dart';

/// Maps [OrderDataResponse] → [SuggestedOrderModel].
extension OrderDataMapper on OrderDataResponse {
  SuggestedOrderModel toDomain() {
    return SuggestedOrderModel(
      id: id.onNull(),
      orderNumber: orderNumber.onNull(),
      productName: productName.onNull(),
      description: description.onNull(),
      specialRequests: specialRequests.onNull(),
      fabricType: fabricType.onNull(),
      minExpectedBudget: (minExpectedBudget ?? 0).toDouble(),
      maxExpectedBudget: (maxExpectedBudget ?? 0).toDouble(),
      deliveryDate: deliveryDate.onNull(),
      similarImages: similarImages.onNull(),
      status: status.onNull(),
      createdAt: createdAt.onNull(),
      userName: userName.onNull(),
      userImage: userImage,
      offersCount: offersCount ?? 0,
    );
  }
}

/// Maps [GetOrdersResponse] → list of [SuggestedOrderModel].
extension GetOrdersMapper on GetOrdersResponse {
  List<SuggestedOrderModel> toDomain() {
    return (data ?? []).map((order) => order.toDomain()).toList();
  }
}
