import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/cart_repository.dart';
import '../../data/request/apply_coupon_request.dart';
import '../model/cart_model.dart';

class ApplyCouponUseCase implements BaseUseCase<ApplyCouponRequest, CartModel> {
  final CartRepository _repository;

  ApplyCouponUseCase(this._repository);

  @override
  Future<Either<Failure, CartModel>> execute(ApplyCouponRequest request) =>
      _repository.applyCoupon(request);
}
