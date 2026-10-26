import 'package:app_mobile/core/network/app_api.dart';
import '../response/independent_tailor_home_response.dart';

abstract class IndependentTailorHomeDataSource {
  Future<IndependentTailorHomeDataResponse> fetchHome();
  Future<ChangeIndependentTailorAvailabilityDataResponse> changeAvailability(
      bool isAcceptingOrders);
}

class IndependentTailorHomeDataSourceImplement
    implements IndependentTailorHomeDataSource {
  final AppService _appService;

  IndependentTailorHomeDataSourceImplement(this._appService);

  @override
  Future<IndependentTailorHomeDataResponse> fetchHome() async {
    final response = await _appService.getIndependentTailorHome();
    return response.data!;
  }

  @override
  Future<ChangeIndependentTailorAvailabilityDataResponse> changeAvailability(
      bool isAcceptingOrders) async {
    final response = await _appService.changeIndependentTailorAvailability(
      {'isAcceptingOrders': isAcceptingOrders},
    );
    return response.data!;
  }
}
