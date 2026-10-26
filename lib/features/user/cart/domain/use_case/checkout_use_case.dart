import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/cart_repository.dart';
import '../model/checkout_model.dart';

class CheckoutUseCase implements BaseGetUseCase<CheckoutModel> {
  final CartRepository _repository;

  CheckoutUseCase(this._repository);

  @override
  Future<Either<Failure, CheckoutModel>> execute() => _repository.checkout();
}
