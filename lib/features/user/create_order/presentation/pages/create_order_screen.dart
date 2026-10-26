import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/app_safe_area.dart';
import 'package:app_mobile/core/widgets/button_app.dart';
import 'package:app_mobile/core/widgets/custom_confirm_dialog.dart';
import 'package:app_mobile/core/widgets/loading_widget.dart';
import 'package:app_mobile/features/user/create_order/domain/di/di.dart';
import 'package:app_mobile/features/user/create_order/presentation/controller/create_order_controller.dart';
import 'package:app_mobile/features/user/create_order/presentation/widgets/create_order_app_bar.dart';
import 'package:app_mobile/features/user/create_order/presentation/widgets/order_budget_page.dart';
import 'package:app_mobile/features/user/create_order/presentation/widgets/order_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({super.key});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  // ── DI / Controller ────────────────────────────────────────────────────────
  late final CreateOrderController _controller;

  // ── Page controller ────────────────────────────────────────────────────────
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // ── Form key ───────────────────────────────────────────────────────────────
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // ── Lifecycle ──────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    initCreateOrder();
    _controller = Get.find<CreateOrderController>();
  }

  @override
  void dispose() {
    disposeCreateOrder();
    _pageController.dispose();
    super.dispose();
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  bool get _isLastPage => _currentPage == 1;

  void _onPageChanged(int page) {
    setState(() => _currentPage = page);
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
  }

  // ── Navigation ─────────────────────────────────────────────────────────────

  void _handleBack() {
    if (_currentPage > 0) {
      _goToPage(_currentPage - 1);
    } else {
      Get.back();
    }
  }

  void _handleNext() {
    if (_currentPage == 0) {
      _validateAndGoNext();
    } else {
      _handleSubmit();
    }
  }

  void _validateAndGoNext() {
    if (_controller.selectedFabric.value == null) {
      _controller.validate();
      return;
    }
    if (_formKey.currentState!.validate()) {
      _goToPage(1);
    }
  }

  // ── Submit flow ────────────────────────────────────────────────────────────

  Future<void> _handleSubmit() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;
    if (!_controller.validate()) return;

    final bool? confirmed = await CustomConfirmDialog.show(
      context: context,
      title: ManagerStrings.createOrderConfirmTitle,
      subtitle: ManagerStrings.createOrderConfirmSubtitle,
      confirmText: ManagerStrings.createOrderConfirmYes,
      cancelText: ManagerStrings.createOrderConfirmNo,
    );

    if (confirmed != true) return;

    await _controller.submitOrder();
  }

  // ── Date picker ────────────────────────────────────────────────────────────

  Future<void> _pickDeadline() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _controller.selectedDeadline.value ??
          now.add(const Duration(days: 7)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      builder: (ctx, child) {
        return Theme(
          data: Theme.of(ctx).copyWith(
            colorScheme: ColorScheme.light(
              primary: ManagerColors.primaryColor,
              onPrimary: ManagerColors.white,
              surface: ManagerColors.white,
              onSurface: ManagerColors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      _controller.setDeadline(picked);
    }
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: AppSafeArea(
        child: Scaffold(
          backgroundColor: ManagerColors.white,
          body: Obx(
            () => Stack(
              children: [
                // ── Main content ───────────────────────────────────────────
                Column(
                  children: [
                    // ── App bar with progress indicator ───────────────────
                    CreateOrderAppBar(
                      currentPage: _currentPage,
                      totalPages: 2,
                      onBackPressed: _handleBack,
                    ),

                    // ── Page content ──────────────────────────────────────
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: Obx(
                          () => PageView(
                            controller: _pageController,
                            onPageChanged: _onPageChanged,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              // Page 1 — الملبس والتفاصيل
                              OrderDetailsPage(
                                nameController:
                                    _controller.productNameController,
                                descController:
                                    _controller.descriptionController,
                                specialRequestsController:
                                    _controller.specialRequestsController,
                                selectedFabric:
                                    _controller.selectedFabric.value,
                                onFabricSelected: (fabric) {
                                  _controller.selectedFabric.value = fabric;
                                },
                              ),

                              // Page 2 — الميزانية والتوقيت
                              OrderBudgetPage(
                                minBudgetController:
                                    _controller.minBudgetController,
                                maxBudgetController:
                                    _controller.maxBudgetController,
                                selectedDeadline:
                                    _controller.selectedDeadline.value,
                                referenceImages: _controller.referenceImages,
                                onPickDeadline: _pickDeadline,
                                onAddImages: _controller.pickImages,
                                onRemoveImage: _controller.removeImage,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // ── Bottom action button ──────────────────────────────
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ManagerWidth.w16,
                        vertical: ManagerHeight.h12,
                      ),
                      decoration: BoxDecoration(
                        color: ManagerColors.white,
                        boxShadow: [
                          BoxShadow(
                            color: ManagerColors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, -2),
                          ),
                        ],
                      ),
                      child: SafeArea(
                        top: false,
                        child: ButtonApp(
                          title: _isLastPage
                              ? ManagerStrings.createOrderSubmitButton
                              : ManagerStrings.createOrderNextButton,
                          onPressed: _controller.isLoading.value
                              ? () {}
                              : _handleNext,
                          paddingWidth: 0,
                        ),
                      ),
                    ),
                  ],
                ),

                // ── Loading overlay ───────────────────────────────────────
                if (_controller.isLoading.value) const LoadingWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
