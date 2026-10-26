import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/features/providers/common_features/chat/data/request/create_conversation_request.dart';
import 'package:app_mobile/features/providers/common_features/chat/domain/di/di.dart'
    as chat_di;
import 'package:app_mobile/features/providers/common_features/chat/domain/use_case/create_conversation_use_case.dart';
import '../../domain/model/order_details_model.dart';
import '../../domain/model/user_order_domain_model.dart';
import '../../domain/use_case/get_order_detail_use_case.dart';

// ─────────────────────────────────────────────────────────────────────────────
// OrderDetailsController
//
// Dedicated controller for the Order Details screen.
// Fetches a single order from GET /user/orders/:orderId and exposes the
// domain model directly — no coupling to the orders list controller.
// ─────────────────────────────────────────────────────────────────────────────

class OrderDetailsController extends GetxController {
  final GetOrderDetailUseCase _getOrderDetailUseCase;

  OrderDetailsController(this._getOrderDetailUseCase);

  // ── Reactive state ─────────────────────────────────────────────────────────

  final Rx<UserOrderDomainModel?> order = Rx(null);
  final RxBool isLoading = false.obs;
  final RxBool isChatLoading = false.obs;
  final RxString errorMessage = ''.obs;

  String _orderId = '';

  // ── Public API ─────────────────────────────────────────────────────────────

  /// Must be called once with the orderId before [onInit] dependencies resolve.
  void init(String orderId) {
    _orderId = orderId;
    chat_di.initUserChat();
    fetchOrder();
  }

  Future<void> fetchOrder() async {
    if (_orderId.isEmpty) return;
    isLoading.value = true;
    errorMessage.value = '';

    final result = await _getOrderDetailUseCase.execute(_orderId);
    result.fold(
      (failure) {
        errorMessage.value = failure.message;
        isLoading.value = false;
      },
      (detail) {
        order.value = detail;
        isLoading.value = false;
      },
    );
  }

  Future<void> refresh() => fetchOrder();

  /// Start chat with the shop (shopId resolves to owner on backend).
  Future<void> startChatWithShop() async {
    final detail = order.value;
    final shopId = detail?.shopId?.trim() ?? '';
    if (shopId.isEmpty) {
      AppSnackbar.error(ManagerStrings.genericErrorRetry);
      return;
    }
    isChatLoading.value = true;
    try {
      final useCase = instance<CreateConversationUseCase>();
      final prefs = instance<AppSettingsPrefs>();
      final result = await useCase.execute(
        CreateConversationRequest(
          tailorId: shopId,
          userId: prefs.getUserId(),
        ),
      );
      result.fold(
        (Failure failure) => AppSnackbar.error(failure.message),
        (conversation) => Get.toNamed(
          Routes.userChatDetailScreen,
          arguments: {
            'conversationId': conversation.id,
            'userName': detail?.shopName ?? 'Shop',
            'avatarUrl': '',
            'isOnline': false,
          },
        ),
      );
    } finally {
      isChatLoading.value = false;
    }
  }

  /// Start chat with accepted Zoqak tailor.
  Future<void> startChatWithTailor() async {
    final detail = order.value;
    final tailorId = detail?.acceptedByProviderId?.trim() ?? '';
    if (tailorId.isEmpty) {
      AppSnackbar.error(ManagerStrings.genericErrorRetry);
      return;
    }
    isChatLoading.value = true;
    try {
      final useCase = instance<CreateConversationUseCase>();
      final prefs = instance<AppSettingsPrefs>();
      final result = await useCase.execute(
        CreateConversationRequest(
          tailorId: tailorId,
          userId: prefs.getUserId(),
        ),
      );
      result.fold(
        (Failure failure) => AppSnackbar.error(failure.message),
        (conversation) => Get.toNamed(
          Routes.userChatDetailScreen,
          arguments: {
            'conversationId': conversation.id,
            'userName': detail?.acceptedByProviderName ?? 'Tailor',
            'avatarUrl': '',
            'isOnline': false,
          },
        ),
      );
    } finally {
      isChatLoading.value = false;
    }
  }

  // ── Computed: tracking steps (for the tracking tab widget) ────────────────

  /// Maps the domain stages to UI-ready [OrderTrackingStep] objects.
  List<OrderTrackingStep> get trackingSteps {
    final d = order.value;
    if (d == null) return [];

    bool foundCurrent = false;
    return d.stages.map((s) {
      final OrderTrackingStepState state;
      if (s.completed) {
        state = OrderTrackingStepState.completed;
      } else if (!foundCurrent) {
        foundCurrent = true;
        state = OrderTrackingStepState.current;
      } else {
        state = OrderTrackingStepState.pending;
      }

      return OrderTrackingStep(
        title: s.label,
        description: _formatDate(s.statusDate ?? ''),
        dateTime: _formatDate(s.statusDate ?? ''),
        state: state,
        icon: _stageIcon(s.key),
      );
    }).toList();
  }

  int get completedStepsCount =>
      order.value?.stages.where((s) => s.completed).length ?? 0;

  // ── Helpers ────────────────────────────────────────────────────────────────

  IconData _stageIcon(String key) {
    switch (key) {
      case 'tailor_selected':
        return Icons.person_rounded;
      case 'started':
        return Icons.play_arrow_rounded;
      case 'ready_to_ship':
        return Icons.inventory_2_rounded;
      case 'shipped':
        return Icons.local_shipping_rounded;
      case 'in_delivery':
        return Icons.location_on_rounded;
      case 'delivered':
        return Icons.check_circle_rounded;
      default:
        return Icons.circle_outlined;
    }
  }

  String _formatDate(String iso) {
    if (iso.isEmpty) return '';
    try {
      final dt = DateTime.parse(iso).toLocal();
      final day = dt.day.toString().padLeft(2, '0');
      final month = dt.month.toString().padLeft(2, '0');
      return '${dt.year}/$month/$day';
    } catch (_) {
      return iso;
    }
  }
}
