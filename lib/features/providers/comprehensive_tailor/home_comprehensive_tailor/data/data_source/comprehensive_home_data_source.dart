import 'package:app_mobile/core/network/app_api.dart';
import '../response/comprehensive_home_response.dart';

abstract class ComprehensiveHomeDataSource {
  Future<ComprehensiveHomeDataResponse> fetchHome();
  Future<ChangeAvailabilityDataResponse> changeAvailability(bool isAcceptingOrders);
}

class ComprehensiveHomeDataSourceImplement implements ComprehensiveHomeDataSource {
  final AppService _appService;

  ComprehensiveHomeDataSourceImplement(this._appService);

  @override
  Future<ComprehensiveHomeDataResponse> fetchHome() async {
    final response = await _appService.getComprehensiveTailorHome();
    return response.data!;
  }

  @override
  Future<ChangeAvailabilityDataResponse> changeAvailability(
      bool isAcceptingOrders) async {
    final response = await _appService.changeComprehensiveTailorAvailability(
      {
        'isAcceptingOrders': isAcceptingOrders,
      },
    );
    return response.data!;
  }
}
