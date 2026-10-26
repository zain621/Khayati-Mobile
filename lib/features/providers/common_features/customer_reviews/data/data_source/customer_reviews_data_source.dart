import 'package:app_mobile/core/network/app_api.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import '../mapper/customer_reviews_mapper.dart';
import '../response/get_independent_reviews_response.dart';
import '../response/get_comprehensive_reviews_response.dart';
import '../response/get_shop_owner_reviews_response.dart';
import '../../domain/model/customer_review_model.dart';

abstract class CustomerReviewsDataSource {
  Future<CustomerReviewsResult> fetchReviews();
}

class CustomerReviewsDataSourceImplement implements CustomerReviewsDataSource {
  final AppService _appService;
  final AppSettingsPrefs _prefs;

  CustomerReviewsDataSourceImplement(this._appService, this._prefs);

  @override
  Future<CustomerReviewsResult> fetchReviews() async {
    final role = _prefs.getUserRole();
    switch (role) {
      case 'shop_owner':
        final GetShopOwnerReviewsResponse resp =
            await _appService.getShopOwnerReviews();
        return resp.toDomain();

      case 'comprehensive_tailor':
        final GetComprehensiveReviewsResponse resp =
            await _appService.getComprehensiveTailorReviews();
        return CustomerReviewsResult(reviews: resp.toDomain());

      case 'independent_tailor':
      default:
        final GetIndependentReviewsResponse resp =
            await _appService.getIndependentTailorReviews();
        return CustomerReviewsResult(reviews: resp.toDomain());
    }
  }
}
