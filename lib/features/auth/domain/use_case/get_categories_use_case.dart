import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/provider_register_repository.dart';
import '../model/category_model.dart';

class GetCategoriesUseCase implements BaseGetUseCase<GetCategoriesModel> {
  final ProviderRegisterRepository _repository;

  GetCategoriesUseCase(this._repository);

  @override
  Future<Either<Failure, GetCategoriesModel>> execute() async {
    return await _repository.getCategories();
  }
}
