import '../../../../../../core/network/app_api.dart';
import '../request/update_order_stage_request.dart';
import '../response/get_shop_owner_orders_response.dart';
import '../response/update_order_stage_response.dart';

abstract class ShopOwnerOrdersDataSource {
  Future<GetShopOwnerOrdersResponse> getOrders();
  Future<UpdateOrderStageResponse> updateOrderStage(
      UpdateOrderStageRequest request);
}

class ShopOwnerOrdersDataSourceImpl implements ShopOwnerOrdersDataSource {
  final AppService _appService;

  ShopOwnerOrdersDataSourceImpl(this._appService);

  @override
  Future<GetShopOwnerOrdersResponse> getOrders() async {
    return await _appService.getShopOwnerOrdersList();
  }

  @override
  Future<UpdateOrderStageResponse> updateOrderStage(
      UpdateOrderStageRequest request) async {
    return await _appService.updateShopOwnerOrderStage(
      request.orderId,
      request.stageKey,
    );
  }
}
