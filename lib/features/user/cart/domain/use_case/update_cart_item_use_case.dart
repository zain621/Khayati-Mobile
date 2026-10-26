import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/cart_repository.dart';
import '../../data/request/update_cart_item_request.dart';
import '../model/cart_model.dart';

class UpdateCartItemUseCase
    implements BaseUseCase<UpdateCartItemRequest, CartModel> {
  final CartRepository _repository;

  UpdateCartItemUseCase(this._repository);

  @override
  Future<Either<Failure, CartModel>> execute(UpdateCartItemRequest request) =>
      _repository.updateCartItem(request);
}
