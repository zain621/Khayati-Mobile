import 'package:app_mobile/core/extensions/extensions.dart';
import '../response/order_detail_response.dart';
import '../../domain/model/order_detail_model.dart';

extension OrderDetailDataMapper on OrderDetailDataResponse {
  OrderDetailModel toDomain() {
    return OrderDetailModel(
      id: id.onNull(),
      orderNumber: orderNumber.onNull(),
      productName: productName.onNull(),
      description: description.onNull(),
      specialRequests: specialRequests.onNull(),
      fabricType: fabricType.onNull(),
      minExpectedBudget: (minExpectedBudget ?? 0).toDouble(),
      maxExpectedBudget: (maxExpectedBudget ?? 0).toDouble(),
      deliveryDate: deliveryDate.onNull(),
      similarImages: (similarImages ?? []).cast<String>(),
      status: status.onNull(),
      createdAt: createdAt.onNull(),
      userName: userName.onNull(),
      userImage: userImage,
      offersCount: offersCount ?? 0,
    );
  }
}

extension OrderDetailMapper on OrderDetailResponse {
  OrderDetailModel toDomain() {
    return data?.toDomain() ??
        OrderDetailModel(
          id: '',
          orderNumber: '',
          productName: '',
          description: '',
          specialRequests: '',
          fabricType: '',
          minExpectedBudget: 0,
          maxExpectedBudget: 0,
          deliveryDate: '',
          similarImages: [],
          status: '',
          createdAt: '',
          userName: '',
          offersCount: 0,
        );
  }
}
