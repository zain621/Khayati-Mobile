import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import '../../data/request/update_order_status_request.dart';
import '../../domain/model/order_tracking_model.dart';
import '../../domain/use_case/get_order_tracking_detail_use_case.dart';
import '../../domain/use_case/get_order_tracking_use_case.dart';
import '../../domain/use_case/update_order_tracking_status_use_case.dart';

class OrderTrackingController extends GetxController {
  final GetOrderTrackingUseCase _getOrderTrackingUseCase;
  final GetOrderTrackingDetailUseCase _getOrderTrackingDetailUseCase;
  final UpdateOrderTrackingStatusUseCase _updateOrderTrackingStatusUseCase;

  OrderTrackingController(
    this._getOrderTrackingUseCase,
    this._getOrderTrackingDetailUseCase,
    this._updateOrderTrackingStatusUseCase,
  );

  final RxBool isFirstLoad = true.obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingDetails = false.obs;
  final RxBool isUpdatingStatus = false.obs;

  final RxInt selectedFilterIndex = 0.obs;
  final Rxn<OrderTrackingDataModel> trackingData = Rxn<OrderTrackingDataModel>();

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    isLoading.value = true;

    final Either<Failure, OrderTrackingDataModel> result =
        await _getOrderTrackingUseCase.execute();

    result.fold(
      (failure) {
        isFirstLoad.value = false;
        AppSnackbar.error(failure.message);
      },
      (data) {
        trackingData.value = data;
        isFirstLoad.value = false;
      },
    );

    isLoading.value = false;
  }

  Future<void> refreshOrders() async {
    isLoading.value = true;

    final Either<Failure, OrderTrackingDataModel> result =
        await _getOrderTrackingUseCase.execute();

    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (data) => trackingData.value = data,
    );

    isLoading.value = false;
  }

  void changeFilter(int index) {
    selectedFilterIndex.value = index;
  }

  Future<void> updateOrderStatus(OrderTrackingItemModel order) async {
    final String? nextStatus = _nextStatusApi(order.status);
    if (nextStatus == null) {
      return;
    }

    isUpdatingStatus.value = true;

    final result = await _updateOrderTrackingStatusUseCase.execute(
      UpdateOrderStatusRequest(orderId: order.orderId, status: nextStatus),
    );

    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (_) async {
        AppSnackbar.success(
          ManagerStrings.orderTrackingUpdateSuccess,
          englishMessage: ManagerStrings.orderTrackingUpdateSuccessEn,
        );
        await refreshOrders();
      },
    );

    isUpdatingStatus.value = false;
  }

  Future<OrderTrackingDetailModel?> fetchOrderDetail(String orderId) async {
    isLoadingDetails.value = true;
    final result = await _getOrderTrackingDetailUseCase.execute(orderId);

    OrderTrackingDetailModel? detail;
    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (data) => detail = data,
    );

    isLoadingDetails.value = false;
    return detail;
  }

  List<OrderTrackingItemModel> get filteredOrders {
    final items = trackingData.value?.items ?? <OrderTrackingItemModel>[];
    switch (selectedFilterIndex.value) {
      case 1:
        return items.where((o) => o.status == OrderTrackingStatus.accepted).toList();
      case 2:
        return items.where((o) => o.status == OrderTrackingStatus.inProgress).toList();
      case 3:
        return items.where((o) => o.status == OrderTrackingStatus.ready).toList();
      case 4:
        return items.where((o) => o.status == OrderTrackingStatus.readyForDelivery).toList();
      case 5:
        return items.where((o) => o.status == OrderTrackingStatus.completed).toList();
      default:
        return items;
    }
  }

  String getDisplayDate(String isoDate) {
    if (isoDate.isEmpty) return '-';
    try {
      final dt = DateTime.parse(isoDate).toLocal();
      return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
    } catch (_) {
      return isoDate;
    }
  }

  String statusText(OrderTrackingStatus status) {
    switch (status) {
      case OrderTrackingStatus.accepted:
        return ManagerStrings.orderTrackingStatusAccepted;
      case OrderTrackingStatus.inProgress:
        return ManagerStrings.orderTrackingStatusInProgress;
      case OrderTrackingStatus.ready:
        return ManagerStrings.orderTrackingStatusReady;
      case OrderTrackingStatus.readyForDelivery:
        return ManagerStrings.orderTrackingStatusReadyForDelivery;
      case OrderTrackingStatus.completed:
        return ManagerStrings.orderTrackingStatusCompleted;
      case OrderTrackingStatus.unknown:
        return ManagerStrings.orderTrackingFilterAll;
    }
  }

  String? nextActionLabel(OrderTrackingStatus status) {
    switch (status) {
      case OrderTrackingStatus.accepted:
        return ManagerStrings.orderTrackingStartExecution;
      case OrderTrackingStatus.inProgress:
        return ManagerStrings.orderTrackingActionMarkReady;
      case OrderTrackingStatus.ready:
        return ManagerStrings.orderTrackingUpdateReadyForDelivery;
      case OrderTrackingStatus.readyForDelivery:
        return ManagerStrings.orderTrackingUpdateInDelivery;
      case OrderTrackingStatus.completed:
      case OrderTrackingStatus.unknown:
        return null;
    }
  }

  String? _nextStatusApi(OrderTrackingStatus status) {
    switch (status) {
      case OrderTrackingStatus.accepted:
        return 'in_progress';
      case OrderTrackingStatus.inProgress:
        return 'ready';
      case OrderTrackingStatus.ready:
        return 'ready_for_delivery';
      case OrderTrackingStatus.readyForDelivery:
        return 'completed';
      case OrderTrackingStatus.completed:
      case OrderTrackingStatus.unknown:
        return null;
    }
  }
}
