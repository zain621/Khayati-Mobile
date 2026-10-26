import 'dart:convert';

import 'package:app_mobile/core/network/app_api.dart';
import '../request/provider_register_request.dart';
import '../response/get_categories_response.dart';
import '../response/provider_register_response.dart';

abstract class ProviderRegisterDataSource {
  Future<ProviderRegisterResponse> providerRegister(
      ProviderRegisterRequest request);
  Future<GetCategoriesResponse> getCategories();
}

class ProviderRegisterDataSourceImplement
    implements ProviderRegisterDataSource {
  final AppService _appService;

  ProviderRegisterDataSourceImplement(this._appService);

  @override
  Future<ProviderRegisterResponse> providerRegister(
      ProviderRegisterRequest request) async {
    return await _appService.providerRegister(
      request.role,
      request.businessName,
      request.ownerName,
      request.phone,
      request.city,
      request.latitude,
      request.longitude,
      request.detailedAddress,
      request.yearsOfExperience,
      request.bio,
      request.categoryIds,
      agreementSignerName: request.agreementSignerName,
      agreementSignatureDataUrl: request.agreementSignatureDataUrl,
      agreementVersion: request.agreementVersion,
      agreementPayload: request.agreementPayload == null
          ? null
          : jsonEncode(request.agreementPayload),
      email: request.email,
    );
  }

  @override
  Future<GetCategoriesResponse> getCategories() async {
    return await _appService.getCategories();
  }
}
