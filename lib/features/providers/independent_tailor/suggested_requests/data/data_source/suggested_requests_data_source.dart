import 'package:app_mobile/core/network/app_api.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import '../response/get_ct_orders_response.dart';
import '../response/get_orders_response.dart';
import '../response/submit_offer_response.dart';

abstract class SuggestedRequestsDataSource {
  Future<GetOrdersResponse> fetchOrders();
  Future<SubmitOfferResponse> submitOffer({
    required String orderId,
    required double proposedPrice,
    required int executionDays,
    required String details,
  });
}

class SuggestedRequestsDataSourceImplement
    implements SuggestedRequestsDataSource {
  final AppService _appService;
  final AppSettingsPrefs _prefs;

  SuggestedRequestsDataSourceImplement(this._appService, this._prefs);

  @override
  Future<GetOrdersResponse> fetchOrders() async {
    final role = _prefs.getUserRole();
    switch (role) {
      case 'shop_owner':
        return await _appService.getShopOwnerOrders();
      case 'comprehensive_tailor':
        final GetCTOrdersResponse ctResp =
            await _appService.getComprehensiveTailorOrders();
        return GetOrdersResponse(
          status: ctResp.status,
          code: ctResp.code,
          message: ctResp.message,
          data: ctResp.data?.zoqakOrders ?? <OrderDataResponse>[],
        );
      case 'independent_tailor':
      default:
        return await _appService.getIndependentTailorOrders();
    }
  }

  @override
  Future<SubmitOfferResponse> submitOffer({
    required String orderId,
    required double proposedPrice,
    required int executionDays,
    required String details,
  }) async {
    final role = _prefs.getUserRole();
    if (role == 'comprehensive_tailor') {
      return await _appService.submitComprehensiveTailorOffer(
        orderId,
        proposedPrice,
        executionDays,
        details,
      );
    }
    return await _appService.submitOffer(
      orderId,
      proposedPrice,
      executionDays,
      details,
    );
  }
}
