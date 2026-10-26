import 'package:app_mobile/core/network/app_api.dart';
import '../response/accept_zoqak_offer_response.dart';
import '../response/order_detail_response.dart';
import '../response/user_orders_response.dart';
import '../response/zoqak_offers_response.dart';

abstract class MyOrdersDataSource {
  Future<UserOrdersResponse> getUserOrders();
  Future<ZoqakOffersResponse> getZoqakOffers(String orderId);
  Future<ZoqakOrderDetailResponse> getZoqakOrderDetail(String orderId);
  Future<UserOrderDetailResponse> getOrderDetail(String orderId);
  Future<AcceptZoqakOfferResponse> acceptZoqakOffer(
    String orderId,
    String offerId,
  );
}

class MyOrdersDataSourceImplement implements MyOrdersDataSource {
  final AppService _appService;

  MyOrdersDataSourceImplement(this._appService);

  @override
  Future<UserOrdersResponse> getUserOrders() => _appService.getUserOrders();

  @override
  Future<ZoqakOffersResponse> getZoqakOffers(String orderId) =>
      _appService.getZoqakOffers(orderId);

  @override
  Future<ZoqakOrderDetailResponse> getZoqakOrderDetail(String orderId) =>
      _appService.getZoqakOrderDetail(orderId);

  @override
  Future<UserOrderDetailResponse> getOrderDetail(String orderId) =>
      _appService.getUserOrderDetail(orderId);

  @override
  Future<AcceptZoqakOfferResponse> acceptZoqakOffer(
    String orderId,
    String offerId,
  ) =>
      _appService.acceptZoqakOffer(orderId, offerId);
}
