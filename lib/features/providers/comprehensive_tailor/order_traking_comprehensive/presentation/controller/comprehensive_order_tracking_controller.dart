import 'package:get/get.dart';
import '../../../../../../core/resources/manager_strings.dart';
import '../../../../../../core/routes/routes.dart';
import '../../../../../../core/util/app_snack_bar.dart';
import '../../data/request/update_comprehensive_order_stage_request.dart';
import '../../domain/model/comprehensive_order_tracking_model.dart';
import '../../domain/use_case/get_comprehensive_orders_use_case.dart';
import '../../domain/use_case/get_comprehensive_order_detail_use_case.dart';
import '../../domain/use_case/update_comprehensive_order_stage_use_case.dart';
import '../../domain/use_case/update_comprehensive_zoqak_status_use_case.dart';
import '../../domain/use_case/get_zoqak_my_offer_by_order_use_case.dart';
import '../../../../../providers/common_features/chat/domain/use_case/create_conversation_use_case.dart';
import '../../../../../providers/common_features/chat/data/request/create_conversation_request.dart';
import '../../../../../../core/storage/local/app_settings_prefs.dart';
import '../../../../../../constants/di/dependency_injection.dart';

class ComprehensiveOrderTrackingController extends GetxController {
  final GetComprehensiveOrdersUseCase _getOrdersUseCase;
  final GetComprehensiveOrderDetailUseCase _getDetailUseCase;
  final UpdateComprehensiveOrderStageUseCase _updateStageUseCase;
  final UpdateComprehensiveZoqakStatusUseCase _updateZoqakStatusUseCase;
  final GetZoqakMyOfferByOrderUseCase _getZoqakOfferByOrderUseCase;
  final CreateConversationUseCase _createConversationUseCase;

  ComprehensiveOrderTrackingController(
    this._getOrdersUseCase,
    this._getDetailUseCase,
    this._updateStageUseCase,
    this._updateZoqakStatusUseCase,
    this._getZoqakOfferByOrderUseCase,
    this._createConversationUseCase,
  );

  // ── State ──────────────────────────────────────────────────────────────────

  final RxList<ComprehensiveShopOrderModel> _shopOrders =
      <ComprehensiveShopOrderModel>[].obs;
  final RxList<ComprehensiveZoqakOrderModel> _zoqakOrders =
      <ComprehensiveZoqakOrderModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool isUpdatingStage = false.obs;
  final RxBool isUpdatingZoqakStatus = false.obs;
  final RxBool isLoadingDetails = false.obs;
  final RxBool isLoadingOfferDetail = false.obs;
  final RxInt selectedShopFilterIndex = 0.obs;
  final RxInt selectedZoqakFilterIndex = 0.obs;

  List<ComprehensiveShopOrderModel> get shopOrders => _shopOrders;
  List<ComprehensiveZoqakOrderModel> get zoqakOrders => _zoqakOrders;

  List<ComprehensiveZoqakOrderModel> get filteredZoqakOrders {
    switch (selectedZoqakFilterIndex.value) {
      case 1:
        return _zoqakOrders
            .where((o) => o.status == ComprehensiveZoqakStatus.pending)
            .toList();
      case 2:
        return _zoqakOrders
            .where((o) => o.status == ComprehensiveZoqakStatus.accepted)
            .toList();
      case 3:
        return _zoqakOrders
            .where((o) => o.status == ComprehensiveZoqakStatus.completed)
            .toList();
      case 4:
        return _zoqakOrders
            .where((o) => o.status == ComprehensiveZoqakStatus.cancelled)
            .toList();
      default:
        return _zoqakOrders.toList();
    }
  }

  List<ComprehensiveShopOrderModel> get filteredShopOrders {
    switch (selectedShopFilterIndex.value) {
      case 1:
        return _shopOrders
            .where(
                (o) => o.currentStage == ComprehensiveShopOrderStage.newOrder)
            .toList();
      case 2:
        return _shopOrders
            .where((o) =>
                o.currentStage == ComprehensiveShopOrderStage.inPreparation)
            .toList();
      case 3:
        return _shopOrders
            .where((o) =>
                o.currentStage == ComprehensiveShopOrderStage.readyToShip ||
                o.currentStage == ComprehensiveShopOrderStage.shipped ||
                o.currentStage == ComprehensiveShopOrderStage.inDelivery)
            .toList();
      default:
        return _shopOrders.toList();
    }
  }

  int get shopNewOrdersCount => _shopOrders
      .where((o) => o.currentStage == ComprehensiveShopOrderStage.newOrder)
      .length;

  int get shopInPrepCount => _shopOrders
      .where((o) => o.currentStage == ComprehensiveShopOrderStage.inPreparation)
      .length;

  int get shopReadyCount => _shopOrders
      .where((o) =>
          o.currentStage == ComprehensiveShopOrderStage.readyToShip ||
          o.currentStage == ComprehensiveShopOrderStage.shipped ||
          o.currentStage == ComprehensiveShopOrderStage.inDelivery)
      .length;

  int get zoqakPendingCount => _zoqakOrders
      .where((o) => o.status == ComprehensiveZoqakStatus.pending)
      .length;

  int get zoqakAcceptedCount => _zoqakOrders
      .where((o) => o.status == ComprehensiveZoqakStatus.accepted)
      .length;

  int get zoqakCompletedCount => _zoqakOrders
      .where((o) => o.status == ComprehensiveZoqakStatus.completed)
      .length;

  int get zoqakCancelledCount => _zoqakOrders
      .where((o) => o.status == ComprehensiveZoqakStatus.cancelled)
      .length;

  // ── Lifecycle ──────────────────────────────────────────────────────────────

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  // ── Actions ────────────────────────────────────────────────────────────────

  void selectShopFilter(int index) {
    selectedShopFilterIndex.value = index;
  }

  void selectZoqakFilter(int index) {
    selectedZoqakFilterIndex.value = index;
  }

  Future<void> fetchOrders() async {
    isLoading.value = true;
    final result = await _getOrdersUseCase.execute();
    result.fold(
      (failure) {
        isLoading.value = false;
        AppSnackbar.error(failure.message);
      },
      (orders) {
        _shopOrders.assignAll(orders.shopOrders);
        _zoqakOrders.assignAll(orders.zoqakOrders);
        isLoading.value = false;
      },
    );
  }

  Future<void> refreshOrders() async {
    final result = await _getOrdersUseCase.execute();
    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (orders) {
        _shopOrders.assignAll(orders.shopOrders);
        _zoqakOrders.assignAll(orders.zoqakOrders);
      },
    );
  }

  Future<ComprehensiveOrderDetailModel?> fetchOrderDetail(
      String orderId) async {
    isLoadingDetails.value = true;
    final result = await _getDetailUseCase.execute(orderId);
    isLoadingDetails.value = false;
    return result.fold(
      (failure) {
        AppSnackbar.error(failure.message);
        return null;
      },
      (detail) => detail,
    );
  }

  Future<void> updateOrderStage({
    required String orderId,
    required String stageKey,
  }) async {
    isUpdatingStage.value = true;
    final result = await _updateStageUseCase.execute(
      UpdateComprehensiveOrderStageRequest(
          orderId: orderId, stageKey: stageKey),
    );
    result.fold(
      (failure) {
        isUpdatingStage.value = false;
        AppSnackbar.error(failure.message);
      },
      (_) {
        isUpdatingStage.value = false;
        AppSnackbar.success(
          ManagerStrings.ctOrderStageUpdatedSuccess,
          englishMessage: ManagerStrings.ctOrderStageUpdatedSuccessEn,
        );
        fetchOrders();
      },
    );
  }

  Future<void> updateZoqakOrderStatus({
    required String orderId,
    required String newStatus,
  }) async {
    isUpdatingZoqakStatus.value = true;
    final result = await _updateZoqakStatusUseCase.execute(orderId, newStatus);
    result.fold(
      (failure) {
        isUpdatingZoqakStatus.value = false;
        AppSnackbar.error(failure.message);
      },
      (_) {
        isUpdatingZoqakStatus.value = false;
        AppSnackbar.success(
          ManagerStrings.ctOrderStageUpdatedSuccess,
          englishMessage: ManagerStrings.ctOrderStageUpdatedSuccessEn,
        );
        fetchOrders();
      },
    );
  }

  Future<ZoqakOfferDetailModel?> fetchZoqakOfferByOrderId(
      String orderId) async {
    isLoadingOfferDetail.value = true;
    final result = await _getZoqakOfferByOrderUseCase.execute(orderId);
    isLoadingOfferDetail.value = false;
    return result.fold(
      (failure) {
        AppSnackbar.error(failure.message);
        return null;
      },
      (detail) => detail,
    );
  }

  /// Opens a direct chat with the given user.
  /// Returns true if navigation succeeded, false otherwise.
  Future<bool> navigateToChat({
    required String userId,
    required String userName,
    String? avatarUrl,
  }) async {
    if (userId.isEmpty) {
      Get.toNamed(Routes.conversationsScreen);
      return true;
    }
    isLoadingOfferDetail.value = true;
    final result = await _createConversationUseCase.execute(
      CreateConversationRequest(
        tailorId: instance<AppSettingsPrefs>().getUserId(),
        userId: userId,
      ),
    );
    isLoadingOfferDetail.value = false;
    return result.fold(
      (failure) {
        AppSnackbar.error(failure.message);
        return false;
      },
      (conversation) {
        Get.toNamed(
          Routes.chatDetailScreen,
          arguments: {
            'conversationId': conversation.id,
            'userName': userName,
            'avatarUrl': avatarUrl,
            'isOnline': false,
          },
        );
        return true;
      },
    );
  }
}
