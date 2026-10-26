import 'package:app_mobile/core/network/app_api.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import '../mapper/provider_profile_mapper.dart';
import '../../domain/model/provider_profile_model.dart';

abstract class ProviderProfileDataSource {
  Future<ProviderProfileModel> fetchProfile();
}

class ProviderProfileDataSourceImplement implements ProviderProfileDataSource {
  final AppService _appService;
  final AppSettingsPrefs _prefs;

  ProviderProfileDataSourceImplement(this._appService, this._prefs);

  @override
  Future<ProviderProfileModel> fetchProfile() async {
    final role = _prefs.getUserRole();
    switch (role) {
      case 'shop_owner':
        return (await _appService.getShopOwnerShop()).toDomain();
      case 'comprehensive_tailor':
        return (await _appService.getComprehensiveTailorProfile()).toDomain();
      case 'independent_tailor':
      default:
        return (await _appService.getIndependentTailorProfile()).toDomain();
    }
  }
}
