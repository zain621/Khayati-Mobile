import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/my_offers_repository.dart';
import '../model/order_detail_model.dart';

class GetOrderDetailUseCase implements BaseUseCase<String, OrderDetailModel> {
  final MyOffersRepository _repository;

  GetOrderDetailUseCase(this._repository);

  @override
  Future<Either<Failure, OrderDetailModel>> execute(String orderId) async {
    return await _repository.getOrderDetail(orderId);
  }
}
