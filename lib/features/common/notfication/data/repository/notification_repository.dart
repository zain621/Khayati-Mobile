import 'package:dartz/dartz.dart';
import '../../../../../core/error_handler/error_handler.dart';
import '../../../../../core/error_handler/failure.dart';
import '../../domain/model/notification_model.dart';
import '../data_source/notification_data_source.dart';
import '../mapper/notification_mapper.dart';

abstract class NotificationRepository {
  Future<Either<Failure, NotificationListModel>> getNotifications(
      int limit, int offset);
  Future<Either<Failure, bool>> markAsRead(String notificationId);
}

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationDataSource _dataSource;

  NotificationRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, NotificationListModel>> getNotifications(
      int limit, int offset) async {
    try {
      final response = await _dataSource.getNotifications(limit, offset);
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, bool>> markAsRead(String notificationId) async {
    try {
      await _dataSource.markAsRead(notificationId);
      return const Right(true);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
