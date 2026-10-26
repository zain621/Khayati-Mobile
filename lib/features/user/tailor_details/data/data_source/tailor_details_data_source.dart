import 'package:app_mobile/core/network/app_api.dart';
import '../response/tailor_details_response.dart';

abstract class TailorDetailsDataSource {
  Future<TailorDetailsResponse> getTailorDetails(String tailorId);
}

class TailorDetailsDataSourceImplement implements TailorDetailsDataSource {
  final AppService _appService;

  TailorDetailsDataSourceImplement(this._appService);

  @override
  Future<TailorDetailsResponse> getTailorDetails(String tailorId) =>
      _appService.getTailorDetails(tailorId);
}
