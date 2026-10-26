import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../model/customer_review_model.dart';
import '../../data/repository/customer_reviews_repository.dart';

class GetReviewsUseCase implements BaseGetUseCase<CustomerReviewsResult> {
  final CustomerReviewsRepository _repository;

  GetReviewsUseCase(this._repository);

  @override
  Future<Either<Failure, CustomerReviewsResult>> execute() async {
    return await _repository.fetchReviews();
  }
}
