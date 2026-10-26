import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/features/user/cart/presentation/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/model/user_order_model.dart';
import '../../domain/model/order_details_model.dart';
import '../../domain/model/user_order_domain_model.dart';
import '../../domain/model/zoqak_offer_domain_model.dart';
import '../../domain/use_case/get_user_orders_use_case.dart';
import '../../domain/use_case/get_zoqak_offers_use_case.dart';
import '../../domain/use_case/accept_zoqak_offer_use_case.dart';
import '../../domain/model/tailor_offer_model.dart';

class MyOrdersController extends GetxController {
  final GetUserOrdersUseCase _getUserOrdersUseCase;
  final GetZoqakOffersUseCase _getZoqakOffersUseCase;
  final AcceptZoqakOfferUseCase _acceptZoqakOfferUseCase;

  MyOrdersController(
    this._getUserOrdersUseCase,
    this._getZoqakOffersUseCase,
    this._acceptZoqakOfferUseCase,
  );

  // ── State ─────────────────────────────────────────────────────────────────

  final RxBool isLoading = false.obs;
  final RxBool isOffersLoading = false.obs;
  final RxBool isAccepting = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString offersErrorMessage = ''.obs;
  final RxInt selectedFilterIndex = 0.obs;

  final RxList<UserOrderModel> allOrders = <UserOrderModel>[].obs;
  final RxList<UserOrderDomainModel> rawOrders = <UserOrderDomainModel>[].obs;
  final RxList<TailorOfferModel> currentOffers = <TailorOfferModel>[].obs;

  // Current zoqak orderId for offers screen
  String _currentZoqakOrderId = '';

  // ── Lifecycle ─────────────────────────────────────────────────────────────

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  // ── Orders ────────────────────────────────────────────────────────────────

  Future<void> fetchOrders() async {
    isLoading.value = true;
    errorMessage.value = '';
    final result = await _getUserOrdersUseCase.execute();
    result.fold(
      (failure) {
        errorMessage.value = failure.message;
        isLoading.value = false;
      },
      (orders) {
        rawOrders.value = orders;
        allOrders.value = orders.map(_mapToUiModel).toList();
        isLoading.value = false;
      },
    );
  }

  Future<void> refreshOrders() => fetchOrders();

  // ── Offers ────────────────────────────────────────────────────────────────

  Future<void> fetchZoqakOffers(String orderId) async {
    _currentZoqakOrderId = orderId;
    isOffersLoading.value = true;
    offersErrorMessage.value = '';
    final result = await _getZoqakOffersUseCase.execute(orderId);
    result.fold(
      (failure) {
        offersErrorMessage.value = failure.message;
        isOffersLoading.value = false;
      },
      (offers) {
        currentOffers.value = offers.map(_mapOfferToUiModel).toList();
        isOffersLoading.value = false;
      },
    );
  }

  Future<void> acceptOffer(String offerId) async {
    if (_currentZoqakOrderId.isEmpty) return;
    isAccepting.value = true;
    final result = await _acceptZoqakOfferUseCase.execute(
      orderId: _currentZoqakOrderId,
      offerId: offerId,
    );
    result.fold(
      (failure) {
        isAccepting.value = false;
        Get.snackbar(
          ManagerStrings.errorTitle,
          failure.message,
        );
      },
      (payment) async {
        isAccepting.value = false;
        final rawUrl = (payment?.paymentUrl ?? '').trim();
        final paymentUrl = CartController.normalizePaymentUrl(rawUrl);
        final sessionId = (payment?.paymentSessionId ?? '').trim();
        if (paymentUrl.isEmpty) {
          Get.snackbar(
            ManagerStrings.errorTitle,
            ManagerStrings.invalidPaymentLink,
          );
          return;
        }
        // Open Telr (or mock) WebView; post-paid refresh is handled there.
        await Get.toNamed(
          Routes.checkoutWebViewScreen,
          arguments: {
            'url': paymentUrl,
            'sessionId': sessionId,
            'provider': payment?.provider,
            'source': 'zoqak',
          },
        );
        if (_currentZoqakOrderId.isNotEmpty) {
          await fetchZoqakOffers(_currentZoqakOrderId);
        }
      },
    );
  }

  // ── Filtered list ─────────────────────────────────────────────────────────

  List<UserOrderModel> get filteredOrders {
    switch (selectedFilterIndex.value) {
      case 1: // انتظار عروض / عروض واردة
        return allOrders
            .where((o) =>
                o.status == UserOrderStatus.waitingOffers ||
                o.status == UserOrderStatus.hasOffers)
            .toList();
      case 2: // قيد التنفيذ
        return allOrders
            .where((o) => o.status == UserOrderStatus.inProgress)
            .toList();
      case 3: // جاهز للتوصيل
        return allOrders
            .where((o) => o.status == UserOrderStatus.readyForDelivery)
            .toList();
      case 4: // مكتمل
        return allOrders
            .where((o) => o.status == UserOrderStatus.completed)
            .toList();
      default:
        return allOrders.toList();
    }
  }

  // ── Domain model lookup ───────────────────────────────────────────────────

  UserOrderDomainModel? getOrderById(String id) {
    try {
      return rawOrders.firstWhere((o) => o.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Maps a raw domain order to the [OrderDetailsModel] used by the UI widgets.
  OrderDetailsModel? buildDetailsModel(String orderId) {
    final d = getOrderById(orderId);
    if (d == null) return null;

    // ── Type ──────────────────────────────────────────────────────────────
    final type =
        d.isShop ? OrderDetailsType.readyPieces : OrderDetailsType.custom;

    // ── Status ────────────────────────────────────────────────────────────
    OrderDetailsStatus detailStatus;
    if (d.isZoqak) {
      switch (d.status) {
        case UserOrderApiStatus.active:
          detailStatus = d.hasAcceptedOffer
              ? OrderDetailsStatus.inProgress
              : OrderDetailsStatus.waitingOffers;
          break;
        case UserOrderApiStatus.accepted:
          detailStatus = OrderDetailsStatus.hasOffers;
          break;
        case UserOrderApiStatus.completed:
          detailStatus = OrderDetailsStatus.completed;
          break;
        default:
          detailStatus = OrderDetailsStatus.waitingOffers;
      }
    } else {
      switch (d.status) {
        case UserOrderApiStatus.active:
          detailStatus = OrderDetailsStatus.inProgress;
          break;
        case UserOrderApiStatus.completed:
          detailStatus = OrderDetailsStatus.completed;
          break;
        default:
          detailStatus = OrderDetailsStatus.inProgress;
      }
    }

    // ── Product ───────────────────────────────────────────────────────────
    final productName = d.isShop
        ? (d.items?.isNotEmpty == true
            ? (d.items!.first.productName ?? d.shopName ?? '')
            : (d.shopName ?? ''))
        : (d.productName ?? '');

    final product = OrderProduct(
      name: productName,
      imageUrl: d.thumbnailUrl ?? '',
      fabric: d.fabricType ?? '',
      measurements: '',
      totalPrice: d.totalAmount ??
          ((d.minBudget != null && d.maxBudget != null)
              ? (d.minBudget! + d.maxBudget!) / 2
              : 0.0),
      isPaid: d.paymentStatus?.toLowerCase() == 'paid',
      description: '',
    );

    // ── Tailor / shop ─────────────────────────────────────────────────────
    final tailor = OrderTailor(
      name: d.isShop
          ? (d.shopName ?? '')
          : (d.acceptedByProviderName ?? ''),
      location: '',
      phoneNumber: null,
    );

    // ── Tracking steps ────────────────────────────────────────────────────
    bool foundCurrent = false;
    final steps = d.stages.map((s) {
      OrderTrackingStepState state;
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
        description: s.statusDate ?? '',
        dateTime: s.statusDate ?? '',
        state: state,
        icon: _stageIcon(s.key),
      );
    }).toList();

    return OrderDetailsModel(
      orderId: d.orderNumber.isNotEmpty ? d.orderNumber : d.id,
      orderType: type,
      status: detailStatus,
      orderDate: _formatDate(d.createdAt),
      deliveryDate: d.deliveryDate ?? '',
      product: product,
      tailor: tailor,
      trackingSteps: steps,
    );
  }

  IconData _stageIcon(String key) {
    switch (key.toLowerCase()) {
      case 'placed':
      case 'order_placed':
        return Icons.check_circle_outline_rounded;
      case 'confirmed':
        return Icons.verified_rounded;
      case 'in_progress':
      case 'processing':
        return Icons.autorenew_rounded;
      case 'ready':
      case 'ready_for_shipping':
        return Icons.inventory_2_rounded;
      case 'shipped':
        return Icons.local_shipping_rounded;
      case 'delivering':
        return Icons.delivery_dining_rounded;
      case 'delivered':
      case 'completed':
        return Icons.check_circle_rounded;
      default:
        return Icons.radio_button_unchecked_rounded;
    }
  }

  // ── Domain → UI mappers ───────────────────────────────────────────────────

  UserOrderModel _mapToUiModel(UserOrderDomainModel d) {
    // Map order type
    UserOrderType uiType;
    if (d.orderType == UserOrderApiType.shop) {
      uiType = UserOrderType.readyPieces;
    } else {
      // zoqak → custom
      uiType = UserOrderType.custom;
    }

    // Map status
    UserOrderStatus uiStatus;
    if (d.orderType == UserOrderApiType.zoqak) {
      switch (d.status) {
        case UserOrderApiStatus.active:
          // Active zoqak with no accepted provider = waitingOffers
          // Active zoqak with accepted provider = inProgress
          uiStatus = d.hasAcceptedOffer
              ? UserOrderStatus.inProgress
              : UserOrderStatus.waitingOffers;
          break;
        case UserOrderApiStatus.accepted:
          uiStatus = UserOrderStatus.hasOffers;
          break;
        case UserOrderApiStatus.completed:
          uiStatus = UserOrderStatus.completed;
          break;
        default:
          uiStatus = UserOrderStatus.waitingOffers;
      }
    } else {
      // shop orders
      switch (d.status) {
        case UserOrderApiStatus.active:
          uiStatus = UserOrderStatus.inProgress;
          break;
        case UserOrderApiStatus.completed:
          uiStatus = UserOrderStatus.completed;
          break;
        case UserOrderApiStatus.cancelled:
          uiStatus = UserOrderStatus.completed;
          break;
        default:
          uiStatus = UserOrderStatus.inProgress;
      }
    }

    // Offers count (for zoqak hasOffers state)
    final offersCount = (uiStatus == UserOrderStatus.hasOffers)
        ? 1
        : null;

    return UserOrderModel(
      orderId: d.id,
      title: d.displayTitle,
      imageUrl: d.thumbnailUrl ?? '',
      orderType: uiType,
      status: uiStatus,
      price: d.totalAmount ??
          ((d.minBudget != null && d.maxBudget != null)
              ? (d.minBudget! + d.maxBudget!) / 2
              : 0.0),
      orderDate: _formatDate(d.createdAt),
      deadline: d.deliveryDate ?? '',
      offersCount: offersCount,
      piecesCount: d.items?.length,
      confirmedTailorName: d.acceptedByProviderName,
    );
  }

  TailorOfferModel _mapOfferToUiModel(ZoqakOfferDomainModel d) {
    final isAvailable = d.providerIsAvailable
        ? TailorAvailability.available
        : TailorAvailability.busy;

    return TailorOfferModel(
      offerId: d.id,
      tailorId: d.providerId ?? '',
      tailorName: d.providerName,
      tailorAvatarUrl: d.providerImage ?? '',
      availability: isAvailable,
      tailorBadge: d.providerRankLabel ?? d.providerRank ?? '',
      rating: d.providerRating,
      reviewCount: d.providerRatersCount,
      repliedAgo: _relativeTime(d.createdAt),
      durationDays: d.executionDays,
      price: d.proposedPrice,
      description: d.details ?? '',
      sampleImageUrls: const [],
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  String _formatDate(String isoDate) {
    if (isoDate.isEmpty) return '';
    try {
      final dt = DateTime.parse(isoDate);
      return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
    } catch (_) {
      return isoDate;
    }
  }

  String _relativeTime(String? isoDate) {
    if (isoDate == null || isoDate.isEmpty) return '';
    try {
      final dt = DateTime.parse(isoDate);
      final diff = DateTime.now().difference(dt);
      if (diff.inMinutes < 60) {
        return '${diff.inMinutes} ${ManagerStrings.minutesShort}';
      }
      if (diff.inHours < 24) {
        return '${diff.inHours} ${ManagerStrings.hoursShort}';
      }
      return '${diff.inDays} ${ManagerStrings.daysShort}';
    } catch (_) {
      return '';
    }
  }
}
