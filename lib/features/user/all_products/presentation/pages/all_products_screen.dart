import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/widgets/base_app_scaffold.dart';
import 'package:app_mobile/core/widgets/product_card_widget.dart';
import 'package:app_mobile/features/user/all_products/presentation/controller/all_products_controller.dart';
import 'package:app_mobile/features/user/all_products/presentation/widgets/all_products_widgets.dart';
import 'package:app_mobile/features/user/product_details/presentation/widgets/add_to_cart_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProductsScreen extends StatefulWidget {
  /// When embedded as a bottom-nav tab, hide the back button.
  final bool showBackButton;

  const AllProductsScreen({super.key, this.showBackButton = true});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  late final AllProductsController _controller;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchTextController = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<AllProductsController>();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      _controller.loadMore();
    }
  }

  void _onSearchChanged(String value) {
    setState(() => _hasText = value.isNotEmpty);
    _controller.onSearchChanged(value);
  }

  void _clearSearch() {
    _searchTextController.clear();
    setState(() => _hasText = false);
    _controller.onSearchChanged('');
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
      title: ManagerStrings.allProductsTitle,
      subtitle: ManagerStrings.allProductsSubtitle,
      showBackButton: widget.showBackButton,
      useScrollView: false,
      child: Column(
        children: [
          // ── Search bar ────────────────────────────────────────────────
          _buildSearchBar(),
          SizedBox(height: ManagerHeight.h10),
          // ── Product count chip ────────────────────────────────────────
          Obx(() => _buildCountChip()),
          SizedBox(height: ManagerHeight.h8),
          // ── Content area ──────────────────────────────────────────────
          Expanded(
            child: Obx(() {
              if (_controller.isLoading.value) {
                return const AllProductsShimmer();
              }
              if (_controller.errorMessage.value.isNotEmpty &&
                  _controller.products.isEmpty) {
                return AllProductsErrorState(
                    onRetry: _controller.refreshProducts);
              }
              if (_controller.products.isEmpty) {
                return const AllProductsEmptyState();
              }
              return _buildProductGrid();
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        ManagerWidth.w16,
        ManagerHeight.h12,
        ManagerWidth.w16,
        0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: ManagerColors.backgroundTabBar,
          borderRadius: BorderRadius.circular(ManagerRadius.r14),
        ),
        child: TextField(
          controller: _searchTextController,
          onChanged: _onSearchChanged,
          style: getRegularTextStyle(
            fontSize: ManagerFontSize.s14,
            color: ManagerColors.black,
          ),
          decoration: InputDecoration(
            hintText: ManagerStrings.allProductsSearchHint,
            hintStyle: getRegularTextStyle(
              fontSize: ManagerFontSize.s14,
              color: ManagerColors.greyWhiteColor,
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: ManagerColors.greyWhiteColor,
              size: ManagerWidth.w20,
            ),
            suffixIcon: _hasText
                ? GestureDetector(
                    onTap: _clearSearch,
                    child: Padding(
                      padding: EdgeInsets.all(ManagerWidth.w12),
                      child: Icon(
                        Icons.clear_rounded,
                        color: ManagerColors.greyWhiteColor,
                        size: ManagerWidth.w18,
                      ),
                    ),
                  )
                : null,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              vertical: ManagerHeight.h14,
              horizontal: ManagerWidth.w4,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCountChip() {
    final count = _controller.products.length;
    if (_controller.isLoading.value || count == 0) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: ManagerWidth.w10,
            vertical: ManagerHeight.h5,
          ),
          decoration: BoxDecoration(
            color: ManagerColors.primaryColor.withOpacity(0.08),
            borderRadius: BorderRadius.circular(ManagerRadius.r20),
          ),
          child: Text(
            '$count ${ManagerStrings.allProductsTitle}',
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s12,
              color: ManagerColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductGrid() {
    return RefreshIndicator(
      color: ManagerColors.primaryColor,
      onRefresh: _controller.refreshProducts,
      child: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          Obx(
            () => SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: ManagerWidth.w16,
                vertical: ManagerHeight.h4,
              ),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: ManagerWidth.w10,
                  mainAxisSpacing: ManagerHeight.h10,
                  childAspectRatio: 0.54,
                ),
                delegate: SliverChildBuilderDelegate(
                  (_, index) {
                    final product = _controller.products[index];
                    final cardModel = ProductItemModel(
                      id: product.id,
                      name: product.name,
                      shopName: product.shopName,
                      imageUrl: product.imageUrl ?? '',
                      price: product.price,
                      isBestSeller: product.isBestSelling,
                    );
                    return AnimatedProductCard(
                      key: ValueKey(product.variantId),
                      index: index,
                      child: ProductCardWidget(
                        product: cardModel,
                        onTap: () => Navigator.pushNamed(
                          context,
                          Routes.productDetailsScreen,
                          arguments: product.id,
                        ),
                        onAddToCart: () => showAddToCartSheet(
                          context,
                          productId: product.id,
                        ),
                      ),
                    );
                  },
                  childCount: _controller.products.length,
                ),
              ),
            ),
          ),
          // bottom-of-list padding handled by AllProductsLoadMoreIndicator / SizedBox
          Obx(
            () => SliverToBoxAdapter(
              child: _controller.isLoadingMore.value
                  ? const AllProductsLoadMoreIndicator()
                  : SizedBox(height: ManagerHeight.h24),
            ),
          ),
        ],
      ),
    );
  }
}
