import 'package:app_mobile/core/network/app_api.dart';
import '../request/contact_us_request.dart';
import '../response/contact_us_response.dart';

abstract class ContactUsDataSource {
  Future<ContactUsResponse> contactUs(ContactUsRequest request);
}

class ContactUsDataSourceImplement implements ContactUsDataSource {
  final AppService _appService;

  ContactUsDataSourceImplement(this._appService);

  @override
  Future<ContactUsResponse> contactUs(ContactUsRequest request) async {
    return await _appService.contactUs(
      request.name,
      request.email,
      request.subject,
      request.message,
    );
  }
}
