import 'package:app_mobile/core/extensions/extensions.dart';
import '../response/provider_register_response.dart';
import '../../domain/model/provider_register_model.dart';

/// Maps ProviderRegisterDataResponse → requestId string.
extension ProviderRegisterDataMapper on ProviderRegisterDataResponse {
  String toDomain() => requestId.onNull();
}

/// Maps ProviderRegisterResponse → ProviderRegisterModel.
extension ProviderRegisterMapper on ProviderRegisterResponse {
  ProviderRegisterModel toDomain() {
    return ProviderRegisterModel(
      status: status.onNull(),
      code: code.onNull(),
      message: message.onNull(),
      requestId: data?.toDomain() ?? '',
    );
  }
}
