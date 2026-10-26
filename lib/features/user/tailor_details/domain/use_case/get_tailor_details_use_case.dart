import 'package:dartz/dartz.dart';
import '../../../../../core/error_handler/failure.dart';
import '../../../../../core/usecase/base_usecase.dart';
import '../../data/repository/tailor_details_repository.dart';
import '../model/tailor_details_model.dart';

class GetTailorDetailsUseCase
    implements BaseUseCase<String, TailorDetailsModel> {
  final TailorDetailsRepository _repository;

  GetTailorDetailsUseCase(this._repository);

  @override
  Future<Either<Failure, TailorDetailsModel>> execute(String tailorId) =>
      _repository.getTailorDetails(tailorId);
}
