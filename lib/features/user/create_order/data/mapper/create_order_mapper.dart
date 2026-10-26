import 'package:app_mobile/core/extensions/extensions.dart';
import '../response/create_order_response.dart';
import '../../domain/model/create_order_model.dart';

/// Maps [CreateOrderDataResponse] → [CreateOrderModel].
extension CreateOrderDataMapper on CreateOrderDataResponse {
  CreateOrderModel toDomain() {
    return CreateOrderModel(
      id:                 id.onNull(),
      orderNumber:        orderNumber.onNull(),
      productName:        productName.onNull(),
      description:        description.onNull(),
      specialRequests:    specialRequests.onNull(),
      fabricType:         fabricType.onNull(),
      minExpectedBudget:  (minExpectedBudget ?? 0).toDouble(),
      maxExpectedBudget:  (maxExpectedBudget ?? 0).toDouble(),
      deliveryDate:       deliveryDate.onNull(),
      similarImages:      similarImages ?? [],
      status:             status.onNull(),
      createdAt:          createdAt.onNull(),
      userName:           userName.onNull(),
    );
  }
}

/// Maps top-level [CreateOrderResponse] → [CreateOrderModel].
extension CreateOrderMapper on CreateOrderResponse {
  CreateOrderModel toDomain() => data!.toDomain();
}
