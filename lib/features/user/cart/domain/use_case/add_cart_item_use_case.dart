import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/cart_repository.dart';
import '../../data/request/add_cart_item_request.dart';
import '../model/cart_model.dart';

class AddCartItemUseCase implements BaseUseCase<AddCartItemRequest, CartModel> {
  final CartRepository _repository;

  AddCartItemUseCase(this._repository);

  @override
  Future<Either<Failure, CartModel>> execute(AddCartItemRequest request) =>
      _repository.addCartItem(request);
}
