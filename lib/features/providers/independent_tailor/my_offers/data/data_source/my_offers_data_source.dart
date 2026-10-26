import 'package:app_mobile/core/network/app_api.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import '../request/update_my_offer_request.dart';
import '../response/get_my_offers_response.dart';
import '../response/update_my_offer_response.dart';
import '../response/order_detail_response.dart';

abstract class MyOffersDataSource {
  Future<GetMyOffersResponse> fetchMyOffers();
  Future<UpdateMyOfferResponse> updateMyOffer(UpdateMyOfferRequest req);
  Future<UpdateMyOfferResponse> deleteMyOffer(String offerId);
  Future<OrderDetailResponse> getOrderDetail(String orderId);
}

class MyOffersDataSourceImplement implements MyOffersDataSource {
  final AppService _appService;
  final AppSettingsPrefs _prefs;

  MyOffersDataSourceImplement(this._appService, this._prefs);

  bool get _isComprehensive => _prefs.getUserRole() == 'comprehensive_tailor';

  @override
  Future<GetMyOffersResponse> fetchMyOffers() async {
    return _isComprehensive
        ? await _appService.getComprehensiveMyOffers()
        : await _appService.getIndependentMyOffers();
  }

  @override
  Future<UpdateMyOfferResponse> updateMyOffer(UpdateMyOfferRequest req) async {
    return _isComprehensive
        ? await _appService.patchComprehensiveMyOffer(
            req.offerId,
            req.proposedPrice,
            req.executionDays,
            req.details,
          )
        : await _appService.patchIndependentMyOffer(
            req.offerId,
            req.proposedPrice,
            req.executionDays,
            req.details,
          );
  }

  @override
  Future<UpdateMyOfferResponse> deleteMyOffer(String offerId) async {
    return _isComprehensive
        ? await _appService.deleteComprehensiveMyOffer(offerId)
        : await _appService.deleteIndependentMyOffer(offerId);
  }

  @override
  Future<OrderDetailResponse> getOrderDetail(String orderId) async {
    return _isComprehensive
        ? await _appService.getComprehensiveOrderDetail(orderId)
        : await _appService.getIndependentOrderDetail(orderId);
  }
}

