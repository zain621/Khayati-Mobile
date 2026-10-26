import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/contact_us_repository.dart';
import '../../data/request/contact_us_request.dart';
import '../model/contact_us_model.dart';

class ContactUsUseCase implements BaseUseCase<ContactUsRequest, ContactUsModel> {
  final ContactUsRepository _repository;

  ContactUsUseCase(this._repository);

  @override
  Future<Either<Failure, ContactUsModel>> execute(
      ContactUsRequest request) async {
    return await _repository.contactUs(request);
  }
}
