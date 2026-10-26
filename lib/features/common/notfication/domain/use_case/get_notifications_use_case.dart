import 'package:dartz/dartz.dart';
import '../../../../../core/error_handler/failure.dart';
import '../../../../../core/usecase/base_usecase.dart';
import '../../data/repository/notification_repository.dart';
import '../model/notification_model.dart';

class GetNotificationsParams {
  final int limit;
  final int offset;

  const GetNotificationsParams({required this.limit, required this.offset});
}

class GetNotificationsUseCase
    implements BaseUseCase<GetNotificationsParams, NotificationListModel> {
  final NotificationRepository _repository;

  GetNotificationsUseCase(this._repository);

  @override
  Future<Either<Failure, NotificationListModel>> execute(
      GetNotificationsParams input) {
    return _repository.getNotifications(input.limit, input.offset);
  }
}
