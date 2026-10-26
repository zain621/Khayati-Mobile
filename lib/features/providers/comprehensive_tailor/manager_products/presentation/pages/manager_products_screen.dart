import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/app_safe_area.dart';
import 'package:app_mobile/core/widgets/loading_widget.dart';
import 'package:app_mobile/features/providers/comprehensive_tailor/manager_products/domain/di/di.dart';
import 'package:app_mobile/features/providers/comprehensive_tailor/manager_products/presentation/controller/manager_products_controller.dart';
import 'package:app_mobile/features/providers/comprehensive_tailor/manager_products/presentation/widgets/product_card.dart';
import 'package:app_mobile/features/providers/comprehensive_tailor/manager_products/presentation/widgets/product_filter_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Screen for managing products for shop owners.
class ManagerProductsScreen extends StatelessWidget {
  const ManagerProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    initManagerProducts();
    final controller = Get.find<ManagerProductsController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: AppSafeArea(
        child: Scaffold(
          backgroundColor: ManagerColors.white,
          floatingActionButton: _buildAddButton(controller),
          body: Stack(
            children: [
              Column(
                children: [
              /// Green Header with Title and Filter Tabs
              _buildHeader(context, controller),

              /// Scrollable Product Cards
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: LoadingWidget());
                  }

                  final products = controller.filteredProducts;

                  return RefreshIndicator(
                    onRefresh: controller.refreshProducts,
                    color: ManagerColors.primaryColor,
                    child: controller.isError.value
                        ? _buildErrorState(controller)
                        : products.isEmpty
                            ? _buildEmptyState()
                            : ListView.separated(
                                physics:
                                    const AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.only(
                                  top: ManagerHeight.h12,
                                  bottom: ManagerHeight.h80,
                                ),
                                itemCount: products.length,
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: ManagerHeight.h4),
                                itemBuilder: (context, index) {
                                  return ProductCard(
                                    product: products[index],
                                    onEdit: () => controller
                                        .handleEdit(products[index]),
                                    onPause: () => controller
                                        .handlePause(products[index]),
                                    onDelete: () => controller
                                        .handleDelete(products[index]),
                                  );
                                },
                              ),
                  );
                }),
              ),
                ],
              ),
              _buildActionLoadingOverlay(controller),
            ],
          ),
        ),
      ),
    );
  }

  /// Green header with title, subtitle, search bar, and filter tabs.
  Widget _buildHeader(
      BuildContext context, ManagerProductsController controller) {
    return Container(
      color: ManagerColors.primaryColor,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title and Subtitle
          Padding(
            padding: EdgeInsets.only(
              top: ManagerHeight.h12,
              right: ManagerWidth.w16,
              left: ManagerWidth.w16,
              bottom: ManagerHeight.h8,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Back Button
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    height: ManagerHeight.h34,
                    width: ManagerWidth.w34,
                    padding: EdgeInsets.all(ManagerWidth.w4),
                    decoration: BoxDecoration(
                      color: ManagerColors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: ManagerColors.white,
                      size: ManagerHeight.h24,
                    ),
                  ),
                ),
                SizedBox(width: ManagerWidth.w12),

                /// Title + Subtitle
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ManagerStrings.managerProductsTitle,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s18,
                        color: ManagerColors.white,
                      ),
                    ),
                    SizedBox(height: ManagerHeight.h4),
                    Text(
                      ManagerStrings.managerProductsSubtitle,
                      style: getRegularTextStyle(
                        fontSize: ManagerFontSize.s13,
                        color: ManagerColors.white.withOpacity(0.85),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// Search Bar
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w16,
              vertical: ManagerHeight.h8,
            ),
            child: _buildSearchBar(controller),
          ),

          SizedBox(height: ManagerHeight.h4),

          /// Filter Tabs
          Obx(() => ProductFilterTabs(
                selectedIndex: controller.selectedFilterIndex.value,
                onSelected: controller.setFilterIndex,
                filters: [
                  ProductFilterItem(
                    label: ManagerStrings.managerProductsFilterAll,
                    count: controller.allCount,
                  ),
                  ProductFilterItem(
                    label: ManagerStrings.managerProductsFilterActive,
                    count: controller.activeCount,
                  ),
                  ProductFilterItem(
                    label: ManagerStrings.managerProductsFilterInactive,
                    count: controller.inactiveCount,
                  ),
                  ProductFilterItem(
                    label: ManagerStrings.managerProductsFilterOutOfStock,
                    count: controller.outOfStockCount,
                  ),
                ],
                isDarkBackground: true,
              )),

          SizedBox(height: ManagerHeight.h12),
        ],
      ),
    );
  }

  /// Search bar widget.
  Widget _buildSearchBar(ManagerProductsController controller) {
    return Container(
      decoration: BoxDecoration(
        color: ManagerColors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
      ),
      child: Obx(() => TextField(
            controller: controller.searchController,
            onChanged: controller.setSearchQuery,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s14,
              color: ManagerColors.black,
            ),
            decoration: InputDecoration(
              hintText: ManagerStrings.managerProductsSearchHint,
              hintStyle: getRegularTextStyle(
                fontSize: ManagerFontSize.s14,
                color: ManagerColors.white,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: ManagerColors.white,
                size: ManagerFontSize.s20,
              ),
              suffixIcon: controller.searchQuery.value.isNotEmpty
                  ? GestureDetector(
                      onTap: controller.clearSearch,
                      child: Icon(
                        Icons.close,
                        color: ManagerColors.white,
                        size: ManagerFontSize.s20,
                      ),
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: ManagerWidth.w16,
                vertical: ManagerHeight.h14,
              ),
            ),
          )),
    );
  }

  /// Empty state when no products match filter (scrollable for pull-to-refresh).
  Widget _buildEmptyState() {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: constraints.maxHeight,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.inventory_2_outlined,
                  size: 56,
                  color: ManagerColors.greyWhiteColor.withOpacity(0.4),
                ),
                SizedBox(height: ManagerHeight.h12),
                Text(
                  ManagerStrings.managerProductsNoProducts,
                  style: getMediumTextStyle(
                    fontSize: ManagerFontSize.s16,
                    color: ManagerColors.greyWhiteColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Error state with retry button (scrollable for pull-to-refresh).
  Widget _buildErrorState(ManagerProductsController controller) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: constraints.maxHeight,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 56,
                  color: ManagerColors.greyWhiteColor.withOpacity(0.4),
                ),
                SizedBox(height: ManagerHeight.h12),
                Text(
                  controller.errorMessage.value,
                  style: getMediumTextStyle(
                    fontSize: ManagerFontSize.s14,
                    color: ManagerColors.greyWhiteColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: ManagerHeight.h16),
                TextButton.icon(
                  onPressed: controller.fetchProducts,
                  icon: const Icon(Icons.refresh,
                      color: ManagerColors.primaryColor),
                  label: Text(
                    ManagerStrings.retry,
                    style: getMediumTextStyle(
                      fontSize: ManagerFontSize.s14,
                      color: ManagerColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Floating add button.
  Widget _buildAddButton(ManagerProductsController controller) {
    return FloatingActionButton.extended(
      onPressed: controller.handleAddProduct,
      backgroundColor: ManagerColors.primaryColor,
      icon: const Icon(
        Icons.add,
        color: ManagerColors.white,
      ),
      label: Text(
        ManagerStrings.managerProductsAddButton,
        style: getMediumTextStyle(
          fontSize: ManagerFontSize.s14,
          color: ManagerColors.white,
        ),
      ),
    );
  }

  /// Full-screen loading overlay shown while an action (delete/activate/cancel) is in progress.
  Widget _buildActionLoadingOverlay(ManagerProductsController controller) {
    return Obx(() {
      if (!controller.isActionLoading.value) return const SizedBox.shrink();
      return AbsorbPointer(
        child: Container(
          color: ManagerColors.black.withOpacity(0.45),
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: ManagerWidth.w32,
                vertical: ManagerHeight.h24,
              ),
              decoration: BoxDecoration(
                color: ManagerColors.white,
                borderRadius: BorderRadius.circular(ManagerRadius.r12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    color: ManagerColors.primaryColor,
                    strokeWidth: 3,
                  ),
                  SizedBox(height: ManagerHeight.h16),
                  Text(
                    ManagerStrings.managerProductsActionLoading,
                    style: getMediumTextStyle(
                      fontSize: ManagerFontSize.s14,
                      color: ManagerColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

