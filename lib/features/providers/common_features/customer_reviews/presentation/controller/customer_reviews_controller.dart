import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import '../../../../../../core/error_handler/failure.dart';
import '../../domain/model/customer_review_model.dart';
import '../../domain/use_case/get_reviews_use_case.dart';

class CustomerReviewsController extends GetxController {
  final GetReviewsUseCase _getReviewsUseCase;

  CustomerReviewsController(this._getReviewsUseCase);

  // State
  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList<CustomerReviewModel> reviews = <CustomerReviewModel>[].obs;
  final Rx<ReviewSummaryModel?> summary = Rx<ReviewSummaryModel?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchReviews();
  }

  Future<void> fetchReviews() async {
    isLoading.value = true;
    hasError.value = false;
    errorMessage.value = '';

    final Either<Failure, CustomerReviewsResult> result =
        await _getReviewsUseCase.execute();

    result.fold(
      (Failure failure) {
        hasError.value = true;
        errorMessage.value = failure.message;
      },
      (CustomerReviewsResult data) {
        reviews.value = data.reviews;
        summary.value = data.summary;
      },
    );

    isLoading.value = false;
  }
}
