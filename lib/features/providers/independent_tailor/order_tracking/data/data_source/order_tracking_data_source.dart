import 'package:app_mobile/core/network/app_api.dart';
import '../request/update_order_status_request.dart';
import '../response/order_tracking_response.dart';

abstract class OrderTrackingDataSource {
  Future<MyOrdersDataResponse> fetchMyAcceptedOrders();
  Future<AcceptedOrderDetailResponse> fetchOrderDetail(String orderId);
  Future<void> updateOrderStatus(UpdateOrderStatusRequest request);
}

class OrderTrackingDataSourceImplement implements OrderTrackingDataSource {
  final AppService _appService;

  OrderTrackingDataSourceImplement(this._appService);

  @override
  Future<MyOrdersDataResponse> fetchMyAcceptedOrders() async {
    final response = await _appService.getMyAcceptedOrders();
    return response.data!;
  }

  @override
  Future<AcceptedOrderDetailResponse> fetchOrderDetail(String orderId) async {
    return await _appService.getMyAcceptedOrderDetail(orderId);
  }

  @override
  Future<void> updateOrderStatus(UpdateOrderStatusRequest request) async {
    await _appService.updateOrderStatus(
      request.orderId,
      {'status': request.status},
    );
  }
}
