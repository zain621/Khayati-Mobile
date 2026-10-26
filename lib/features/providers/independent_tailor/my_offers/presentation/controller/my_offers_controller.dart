import 'package:get/get.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import '../../data/request/update_my_offer_request.dart';
import '../../domain/model/my_offer_model.dart';
import '../../domain/model/order_detail_model.dart';
import '../../domain/use_case/get_my_offers_use_case.dart';
import '../../domain/use_case/update_my_offer_use_case.dart';
import '../../domain/use_case/delete_my_offer_use_case.dart';
import '../../domain/use_case/get_order_detail_use_case.dart';

class MyOffersController extends GetxController {
  final GetMyOffersUseCase _getMyOffersUseCase;
  final UpdateMyOfferUseCase _updateMyOfferUseCase;
  final DeleteMyOfferUseCase _deleteMyOfferUseCase;
  final GetOrderDetailUseCase _getOrderDetailUseCase;

  MyOffersController(
    this._getMyOffersUseCase,
    this._updateMyOfferUseCase,
    this._deleteMyOfferUseCase,
    this._getOrderDetailUseCase,
  );

  // State
  final RxBool isLoading = true.obs;
  final RxList<MyOfferModel> allOffers = <MyOfferModel>[].obs;
  final RxInt selectedFilterIndex = 0.obs;

  /// ID of the offer currently undergoing an action (edit / delete).
  /// Empty string means no action in progress.
  final RxString actionOfferId = ''.obs;

  /// Order detail loaded for the detail screen.
  final Rx<OrderDetailModel?> orderDetail = Rx<OrderDetailModel?>(null);
  final RxBool isDetailLoading = false.obs;

  List<MyOfferModel> get filteredOffers {
    switch (selectedFilterIndex.value) {
      case 1:
        return allOffers
            .where((o) => o.myOffer.status == OfferStatus.underReview)
            .toList();
      case 2:
        return allOffers
            .where((o) => o.myOffer.status == OfferStatus.accepted)
            .toList();
      case 3:
        return allOffers
            .where((o) => o.myOffer.status == OfferStatus.rejected)
            .toList();
      default:
        return allOffers.toList();
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchMyOffers();
  }

  Future<void> fetchMyOffers() async {
    isLoading.value = true;

    final result = await _getMyOffersUseCase.execute();

    result.fold(
      (Failure failure) {
        AppSnackbar.error(failure.message);
      },
      (List<MyOfferModel> data) {
        allOffers.value = data;
      },
    );

    isLoading.value = false;
  }

  /// Edit an offer — returns true on success.
  Future<bool> updateOffer({
    required String offerId,
    required double proposedPrice,
    required int executionDays,
    required String details,
  }) async {
    actionOfferId.value = offerId;

    final result = await _updateMyOfferUseCase.execute(
      UpdateMyOfferRequest(
        offerId: offerId,
        proposedPrice: proposedPrice,
        executionDays: executionDays,
        details: details,
      ),
    );

    actionOfferId.value = '';

    return result.fold(
      (Failure failure) {
        AppSnackbar.error(failure.message);
        return false;
      },
      (MyOfferModel updated) {
        final idx = allOffers.indexWhere((o) => o.myOffer.id == offerId);
        if (idx != -1) {
          allOffers[idx] = updated;
          allOffers.refresh();
        }
        return true;
      },
    );
  }

  /// Delete / withdraw an offer.
  Future<bool> deleteOffer(String offerId) async {
    actionOfferId.value = offerId;

    final result = await _deleteMyOfferUseCase.execute(offerId);

    actionOfferId.value = '';

    return result.fold(
      (Failure failure) {
        AppSnackbar.error(failure.message);
        return false;
      },
      (_) {
        allOffers.removeWhere((o) => o.myOffer.id == offerId);
        return true;
      },
    );
  }

  /// Load order detail for the detail screen.
  Future<OrderDetailModel?> fetchOrderDetail(String orderId) async {
    isDetailLoading.value = true;
    orderDetail.value = null;

    final result = await _getOrderDetailUseCase.execute(orderId);

    isDetailLoading.value = false;

    return result.fold(
      (Failure failure) {
        AppSnackbar.error(failure.message);
        return null;
      },
      (OrderDetailModel detail) {
        orderDetail.value = detail;
        return detail;
      },
    );
  }
}

