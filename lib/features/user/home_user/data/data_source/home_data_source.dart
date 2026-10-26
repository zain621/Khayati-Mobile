import 'package:app_mobile/core/network/app_api.dart';
import '../response/home_response.dart';
import '../response/nearby_tailors_response.dart';

abstract class HomeDataSource {
  Future<HomeResponse> getHome();
  Future<NearbyTailorsResponse> getNearbyTailors(
    double latitude,
    double longitude,
    int limit,
  );
}

class HomeDataSourceImplement implements HomeDataSource {
  final AppService _appService;

  HomeDataSourceImplement(this._appService);

  @override
  Future<HomeResponse> getHome() => _appService.getHome();

  @override
  Future<NearbyTailorsResponse> getNearbyTailors(
    double latitude,
    double longitude,
    int limit,
  ) =>
      _appService.getNearbyTailors(latitude, longitude, limit);
}
