import 'package:app_mobile/core/extensions/extensions.dart';
import '../response/contact_us_response.dart';
import '../../domain/model/contact_us_model.dart';

extension ContactUsMapper on ContactUsResponse {
  ContactUsModel toDomain() {
    return ContactUsModel(
      id: data?.id.onNull() ?? '',
      message: message.onNull(),
    );
  }
}
