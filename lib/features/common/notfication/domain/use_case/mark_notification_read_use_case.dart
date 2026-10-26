import 'package:dartz/dartz.dart';
import '../../../../../core/error_handler/failure.dart';
import '../../../../../core/usecase/base_usecase.dart';
import '../../data/repository/notification_repository.dart';

class MarkNotificationReadUseCase implements BaseUseCase<String, bool> {
  final NotificationRepository _repository;

  MarkNotificationReadUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> execute(String input) {
    return _repository.markAsRead(input);
  }
}
