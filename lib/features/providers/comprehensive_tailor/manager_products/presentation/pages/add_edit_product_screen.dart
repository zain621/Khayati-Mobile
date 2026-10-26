import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/widgets/app_safe_area.dart';
import 'package:app_mobile/core/widgets/custom_appbar.dart';
import 'package:app_mobile/core/widgets/loading_widget.dart';
import 'package:app_mobile/features/providers/comprehensive_tailor/manager_products/presentation/widgets/add_edit_product_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controller/add_edit_product_controller.dart';

class AddEditProductScreen extends StatelessWidget {
  const AddEditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<AddEditProductController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: AppSafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFFF4F6F8),
          resizeToAvoidBottomInset: true,
          bottomNavigationBar: AddEditBottomBar(ctrl: ctrl),
          body: Stack(
            children: [
              Column(
                children: [
                  CustomAppBar(
                    title: ctrl.isEditMode
                        ? ManagerStrings.editProductTitle
                        : ManagerStrings.addProductTitle,
                    subtitle: ctrl.isEditMode
                        ? ManagerStrings.editProductSubtitle
                        : ManagerStrings.addProductSubtitle,
                    showBackButton: true,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        top: ManagerHeight.h8,
                        bottom: ManagerHeight.h16,
                      ),
                      child: Obx(() {
                        if (ctrl.isLoadingDetails.value) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 80),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return Column(
                          children: [
                            AddEditImagesSection(ctrl: ctrl),
                            AddEditBasicInfoSection(ctrl: ctrl),
                            AddEditColorsSection(ctrl: ctrl),
                            AddEditSizesSection(ctrl: ctrl),
                            if (!ctrl.isEditMode)
                              AddEditVariantsQuantitySection(ctrl: ctrl),
                            if (ctrl.isEditMode)
                              AddEditExistingVariantsSection(ctrl: ctrl),
                            AddEditDeliverySection(ctrl: ctrl),
                            AddEditCareInstructionsSection(ctrl: ctrl),
                            AddEditFeaturesSection(ctrl: ctrl),
                          ],
                        );
                      }),
                    ),
                  ),
                ],
              ),
              // ── Saving overlay ──────────────────────────────────────────
              Obx(() => ctrl.isSaving.value
                  ? const Positioned.fill(child: LoadingWidget())
                  : const SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }
}
