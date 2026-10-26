import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/cart_repository.dart';
import '../model/cart_model.dart';

class RemoveCartItemUseCase implements BaseUseCase<String, CartModel> {
  final CartRepository _repository;

  RemoveCartItemUseCase(this._repository);

  @override
  Future<Either<Failure, CartModel>> execute(String cartItemId) =>
      _repository.removeCartItem(cartItemId);
}
