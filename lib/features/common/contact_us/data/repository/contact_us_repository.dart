import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../data_source/contact_us_data_source.dart';
import '../mapper/contact_us_mapper.dart';
import '../request/contact_us_request.dart';
import '../../domain/model/contact_us_model.dart';

abstract class ContactUsRepository {
  Future<Either<Failure, ContactUsModel>> contactUs(ContactUsRequest request);
}

class ContactUsRepositoryImplement implements ContactUsRepository {
  final ContactUsDataSource _dataSource;

  ContactUsRepositoryImplement(this._dataSource);

  @override
  Future<Either<Failure, ContactUsModel>> contactUs(
      ContactUsRequest request) async {
    try {
      final response = await _dataSource.contactUs(request);
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
