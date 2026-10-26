import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_icons.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/custom_svg_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:app_mobile/core/routes/routes.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../domain/model/search_model.dart';
import '../controller/search_controller.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// ── Header Widget (green bg with search bar)
// ═══════════════════════════════════════════════════════════════════════════════

class SearchHeaderWidget extends StatelessWidget {
  final SearchController controller;

  const SearchHeaderWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Container(
      decoration: const BoxDecoration(color: ManagerColors.primaryColor),
      padding: EdgeInsets.only(
        top: topPadding + ManagerHeight.h12,
        bottom: ManagerHeight.h16,
        left: ManagerWidth.w16,
        right: ManagerWidth.w16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back row
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: ManagerWidth.w36,
                  height: ManagerHeight.h36,
                  decoration: BoxDecoration(
                    color: ManagerColors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(ManagerRadius.r8),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: ManagerColors.white,
                    size: ManagerWidth.w18,
                  ),
                ),
              ),
              SizedBox(width: ManagerWidth.w12),
              Text(
                ManagerStrings.searchTitle,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s18,
                  color: ManagerColors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: ManagerHeight.h6),
          Text(
            ManagerStrings.searchSubtitle,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s12,
              color: ManagerColors.white.withOpacity(0.75),
            ),
          ),
          SizedBox(height: ManagerHeight.h14),
          // Search field
          Container(
            height: ManagerHeight.h44,
            decoration: BoxDecoration(
              color: ManagerColors.white,
              borderRadius: BorderRadius.circular(ManagerRadius.r10),
            ),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ManagerWidth.w12),
              child: Row(
                children: [
                  CustomSvgImage(
                    path: ManagerIcons.searchIcon,
                    color: ManagerColors.primaryColor,
                    height: ManagerHeight.h20,
                    width: ManagerWidth.w20,
                  ),
                  SizedBox(width: ManagerWidth.w8),
                  Expanded(
                    child: TextField(
                      controller: controller.searchTextController,
                      focusNode: controller.searchFocus,
                      onChanged: controller.onSearchChanged,
                      textAlign: TextAlign.right,
                      textAlignVertical: TextAlignVertical.center,
                      style: getRegularTextStyle(
                        fontSize: ManagerFontSize.s14,
                        color: ManagerColors.black,
                      ),
                      cursorColor: ManagerColors.primaryColor,
                      decoration: InputDecoration(
                        hintText: ManagerStrings.searchHint,
                        hintStyle: getRegularTextStyle(
                          fontSize: ManagerFontSize.s13,
                          color: ManagerColors.greyWhiteColor,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: ManagerHeight.h12,
                        ),
                      ),
                    ),
                  ),
                  Obx(() => controller.hasQuery
                      ? GestureDetector(
                          onTap: () {
                            controller.searchTextController.clear();
                            controller.onSearchChanged('');
                          },
                          child: Icon(
                            Icons.close_rounded,
                            color: ManagerColors.greyWhiteColor,
                            size: ManagerWidth.w20,
                          ),
                        )
                      : const SizedBox.shrink()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── History View
// ═══════════════════════════════════════════════════════════════════════════════

class SearchHistoryView extends StatelessWidget {
  final SearchController controller;

  const SearchHistoryView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingHistory.value) {
        return _HistoryShimmer();
      }
      final items = controller.history;
      return Column(
        children: [
          if (items.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ManagerWidth.w16,
                vertical: ManagerHeight.h14,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ManagerStrings.searchHistoryTitle,
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s14,
                      color: ManagerColors.black,
                    ),
                  ),
                  Obx(() => controller.isDeletingAll.value
                      ? SizedBox(
                          width: ManagerWidth.w16,
                          height: ManagerHeight.h16,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: ManagerColors.primaryColor,
                          ),
                        )
                      : GestureDetector(
                          onTap: controller.clearHistory,
                          child: Text(
                            ManagerStrings.searchClearAll,
                            style: getRegularTextStyle(
                              fontSize: ManagerFontSize.s12,
                              color: ManagerColors.primaryColor,
                            ),
                          ),
                        )),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: ManagerWidth.w16,
                  vertical: ManagerHeight.h4,
                ),
                itemCount: items.length,
                separatorBuilder: (_, __) =>
                    Divider(height: 1, color: ManagerColors.bariarColor),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return _HistoryItemTile(
                    query: item.query,
                    onTap: () => controller.fillFromHistory(item.query),
                    onDelete: () => controller.deleteHistoryItem(item.id),
                  );
                },
              ),
            ),
          ] else
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.history_rounded,
                      size: ManagerWidth.w56,
                      color: ManagerColors.greyWhiteColor,
                    ),
                    SizedBox(height: ManagerHeight.h12),
                    Text(
                      ManagerStrings.searchHistoryTitle,
                      style: getRegularTextStyle(
                        fontSize: ManagerFontSize.s14,
                        color: ManagerColors.greyWhiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      );
    });
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Results View
// ═══════════════════════════════════════════════════════════════════════════════

class SearchResultsView extends StatelessWidget {
  final SearchController controller;

  const SearchResultsView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isSearching.value) {
        return _ResultsShimmer();
      }
      final results = controller.results.value;
      if (results == null) return const SizedBox.shrink();

      // Use actual list lengths — API globalCounts can return stale/unrelated totals
      final productCount = results.products.length;
      final shopCount = results.shops.length;
      final tailorCount = results.tailors.length;
      final total = productCount + shopCount + tailorCount;
      final displayCounts = SearchCountsModel(
        products: productCount,
        shops: shopCount,
        tailors: tailorCount,
        total: total,
      );

      return Column(
        children: [
          // Filter chips
          SearchFilterChips(
            controller: controller,
            globalCounts: displayCounts,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w16,
              vertical: ManagerHeight.h8,
            ),
            child: Row(
              children: [
                Text(
                  '$total',
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s14,
                    color: ManagerColors.primaryColor,
                  ),
                ),
                SizedBox(width: ManagerWidth.w4),
                Text(
                  ManagerStrings.searchResultsCount,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s13,
                    color: ManagerColors.greyWhiteColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: total == 0
                ? _EmptySearchResult()
                : _ResultsList(controller: controller),
          ),
        ],
      );
    });
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Filter Chips
// ═══════════════════════════════════════════════════════════════════════════════

class SearchFilterChips extends StatelessWidget {
  final SearchController controller;
  final SearchCountsModel globalCounts;

  const SearchFilterChips({
    super.key,
    required this.controller,
    required this.globalCounts,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selected = controller.selectedType.value;
      return SizedBox(
        height: ManagerHeight.h44,
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: ManagerWidth.w16,
            vertical: ManagerHeight.h6,
          ),
          scrollDirection: Axis.horizontal,
          children: [
            _TypeChip(
              label: ManagerStrings.searchFilterAll,
              count: globalCounts.total,
              isSelected: selected == SearchType.all,
              onTap: () => controller.selectType(SearchType.all),
            ),
            SizedBox(width: ManagerWidth.w8),
            _TypeChip(
              label: ManagerStrings.searchFilterProducts,
              count: globalCounts.products,
              isSelected: selected == SearchType.products,
              onTap: () => controller.selectType(SearchType.products),
            ),
            SizedBox(width: ManagerWidth.w8),
            _TypeChip(
              label: ManagerStrings.searchFilterShops,
              count: globalCounts.shops,
              isSelected: selected == SearchType.shops,
              onTap: () => controller.selectType(SearchType.shops),
            ),
            SizedBox(width: ManagerWidth.w8),
            _TypeChip(
              label: ManagerStrings.searchFilterTailors,
              count: globalCounts.tailors,
              isSelected: selected == SearchType.tailors,
              onTap: () => controller.selectType(SearchType.tailors),
            ),
          ],
        ),
      );
    });
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Results List
// ═══════════════════════════════════════════════════════════════════════════════

class _ResultsList extends StatelessWidget {
  final SearchController controller;

  const _ResultsList({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selectedType = controller.selectedType.value;
      final products = controller.filteredProducts;
      final shops = controller.filteredShops;
      final tailors = controller.filteredTailors;

      final List<Widget> items = [];

      if ((selectedType == SearchType.all || selectedType == SearchType.products) &&
          products.isNotEmpty) {
        if (selectedType == SearchType.all) {
          items.add(_SectionHeader(label: ManagerStrings.searchFilterProducts));
        }
        items.addAll(products.asMap().entries.map((e) => _AnimatedListItem(
              index: e.key,
              child: SearchProductCard(product: e.value),
            )));
      }

      if ((selectedType == SearchType.all || selectedType == SearchType.shops) &&
          shops.isNotEmpty) {
        if (selectedType == SearchType.all) {
          items.add(_SectionHeader(label: ManagerStrings.searchFilterShops));
        }
        items.addAll(shops.asMap().entries.map((e) => _AnimatedListItem(
              index: products.length + e.key,
              child: SearchShopCard(shop: e.value),
            )));
      }

      if ((selectedType == SearchType.all || selectedType == SearchType.tailors) &&
          tailors.isNotEmpty) {
        if (selectedType == SearchType.all) {
          items.add(_SectionHeader(label: ManagerStrings.searchFilterTailors));
        }
        items.addAll(tailors.asMap().entries.map((e) => _AnimatedListItem(
              index: products.length + shops.length + e.key,
              child: SearchTailorCard(tailor: e.value),
            )));
      }

      if (items.isEmpty) return _EmptySearchResult();

      return ListView(
        padding: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w16,
          vertical: ManagerHeight.h4,
        ),
        children: [
          ...items,
          SizedBox(height: ManagerHeight.h16),
        ],
      );
    });
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Section Header
// ═══════════════════════════════════════════════════════════════════════════════

class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: ManagerHeight.h4,
        bottom: ManagerHeight.h8,
      ),
      child: Row(
        children: [
          Container(
            width: 3,
            height: ManagerHeight.h16,
            decoration: BoxDecoration(
              color: ManagerColors.primaryColor,
              borderRadius: BorderRadius.circular(ManagerRadius.r2),
            ),
          ),
          SizedBox(width: ManagerWidth.w8),
          Text(
            label,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s13,
              color: ManagerColors.black,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Product Card
// ═══════════════════════════════════════════════════════════════════════════════

class SearchProductCard extends StatelessWidget {
  final SearchProductModel product;

  const SearchProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final hasDiscount = product.priceBeforeDiscount != null &&
        product.priceBeforeDiscount! > product.price;
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        Routes.productDetailsScreen,
        arguments: product.id,
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: ManagerHeight.h10),
        decoration: BoxDecoration(
          color: ManagerColors.white,
          borderRadius: BorderRadius.circular(ManagerRadius.r14),
          boxShadow: [
            BoxShadow(
              color: ManagerColors.black.withOpacity(0.07),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with best-seller overlay
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(ManagerRadius.r14),
                    bottomRight: Radius.circular(ManagerRadius.r14),
                  ),
                  child: _productImage(product.imageUrl),
                ),
                if (product.isBestSelling)
                  Positioned(
                    top: ManagerHeight.h6,
                    right: ManagerWidth.w6,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ManagerWidth.w6,
                        vertical: ManagerHeight.h2,
                      ),
                      decoration: BoxDecoration(
                        color: ManagerColors.secondaryColor,
                        borderRadius: BorderRadius.circular(ManagerRadius.r4),
                      ),
                      child: Text(
                        ManagerStrings.searchBestSeller,
                        style: getBoldTextStyle(
                          fontSize: ManagerFontSize.s9,
                          color: ManagerColors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            // Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ManagerWidth.w12,
                  vertical: ManagerHeight.h10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s13,
                        color: ManagerColors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (product.shopName != null) ...[
                      SizedBox(height: ManagerHeight.h5),
                      Row(
                        children: [
                          Icon(
                            Icons.storefront_outlined,
                            size: ManagerWidth.w12,
                            color: ManagerColors.greyWhiteColor,
                          ),
                          SizedBox(width: ManagerWidth.w3),
                          Flexible(
                            child: Text(
                              product.shopName!,
                              style: getRegularTextStyle(
                                fontSize: ManagerFontSize.s11,
                                color: ManagerColors.greyWhiteColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                    SizedBox(height: ManagerHeight.h8),
                    // Price row + arrow
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${product.price.toStringAsFixed(0)} ${ManagerStrings.allProductsCurrency}',
                                style: getBoldTextStyle(
                                  fontSize: ManagerFontSize.s14,
                                  color: ManagerColors.primaryColor,
                                ),
                              ),
                              if (hasDiscount)
                                Text(
                                  '${product.priceBeforeDiscount!.toStringAsFixed(0)} ${ManagerStrings.allProductsCurrency}',
                                  style: getRegularTextStyle(
                                    fontSize: ManagerFontSize.s11,
                                    color: ManagerColors.greyWhiteColor,
                                  ).copyWith(
                                      decoration: TextDecoration.lineThrough),
                                ),
                            ],
                          ),
                        ),
                        Container(
                          width: ManagerWidth.w28,
                          height: ManagerWidth.w28,
                          decoration: BoxDecoration(
                            color: ManagerColors.primaryColor.withOpacity(0.08),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: ManagerFontSize.s12,
                            color: ManagerColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _productImage(String? url) {
    if (url != null && url.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: url,
        width: ManagerWidth.w96,
        height: ManagerHeight.h96,
        fit: BoxFit.cover,
        errorWidget: (_, __, ___) => _placeholderBox(),
      );
    }
    return _placeholderBox();
  }

  Widget _placeholderBox() => Container(
        width: ManagerWidth.w96,
        height: ManagerHeight.h96,
        color: ManagerColors.backgroundTabBar,
        child: Icon(
          Icons.checkroom_rounded,
          color: ManagerColors.greyWhiteColor,
          size: ManagerWidth.w32,
        ),
      );
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Shop Card
// ═══════════════════════════════════════════════════════════════════════════════

class SearchShopCard extends StatelessWidget {
  final SearchShopModel shop;

  const SearchShopCard({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        Routes.detailsShop,
        arguments: shop.id,
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: ManagerHeight.h10),
        decoration: BoxDecoration(
          color: ManagerColors.white,
          borderRadius: BorderRadius.circular(ManagerRadius.r14),
          boxShadow: [
            BoxShadow(
              color: ManagerColors.black.withOpacity(0.07),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Logo
            Container(
              margin: EdgeInsets.all(ManagerWidth.w10),
              width: ManagerWidth.w72,
              height: ManagerWidth.w72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ManagerRadius.r10),
                color: ManagerColors.backgroundTabBar,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(ManagerRadius.r10),
                child: _shopImage(shop.imageUrl),
              ),
            ),
            // Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: ManagerHeight.h12,
                  horizontal: ManagerWidth.w4,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            shop.name,
                            style: getBoldTextStyle(
                              fontSize: ManagerFontSize.s13,
                              color: ManagerColors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: ManagerWidth.w4),
                          padding: EdgeInsets.symmetric(
                            horizontal: ManagerWidth.w6,
                            vertical: ManagerHeight.h2,
                          ),
                          decoration: BoxDecoration(
                            color: ManagerColors.primaryColor.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(ManagerRadius.r4),
                          ),
                          child: Text(
                            ManagerStrings.shopBadge,
                            style: getBoldTextStyle(
                              fontSize: ManagerFontSize.s9,
                              color: ManagerColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ManagerHeight.h5),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: ManagerColors.secondaryColor,
                          size: ManagerWidth.w14,
                        ),
                        SizedBox(width: ManagerWidth.w3),
                        Text(
                          shop.rating.toStringAsFixed(1),
                          style: getBoldTextStyle(
                            fontSize: ManagerFontSize.s12,
                            color: ManagerColors.black,
                          ),
                        ),
                        SizedBox(width: ManagerWidth.w3),
                        Text(
                          '(${shop.ratersCount})',
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s11,
                            color: ManagerColors.greyWhiteColor,
                          ),
                        ),
                      ],
                    ),
                    if (shop.location != null) ...[
                      SizedBox(height: ManagerHeight.h4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: ManagerWidth.w12,
                            color: ManagerColors.greyWhiteColor,
                          ),
                          SizedBox(width: ManagerWidth.w3),
                          Flexible(
                            child: Text(
                              shop.location!,
                              style: getRegularTextStyle(
                                fontSize: ManagerFontSize.s11,
                                color: ManagerColors.greyWhiteColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            // Arrow button
            Container(
              margin: EdgeInsets.only(
                left: ManagerWidth.w12,
                right: ManagerWidth.w4,
              ),
              width: ManagerWidth.w28,
              height: ManagerWidth.w28,
              decoration: BoxDecoration(
                color: ManagerColors.primaryColor.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: ManagerFontSize.s12,
                color: ManagerColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _shopImage(String? url) {
    if (url != null && url.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: url,
        width: ManagerWidth.w72,
        height: ManagerWidth.w72,
        fit: BoxFit.cover,
        errorWidget: (_, __, ___) => _placeholderBox(),
      );
    }
    return _placeholderBox();
  }

  Widget _placeholderBox() => Container(
        width: ManagerWidth.w72,
        height: ManagerWidth.w72,
        color: ManagerColors.backgroundTabBar,
        child: Icon(
          Icons.storefront_rounded,
          color: ManagerColors.greyWhiteColor,
          size: ManagerWidth.w32,
        ),
      );
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Tailor Card
// ═══════════════════════════════════════════════════════════════════════════════

class SearchTailorCard extends StatelessWidget {
  final SearchTailorModel tailor;

  const SearchTailorCard({super.key, required this.tailor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        Routes.tailorDetailsScreen,
        arguments: tailor.id,
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: ManagerHeight.h10),
        decoration: BoxDecoration(
          color: ManagerColors.white,
          borderRadius: BorderRadius.circular(ManagerRadius.r14),
          boxShadow: [
            BoxShadow(
              color: ManagerColors.black.withOpacity(0.07),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar with green ring
            Padding(
              padding: EdgeInsets.all(ManagerWidth.w10),
              child: Container(
                width: ManagerWidth.w68,
                height: ManagerWidth.w68,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ManagerColors.primaryColor.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: _tailorAvatar(tailor.imageUrl),
                ),
              ),
            ),
            // Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ManagerWidth.w4,
                  vertical: ManagerHeight.h10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name + rank badge
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            tailor.name,
                            style: getBoldTextStyle(
                              fontSize: ManagerFontSize.s13,
                              color: ManagerColors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (tailor.rankLabel != null)
                          Container(
                            margin: EdgeInsets.only(left: ManagerWidth.w4),
                            padding: EdgeInsets.symmetric(
                              horizontal: ManagerWidth.w6,
                              vertical: ManagerHeight.h2,
                            ),
                            decoration: BoxDecoration(
                              color: ManagerColors.secondaryColor.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(ManagerRadius.r4),
                            ),
                            child: Text(
                              tailor.rankLabel!,
                              style: getBoldTextStyle(
                                fontSize: ManagerFontSize.s9,
                                color: ManagerColors.secondaryColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: ManagerHeight.h5),
                    // Rating
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: ManagerColors.secondaryColor,
                          size: ManagerWidth.w14,
                        ),
                        SizedBox(width: ManagerWidth.w3),
                        Text(
                          tailor.rating.toStringAsFixed(1),
                          style: getBoldTextStyle(
                            fontSize: ManagerFontSize.s12,
                            color: ManagerColors.black,
                          ),
                        ),
                        SizedBox(width: ManagerWidth.w3),
                        Text(
                          '(${tailor.ratersCount})',
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s11,
                            color: ManagerColors.greyWhiteColor,
                          ),
                        ),
                      ],
                    ),
                    // Specializations
                    if (tailor.specializations.isNotEmpty) ...[
                      SizedBox(height: ManagerHeight.h6),
                      Wrap(
                        spacing: ManagerWidth.w4,
                        runSpacing: ManagerHeight.h4,
                        children: tailor.specializations
                            .take(3)
                            .map(
                              (s) => Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: ManagerWidth.w7,
                                  vertical: ManagerHeight.h2,
                                ),
                                decoration: BoxDecoration(
                                  color: ManagerColors.backgroundTabBar,
                                  borderRadius:
                                      BorderRadius.circular(ManagerRadius.r4),
                                  border: Border.all(
                                      color: ManagerColors.bariarColor),
                                ),
                                child: Text(
                                  s,
                                  style: getRegularTextStyle(
                                    fontSize: ManagerFontSize.s10,
                                    color: ManagerColors.black,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            // Arrow button
            Container(
              margin: EdgeInsets.only(
                left: ManagerWidth.w12,
                right: ManagerWidth.w4,
              ),
              width: ManagerWidth.w28,
              height: ManagerWidth.w28,
              decoration: BoxDecoration(
                color: ManagerColors.primaryColor.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: ManagerFontSize.s12,
                color: ManagerColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tailorAvatar(String? url) {
    if (url != null && url.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: url,
        width: ManagerWidth.w68,
        height: ManagerWidth.w68,
        fit: BoxFit.cover,
        errorWidget: (_, __, ___) => _placeholderAvatar(),
      );
    }
    return _placeholderAvatar();
  }

  Widget _placeholderAvatar() => Container(
        width: ManagerWidth.w68,
        height: ManagerWidth.w68,
        color: ManagerColors.backgroundTabBar,
        child: Icon(
          Icons.person_rounded,
          color: ManagerColors.greyWhiteColor,
          size: ManagerWidth.w32,
        ),
      );
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── History Item Tile
// ═══════════════════════════════════════════════════════════════════════════════

class _HistoryItemTile extends StatelessWidget {
  final String query;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _HistoryItemTile({
    required this.query,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ManagerRadius.r8),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: ManagerHeight.h12),
        child: Row(
          children: [
            Icon(
              Icons.history_rounded,
              color: ManagerColors.greyWhiteColor,
              size: ManagerWidth.w20,
            ),
            SizedBox(width: ManagerWidth.w10),
            Expanded(
              child: Text(
                query,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s13,
                  color: ManagerColors.black,
                ),
              ),
            ),
            GestureDetector(
              onTap: onDelete,
              child: Icon(
                Icons.close_rounded,
                color: ManagerColors.greyWhiteColor,
                size: ManagerWidth.w18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Type Filter Chip
// ═══════════════════════════════════════════════════════════════════════════════

class _TypeChip extends StatelessWidget {
  final String label;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  const _TypeChip({
    required this.label,
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w12,
          vertical: ManagerHeight.h6,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? ManagerColors.primaryColor
              : ManagerColors.white,
          borderRadius: BorderRadius.circular(ManagerRadius.r20),
          border: Border.all(
            color: isSelected
                ? ManagerColors.primaryColor
                : ManagerColors.bariarColor,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s12,
                color: isSelected
                    ? ManagerColors.white
                    : ManagerColors.black,
              ),
            ),
            if (count > 0) ...[
              SizedBox(width: ManagerWidth.w4),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ManagerWidth.w5,
                  vertical: ManagerHeight.h1,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? ManagerColors.white.withOpacity(0.25)
                      : ManagerColors.primaryColor.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(ManagerRadius.r10),
                ),
                child: Text(
                  '$count',
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s10,
                    color: isSelected
                        ? ManagerColors.white
                        : ManagerColors.primaryColor,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Empty State
// ═══════════════════════════════════════════════════════════════════════════════

class _EmptySearchResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: ManagerWidth.w64,
            color: ManagerColors.greyWhiteColor,
          ),
          SizedBox(height: ManagerHeight.h14),
          Text(
            ManagerStrings.searchEmptyTitle,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s16,
              color: ManagerColors.black,
            ),
          ),
          SizedBox(height: ManagerHeight.h8),
          Text(
            ManagerStrings.searchEmptySubtitle,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s13,
              color: ManagerColors.greyWhiteColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Shimmer — History
// ═══════════════════════════════════════════════════════════════════════════════

class _HistoryShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ManagerWidth.w16, vertical: ManagerHeight.h16),
        child: Column(
          children: List.generate(
              5,
              (i) => Padding(
                    padding:
                        EdgeInsets.only(bottom: ManagerHeight.h16),
                    child: Container(
                      height: ManagerHeight.h20,
                      color: Colors.white,
                    ),
                  )),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Shimmer — Results
// ═══════════════════════════════════════════════════════════════════════════════

class _ResultsShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: EdgeInsets.all(ManagerWidth.w16),
        child: Column(
          children: List.generate(
              4,
              (i) => Padding(
                    padding:
                        EdgeInsets.only(bottom: ManagerHeight.h12),
                    child: Container(
                      height: ManagerHeight.h90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(ManagerRadius.r12),
                      ),
                    ),
                  )),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Animated List Item
// ═══════════════════════════════════════════════════════════════════════════════

class _AnimatedListItem extends StatefulWidget {
  final int index;
  final Widget child;

  const _AnimatedListItem({required this.index, required this.child});

  @override
  State<_AnimatedListItem> createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<_AnimatedListItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<Offset> _slideAnim;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300 + widget.index * 50),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    ));
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(_animController);
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(position: _slideAnim, child: widget.child),
    );
  }
}
