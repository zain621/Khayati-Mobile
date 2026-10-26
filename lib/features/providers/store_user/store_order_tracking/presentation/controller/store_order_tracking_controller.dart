import 'package:get/get.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import 'package:app_mobile/features/providers/common_features/chat/data/request/create_conversation_request.dart';
import 'package:app_mobile/features/providers/common_features/chat/domain/use_case/create_conversation_use_case.dart';
import '../../data/request/update_order_stage_request.dart';
import '../../domain/model/shop_owner_order_model.dart';
import '../../domain/use_case/get_shop_owner_orders_use_case.dart';
import '../../domain/use_case/update_order_stage_use_case.dart';

class StoreOrderTrackingController extends GetxController {
  final GetShopOwnerOrdersUseCase _getOrdersUseCase;
  final UpdateOrderStageUseCase _updateStageUseCase;
  final CreateConversationUseCase _createConversationUseCase;

  StoreOrderTrackingController(
    this._getOrdersUseCase,
    this._updateStageUseCase,
    this._createConversationUseCase,
  );

  // ── State ──────────────────────────────────────────────────────────────────

  final RxList<ShopOwnerOrderModel> _allOrders =
      <ShopOwnerOrderModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool isUpdatingStage = false.obs;
  final RxInt selectedFilterIndex = 0.obs;

  List<ShopOwnerOrderModel> get allOrders => _allOrders;

  List<ShopOwnerOrderModel> get filteredOrders {
    switch (selectedFilterIndex.value) {
      case 1:
        return _allOrders
            .where((o) => o.currentStage == ShopOrderCurrentStage.newOrder)
            .toList();
      case 2:
        return _allOrders
            .where((o) =>
                o.currentStage == ShopOrderCurrentStage.inPreparation)
            .toList();
      case 3:
        return _allOrders
            .where((o) =>
                o.currentStage == ShopOrderCurrentStage.readyToShip ||
                o.currentStage == ShopOrderCurrentStage.shipped ||
                o.currentStage == ShopOrderCurrentStage.inDelivery)
            .toList();
      default:
        return _allOrders.toList();
    }
  }

  int get newOrdersCount => _allOrders
      .where((o) => o.currentStage == ShopOrderCurrentStage.newOrder)
      .length;

  int get inPrepCount => _allOrders
      .where((o) => o.currentStage == ShopOrderCurrentStage.inPreparation)
      .length;

  int get readyCount => _allOrders
      .where((o) =>
          o.currentStage == ShopOrderCurrentStage.readyToShip ||
          o.currentStage == ShopOrderCurrentStage.shipped ||
          o.currentStage == ShopOrderCurrentStage.inDelivery)
      .length;

  // ── Lifecycle ──────────────────────────────────────────────────────────────

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  // ── Actions ────────────────────────────────────────────────────────────────

  void selectFilter(int index) {
    selectedFilterIndex.value = index;
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
        _allOrders.assignAll(orders);
        isLoading.value = false;
      },
    );
  }

  Future<void> refreshOrders() async {
    final result = await _getOrdersUseCase.execute();
    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (orders) => _allOrders.assignAll(orders),
    );
  }

  Future<void> updateOrderStage({
    required String orderId,
    required String stageKey,
  }) async {
    isUpdatingStage.value = true;
    final result = await _updateStageUseCase.execute(
      UpdateOrderStageRequest(orderId: orderId, stageKey: stageKey),
    );
    result.fold(
      (failure) {
        isUpdatingStage.value = false;
        AppSnackbar.error(failure.message);
      },
      (_) {
        isUpdatingStage.value = false;
        AppSnackbar.success(
          ManagerStrings.storeOrderStageUpdatedSuccess,
          englishMessage: ManagerStrings.storeOrderStageUpdatedSuccessEn,
        );
        fetchOrders();
      },
    );
  }

  /// Open (or create) a chat with the buyer of this shop order.
  Future<void> navigateToChat({
    required String buyerId,
    required String buyerName,
    String? avatarUrl,
  }) async {
    if (buyerId.isEmpty) {
      Get.toNamed(Routes.conversationsScreen);
      return;
    }
    final result = await _createConversationUseCase.execute(
      CreateConversationRequest(
        tailorId: instance<AppSettingsPrefs>().getUserId(),
        userId: buyerId,
      ),
    );
    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (conversation) {
        Get.toNamed(
          Routes.chatDetailScreen,
          arguments: {
            'conversationId': conversation.id,
            'userName': buyerName,
            'avatarUrl': avatarUrl,
            'isOnline': false,
          },
        );
      },
    );
  }
}
