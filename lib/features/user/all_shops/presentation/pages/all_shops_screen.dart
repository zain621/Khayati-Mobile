import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/widgets/base_app_scaffold.dart';
import 'package:app_mobile/features/user/all_shops/presentation/controller/all_shops_controller.dart';
import 'package:app_mobile/features/user/all_shops/presentation/widgets/all_shops_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllShopsScreen extends StatefulWidget {
  const AllShopsScreen({super.key});

  @override
  State<AllShopsScreen> createState() => _AllShopsScreenState();
}

class _AllShopsScreenState extends State<AllShopsScreen> {
  late final AllShopsController _controller;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchTextController = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<AllShopsController>();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
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
      title: ManagerStrings.allShopsTitle,
      subtitle: ManagerStrings.allShopsSubtitle,
      useScrollView: false,
      child: Column(
        children: [
          // ── Search bar ───────────────────────────────────────────────
          _buildSearchBar(),
          // ── Sort chips ───────────────────────────────────────────────
          _buildSortChips(),
          // ── Content area ─────────────────────────────────────────────
          Expanded(
            child: Obx(() {
              if (_controller.isLoading.value) {
                return const AllShopsShimmer();
              }
              if (_controller.errorMessage.value.isNotEmpty &&
                  _controller.shops.isEmpty) {
                return AllShopsErrorState(onRetry: _controller.refreshShops);
              }
              if (_controller.shops.isEmpty) {
                return const AllShopsEmptyState();
              }
              return _buildShopList();
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
            hintText: ManagerStrings.allShopsSearchHint,
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

  Widget _buildSortChips() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w16,
        vertical: ManagerHeight.h10,
      ),
      child: Obx(
        () => Row(
          children: [
            _SortChip(
              label: ManagerStrings.allShopsSortDefault,
              selected: _controller.sortBy.value == '',
              onTap: () => _controller.onSortChanged(''),
            ),
            SizedBox(width: ManagerWidth.w8),
            _SortChip(
              label: ManagerStrings.allShopsSortBestSelling,
              selected: _controller.sortBy.value == 'best_selling',
              onTap: () => _controller.onSortChanged('best_selling'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShopList() {
    return RefreshIndicator(
      color: ManagerColors.primaryColor,
      onRefresh: _controller.refreshShops,
      child: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          Obx(
            () => SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, index) {
                  final shop = _controller.shops[index];
                  return AnimatedShopCard(
                    key: ValueKey(shop.id),
                    index: index,
                    child: AllShopCard(
                      shop: shop,
                      onTap: () => Navigator.pushNamed(
                        context,
                        Routes.detailsShop,
                        arguments: shop.id,
                      ),
                    ),
                  );
                },
                childCount: _controller.shops.length,
              ),
            ),
          ),
          Obx(
            () => SliverToBoxAdapter(
              child: _controller.isLoadingMore.value
                  ? const AllShopsLoadMoreIndicator()
                  : SizedBox(height: ManagerHeight.h20),
            ),
          ),
        ],
      ),
    );
  }
}

class _SortChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const _SortChip(
      {required this.label, required this.selected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w14,
          vertical: ManagerHeight.h8,
        ),
        decoration: BoxDecoration(
          color: selected
              ? ManagerColors.primaryColor
              : ManagerColors.backgroundTabBar,
          borderRadius: BorderRadius.circular(ManagerRadius.r20),
          border: Border.all(
            color: selected
                ? ManagerColors.primaryColor
                : const Color(0xFFDDDDDD),
          ),
        ),
        child: Text(
          label,
          style: getMediumTextStyle(
            fontSize: ManagerFontSize.s12,
            color:
                selected ? ManagerColors.white : ManagerColors.greyWhiteColor,
          ),
        ),
      ),
    );
  }
}

