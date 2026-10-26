import 'package:app_mobile/core/extensions/extensions.dart';
import '../response/customer_register_response.dart';
import '../../domain/model/customer_register_model.dart';

/// Maps CustomerRegisterDataResponse → domain's verificationCode string.
extension CustomerRegisterDataMapper on CustomerRegisterDataResponse {
  String toDomain() => code.onNull();
}

/// Maps CustomerRegisterResponse → CustomerRegisterModel.
extension CustomerRegisterMapper on CustomerRegisterResponse {
  CustomerRegisterModel toDomain() {
    return CustomerRegisterModel(
      status: status.onNull(),
      code: code.onNull(),
      message: message.onNull(),
      verificationCode: data?.toDomain() ?? '',
    );
  }
}
