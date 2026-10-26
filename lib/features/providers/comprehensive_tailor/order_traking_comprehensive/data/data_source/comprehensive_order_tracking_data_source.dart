import '../../../../../../core/network/app_api.dart';
import '../request/update_comprehensive_order_stage_request.dart';
import '../response/comprehensive_order_detail_response.dart';
import '../response/comprehensive_orders_response.dart';
import '../../../../../providers/store_user/store_order_tracking/data/response/update_order_stage_response.dart';

abstract class ComprehensiveOrderTrackingDataSource {
  Future<ComprehensiveOrdersResponse> getOrders();
  Future<ComprehensiveOrderDetailResponse> getOrderDetail(String orderId);
  Future<UpdateOrderStageResponse> updateOrderStage(
      UpdateComprehensiveOrderStageRequest request);
  Future<void> updateZoqakOrderStatus(String orderId, String status);
  Future<ZoqakMyOfferByOrderResponse> getZoqakMyOfferByOrderId(String orderId);
}

class ComprehensiveOrderTrackingDataSourceImpl
    implements ComprehensiveOrderTrackingDataSource {
  final AppService _appService;

  ComprehensiveOrderTrackingDataSourceImpl(this._appService);

  @override
  Future<ComprehensiveOrdersResponse> getOrders() async {
    return await _appService.getComprehensiveTailorMyOrders();
  }

  @override
  Future<ComprehensiveOrderDetailResponse> getOrderDetail(
      String orderId) async {
    return await _appService.getComprehensiveTailorOrderDetail(orderId);
  }

  @override
  Future<UpdateOrderStageResponse> updateOrderStage(
      UpdateComprehensiveOrderStageRequest request) async {
    return await _appService.updateComprehensiveTailorOrderStage(
      request.orderId,
      request.stageKey,
    );
  }

  @override
  Future<void> updateZoqakOrderStatus(String orderId, String status) async {
    await _appService.updateComprehensiveTailorZoqakOrderStatus(
      orderId,
      {'status': status},
    );
  }

  @override
  Future<ZoqakMyOfferByOrderResponse> getZoqakMyOfferByOrderId(
      String orderId) async {
    return await _appService
        .getComprehensiveTailorZoqakMyOfferByOrder(orderId);
  }
}
