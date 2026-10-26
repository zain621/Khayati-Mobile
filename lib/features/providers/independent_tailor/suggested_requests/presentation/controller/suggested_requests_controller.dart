import 'package:get/get.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../../domain/model/suggested_order_model.dart';
import '../../domain/use_case/get_orders_use_case.dart';
import '../../domain/use_case/submit_offer_use_case.dart';

class SuggestedRequestsController extends GetxController {
  final GetOrdersUseCase _getOrdersUseCase;
  final SubmitOfferUseCase _submitOfferUseCase;

  SuggestedRequestsController(
    this._getOrdersUseCase,
    this._submitOfferUseCase,
  );

  // State
  final RxBool isLoading = true.obs;
  final RxBool isSubmitting = false.obs;
  final RxList<SuggestedOrderModel> orders = <SuggestedOrderModel>[].obs;

  /// Holds the last submit error message for inline display in the BottomSheet.
  /// Cleared automatically before each new submit attempt.
  final RxString submitError = ''.obs;

  /// True when the last [fetchOrders] call returned a failure.
  final RxBool hasError = false.obs;

  /// The failure message from the last [fetchOrders] call.
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  /// Fetches the orders list based on the provider's role.
  Future<void> fetchOrders() async {
    isLoading.value = true;
    hasError.value = false;
    errorMessage.value = '';

    final result = await _getOrdersUseCase.execute();

    result.fold(
      (Failure failure) {
        hasError.value = true;
        errorMessage.value = failure.message;
      },
      (List<SuggestedOrderModel> data) {
        orders.value = data;
      },
    );

    isLoading.value = false;
  }

  /// Submits an offer for a given order.
  ///
  /// Returns [true] on success so the caller (BottomSheet) can dismiss itself.
  /// Returns [false] on failure; [submitError] is set so the BottomSheet can
  /// read the message after the future resolves.
  /// NOTE: [isSubmitting] is managed locally by the BottomSheet; the controller
  /// no longer sets it to avoid reactive updates during modal transitions.
  Future<bool> submitOffer({
    required String orderId,
    required double proposedPrice,
    required int executionDays,
    required String details,
  }) async {
    submitError.value = '';

    final result = await _submitOfferUseCase.execute(
      SubmitOfferUseCaseInput(
        orderId: orderId,
        proposedPrice: proposedPrice,
        executionDays: executionDays,
        details: details,
      ),
    );

    bool success = false;
    result.fold(
      (Failure failure) {
        submitError.value = failure.message;
      },
      (_) {
        success = true;
        fetchOrders();
      },
    );
    return success;
  }
}
