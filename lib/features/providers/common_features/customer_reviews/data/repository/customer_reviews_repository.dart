import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/internet_checker/interent_checker.dart';
import '../data_source/customer_reviews_data_source.dart';
import '../../domain/model/customer_review_model.dart';

abstract class CustomerReviewsRepository {
  Future<Either<Failure, CustomerReviewsResult>> fetchReviews();
}

class CustomerReviewsRepositoryImplement implements CustomerReviewsRepository {
  final CustomerReviewsDataSource _dataSource;
  // ignore: unused_field
  final NetworkInfo _networkInfo;

  CustomerReviewsRepositoryImplement(this._networkInfo, this._dataSource);

  @override
  Future<Either<Failure, CustomerReviewsResult>> fetchReviews() async {
    try {
      final result = await _dataSource.fetchReviews();
      return Right(result);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
