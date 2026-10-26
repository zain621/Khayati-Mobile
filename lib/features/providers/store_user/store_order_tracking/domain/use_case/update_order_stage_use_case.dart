import 'package:dartz/dartz.dart';
import '../../../../../../core/error_handler/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../../data/repository/shop_owner_orders_repository.dart';
import '../../data/request/update_order_stage_request.dart';

class UpdateOrderStageUseCase
    implements BaseUseCase<UpdateOrderStageRequest, bool> {
  final ShopOwnerOrdersRepository _repository;

  UpdateOrderStageUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> execute(UpdateOrderStageRequest request) {
    return _repository.updateOrderStage(request);
  }
}
