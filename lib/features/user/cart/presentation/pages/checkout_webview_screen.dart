import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/network/dio_factory.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import 'package:app_mobile/features/user/cart/presentation/controller/cart_controller.dart';
import 'package:app_mobile/features/user/chat/presentation/controller/user_chat_detail_controller.dart';
import 'package:app_mobile/features/user/home_user/presentation/controller/main_navigation_controller.dart';
import 'package:app_mobile/features/user/my_oredrs/presentation/controller/my_orders_controller.dart';

/// Payment source used after the gateway returns.
enum CheckoutPaymentSource { cart, zoqak, chat }

class CheckoutWebViewScreen extends StatefulWidget {
  final String checkoutUrl;
  final String? paymentSessionId;
  final String? provider;
  final CheckoutPaymentSource source;

  const CheckoutWebViewScreen({
    super.key,
    required this.checkoutUrl,
    this.paymentSessionId,
    this.provider,
    this.source = CheckoutPaymentSource.cart,
  });

  @override
  State<CheckoutWebViewScreen> createState() => _CheckoutWebViewScreenState();
}

class _CheckoutWebViewScreenState extends State<CheckoutWebViewScreen> {
  late final WebViewController _webViewController;
  bool _isPageLoading = true;
  String? _errorMessage;
  bool _resultHandled = false;
  bool _statusPolling = false;
  Timer? _loadingTimeout;

  @override
  void initState() {
    super.initState();

    final checkoutUri = Uri.tryParse(widget.checkoutUrl);
    if (checkoutUri == null ||
        !checkoutUri.hasScheme ||
        !checkoutUri.hasAuthority) {
      _errorMessage = ManagerStrings.invalidPaymentLink;
      _isPageLoading = false;
      return;
    }

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            if (!mounted) return;
            setState(() {
              _isPageLoading = true;
              _errorMessage = null;
            });
            _armLoadingTimeout();
            _handlePaymentUrl(url);
          },
          onPageFinished: (url) {
            if (!mounted) return;
            _loadingTimeout?.cancel();
            setState(() {
              _isPageLoading = false;
            });
            _handlePaymentUrl(url);
          },
          onNavigationRequest: (request) {
            _handlePaymentUrl(request.url);
            return NavigationDecision.navigate;
          },
          onWebResourceError: (error) {
            if (!mounted || _resultHandled) return;
            setState(() {
              _isPageLoading = false;
              _errorMessage = error.description;
            });
          },
        ),
      )
      ..loadRequest(checkoutUri);

    _armLoadingTimeout();
  }

  void _armLoadingTimeout() {
    _loadingTimeout?.cancel();
    _loadingTimeout = Timer(const Duration(seconds: 45), () {
      if (!mounted || _resultHandled || !_isPageLoading) return;
      setState(() {
        _isPageLoading = false;
        _errorMessage ??= ManagerStrings.paymentPageTimeout;
      });
    });
  }

  bool _isTelrReturnUrl(Uri uri) {
    final path = uri.path.toLowerCase();
    return path.contains('/payments/telr/authorised') ||
        path.contains('/payments/telr/declined') ||
        path.contains('/payments/telr/cancelled');
  }

  bool _isMockResultUrl(Uri uri) {
    final path = uri.path.toLowerCase();
    return path.contains('/payments/mock/complete') ||
        path.contains('/payment/success') ||
        path.contains('/payment/fail') ||
        path.contains('/payment/cancel');
  }

  void _handlePaymentUrl(String url) {
    if (_resultHandled || _statusPolling) return;
    final uri = Uri.tryParse(url);
    if (uri == null) return;

    if (_isTelrReturnUrl(uri)) {
      final path = uri.path.toLowerCase();
      if (path.contains('/authorised')) {
        unawaited(_pollSessionStatus(preferredOutcome: 'paid'));
      } else if (path.contains('/declined')) {
        unawaited(_pollSessionStatus(preferredOutcome: 'failed'));
      } else if (path.contains('/cancelled')) {
        unawaited(_pollSessionStatus(preferredOutcome: 'cancelled'));
      }
      return;
    }

    if (!_isMockResultUrl(uri) && !uri.queryParameters.containsKey('status')) {
      return;
    }

    final path = uri.path.toLowerCase();
    final status = (uri.queryParameters['status'] ?? '').toLowerCase();
    if (status == 'paid' ||
        status == 'success' ||
        status == 'succeeded' ||
        path.contains('/payment/success')) {
      if (widget.paymentSessionId != null &&
          widget.paymentSessionId!.isNotEmpty) {
        unawaited(_pollSessionStatus(preferredOutcome: 'paid'));
      } else {
        _finishPayment(paid: true);
      }
      return;
    }
    if (status == 'failed' ||
        status == 'fail' ||
        status == 'cancelled' ||
        status == 'canceled' ||
        path.contains('/payment/fail') ||
        path.contains('/payment/cancel')) {
      _finishPayment(paid: false);
    }
  }

  Future<void> _pollSessionStatus({required String preferredOutcome}) async {
    if (_resultHandled || _statusPolling) return;
    final sessionId = widget.paymentSessionId?.trim() ?? '';
    if (sessionId.isEmpty) {
      _finishPayment(paid: preferredOutcome == 'paid');
      return;
    }

    _statusPolling = true;
    if (mounted) {
      setState(() => _isPageLoading = true);
    }

    try {
      final dio = await instance<DioFactory>().getDio();
      // Poll a few times — webhook can arrive shortly after redirect.
      for (var attempt = 0; attempt < 8; attempt++) {
        if (_resultHandled || !mounted) return;
        final response = await dio.get(
          '/user/orders/payments/$sessionId/status',
        );
        final data = response.data;
        final status = _extractStatus(data);
        if (status == 'paid') {
          await _finishPayment(paid: true);
          return;
        }
        if (status == 'failed' || status == 'cancelled') {
          await _finishPayment(paid: false);
          return;
        }
        await Future<void>.delayed(Duration(milliseconds: 700 + attempt * 200));
      }

      // Still pending after polls: use redirect hint for UX, but do not invent paid.
      if (preferredOutcome == 'paid') {
        // One confirm call that runs Telr check server-side.
        try {
          final confirm = await dio.post(
            '/user/orders/payments/$sessionId/confirm',
          );
          final status = _extractStatus(confirm.data);
          if (status == 'paid') {
            await _finishPayment(paid: true);
            return;
          }
        } catch (_) {
          // fall through
        }
      }
      await _finishPayment(paid: false);
    } catch (_) {
      await _finishPayment(paid: preferredOutcome == 'paid' ? false : false);
    } finally {
      _statusPolling = false;
    }
  }

  String _extractStatus(dynamic data) {
    if (data is Map) {
      final nested = data['data'];
      if (nested is Map && nested['status'] != null) {
        return nested['status'].toString().toLowerCase();
      }
      if (data['status'] != null && data['status'] != 'success') {
        return data['status'].toString().toLowerCase();
      }
      if (nested is Map && nested['payment'] is Map) {
        return (nested['payment']['status'] ?? '').toString().toLowerCase();
      }
    }
    return '';
  }

  Future<void> _finishPayment({required bool paid}) async {
    if (_resultHandled) return;
    _resultHandled = true;
    _loadingTimeout?.cancel();

    switch (widget.source) {
      case CheckoutPaymentSource.cart:
        if (Get.isRegistered<CartController>()) {
          await Get.find<CartController>().onPaymentCompleted(paid: paid);
        } else if (paid) {
          AppSnackbar.success(ManagerStrings.cartCheckoutSuccess);
        } else {
          AppSnackbar.error(ManagerStrings.paymentNotCompleted);
        }
        break;
      case CheckoutPaymentSource.zoqak:
        if (paid) {
          AppSnackbar.success(ManagerStrings.cartCheckoutSuccess);
          if (Get.isRegistered<MyOrdersController>()) {
            final orders = Get.find<MyOrdersController>();
            await orders.fetchOrders();
          }
        } else {
          AppSnackbar.error(ManagerStrings.paymentNotCompleted);
        }
        break;
      case CheckoutPaymentSource.chat:
        if (paid) {
          AppSnackbar.success(ManagerStrings.cartCheckoutSuccess);
          if (Get.isRegistered<UserChatDetailController>()) {
            await Get.find<UserChatDetailController>().fetchMessages();
          }
        } else {
          AppSnackbar.error(ManagerStrings.paymentNotCompleted);
        }
        // Caller updates offer card via Get.back(result: paid)
        break;
    }

    if (!mounted) return;

    if (widget.source == CheckoutPaymentSource.chat) {
      Get.back(result: paid);
      return;
    }

    if (paid) {
      Get.offNamedUntil(
        Routes.mainNavigation,
        (route) => false,
      );
      if (Get.isRegistered<MainNavigationController>()) {
        Get.find<MainNavigationController>().goToTab(1);
      }
    } else {
      Get.back();
    }
  }

  @override
  void dispose() {
    _loadingTimeout?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ManagerColors.white,
      appBar: AppBar(
        backgroundColor: ManagerColors.primaryColor,
        iconTheme: IconThemeData(color: ManagerColors.white),
        title: Text(
          ManagerStrings.completePayment,
          style: getBoldTextStyle(
            fontSize: ManagerFontSize.s15,
            color: ManagerColors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          if (_errorMessage != null)
            _CheckoutWebViewError(
              message: _errorMessage!,
              onRetry: () {
                final uri = Uri.tryParse(widget.checkoutUrl);
                if (uri == null) return;
                setState(() {
                  _errorMessage = null;
                  _isPageLoading = true;
                  _resultHandled = false;
                  _statusPolling = false;
                });
                _webViewController.loadRequest(uri);
                _armLoadingTimeout();
              },
            )
          else
            WebViewWidget(controller: _webViewController),
          if (_isPageLoading && _errorMessage == null)
            Positioned.fill(
              child: Container(
                color: ManagerColors.white.withOpacity(0.75),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      color: ManagerColors.primaryColor,
                    ),
                    SizedBox(height: ManagerHeight.h10),
                    Text(
                      ManagerStrings.loadingPaymentPage,
                      style: getRegularTextStyle(
                        fontSize: ManagerFontSize.s13,
                        color: ManagerColors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _CheckoutWebViewError extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const _CheckoutWebViewError({required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: ManagerColors.greyWhiteColor,
              size: ManagerWidth.w48,
            ),
            SizedBox(height: ManagerHeight.h12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s13,
                color: ManagerColors.greyWhiteColor,
              ),
            ),
            if (onRetry != null) ...[
              SizedBox(height: ManagerHeight.h16),
              TextButton(
                onPressed: onRetry,
                child: Text(ManagerStrings.retry),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
