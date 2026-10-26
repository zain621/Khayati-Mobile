import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/base_app_scaffold.dart';
import '../../domain/model/cart_model.dart';
import '../controller/cart_controller.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// ── Cart Screen
// ═══════════════════════════════════════════════════════════════════════════════
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();
    final discountController = TextEditingController();

    return Obx(() {
      final cart = controller.cart.value;
      final isLoading = controller.isLoading.value;
      final isCheckingOut = controller.isCheckingOut.value;
      final shops = cart?.shops ?? [];

      return Stack(
        children: [
          BaseAppScaffold(
            title: ManagerStrings.cartTitle,
            subtitle: isLoading
                ? null
                : '${cart?.totalItemCount ?? 0} ${ManagerStrings.cartItemCount}',
            onRefresh: controller.refreshCart,
            child: isLoading
                ? const _CartShimmer()
                : shops.isEmpty
                    ? _buildEmptyState(context)
                    : _buildCartContent(
                        context: context,
                        controller: controller,
                        cart: cart!,
                        discountController: discountController,
                      ),
          ),

          // ── Bottom Actions (fixed) ───────────────────────────────────
          if (!isLoading && shops.isNotEmpty)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _BottomActions(
                total: cart!.grandTotalAfterDiscount > 0
                    ? cart.grandTotalAfterDiscount
                    : cart.grandTotal,
                isCheckingOut: isCheckingOut,
                onContinueShopping: () => Navigator.pop(context),
                onCheckout: () => controller.checkout(),
              ),
            ),

          if (isCheckingOut)
            Positioned.fill(
              child: AbsorbPointer(
                child: Container(
                  color: ManagerColors.black.withOpacity(0.35),
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ManagerWidth.w20,
                      vertical: ManagerHeight.h16,
                    ),
                    decoration: BoxDecoration(
                      color: ManagerColors.white,
                      borderRadius: BorderRadius.circular(ManagerRadius.r12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: ManagerWidth.w18,
                          height: ManagerHeight.h18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: ManagerColors.primaryColor,
                          ),
                        ),
                        SizedBox(width: ManagerWidth.w10),
                        Text(
                          ManagerStrings.managerProductsActionLoading,
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s13,
                            color: ManagerColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }

  Widget _buildCartContent({
    required BuildContext context,
    required CartController controller,
    required CartModel cart,
    required TextEditingController discountController,
  }) {
    return Column(
      children: [
        SizedBox(height: ManagerHeight.h12),

        // ── Store sections ─────────────────────────────────────────────
        ...cart.shops.asMap().entries.map((entry) {
          final index = entry.key;
          final shop = entry.value;
          return Obx(
            () => _StoreSection(
              shop: shop,
              isExpanded: controller.isShopExpanded(shop.shopId),
              onToggleExpand: () => controller.toggleShopExpand(shop.shopId),
              storeIndex: index,
              isActionLoading: controller.isActionLoading.value,
              onIncrement: (item) => controller.incrementQty(item),
              onDecrement: (item) => controller.decrementQty(item),
              onRemove: (item) => controller.removeItem(item.cartItemId),
              onChat: () {
                // TODO: Navigate to chat with shop
              },
            ),
          );
        }),

        // ── Discount code ──────────────────────────────────────────────
        Obx(
          () => _DiscountCodeSection(
            controller: discountController,
            hasCoupon: cart.hasCoupon,
            couponCode: cart.couponCode,
            isLoading: controller.isActionLoading.value,
            onApply: () => controller.applyCoupon(discountController.text),
            onRemove: controller.removeCoupon,
          ),
        ),

        SizedBox(height: ManagerHeight.h16),

        // ── Order summary ──────────────────────────────────────────────
        _OrderSummarySection(
          subtotal: cart.grandTotal,
          itemCount: cart.totalItemCount,
          shippingFees: 0,
          storeCount: cart.shops.length,
          discountAmount: cart.discountAmount,
          total: cart.grandTotalAfterDiscount > 0
              ? cart.grandTotalAfterDiscount
              : cart.grandTotal,
        ),

        SizedBox(height: ManagerHeight.h90),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 64,
            color: ManagerColors.greyWhiteColor.withOpacity(0.4),
          ),
          SizedBox(height: ManagerHeight.h16),
          Text(
            ManagerStrings.cartEmpty,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s16,
              color: ManagerColors.greyWhiteColor,
            ),
          ),
          SizedBox(height: ManagerHeight.h8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w40),
            child: Text(
              ManagerStrings.cartEmptyDesc,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s13,
                color: ManagerColors.greyWhiteColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Shimmer Skeleton
// ═══════════════════════════════════════════════════════════════════════════════

class _CartShimmer extends StatelessWidget {
  const _CartShimmer();

  static const Color _base = Color(0xFFE0E0E0);
  static const Color _highlight = Color(0xFFF5F5F5);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _base,
      highlightColor: _highlight,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: ManagerHeight.h12),
            _buildStoreGroupSkeleton(),
            SizedBox(height: ManagerHeight.h12),
            _buildStoreGroupSkeleton(productCount: 1),
            SizedBox(height: ManagerHeight.h16),
            _buildBoxSkeleton(height: ManagerHeight.h90),
            SizedBox(height: ManagerHeight.h16),
            _buildBoxSkeleton(height: ManagerHeight.h200),
            SizedBox(height: ManagerHeight.h90),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreGroupSkeleton({int productCount = 2}) {
    return Padding(
      padding: EdgeInsets.only(bottom: ManagerHeight.h12),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
            height: ManagerHeight.h56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(ManagerRadius.r12),
            ),
          ),
          SizedBox(height: ManagerHeight.h8),
          for (int i = 0; i < productCount; i++) ...[
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: ManagerWidth.w16,
                vertical: ManagerHeight.h4,
              ),
              height: ManagerHeight.h100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ManagerRadius.r12),
              ),
            ),
          ],
          Container(
            margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
            height: ManagerHeight.h42,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(ManagerRadius.r10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBoxSkeleton({required double height}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Store Section (header + collapsible products + subtotal)
// ═══════════════════════════════════════════════════════════════════════════════

class _StoreSection extends StatefulWidget {
  final CartShopModel shop;
  final bool isExpanded;
  final VoidCallback onToggleExpand;
  final int storeIndex;
  final bool isActionLoading;
  final ValueChanged<CartItemModel> onIncrement;
  final ValueChanged<CartItemModel> onDecrement;
  final ValueChanged<CartItemModel> onRemove;
  final VoidCallback onChat;

  const _StoreSection({
    required this.shop,
    required this.isExpanded,
    required this.onToggleExpand,
    required this.storeIndex,
    required this.isActionLoading,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
    required this.onChat,
  });

  @override
  State<_StoreSection> createState() => _StoreSectionState();
}

class _StoreSectionState extends State<_StoreSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _expandAnimation;
  late Animation<double> _chevronAnimation;
  late Animation<double> _overviewOpacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
      value: widget.isExpanded ? 1.0 : 0.0,
    );

    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );

    _chevronAnimation = Tween<double>(begin: 0.0, end: math.pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );

    _overviewOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
        reverseCurve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant _StoreSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      if (widget.isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: ManagerHeight.h12),
      child: Column(
        children: [
          // ── Store Header ──────────────────────────────────────────────
          GestureDetector(
            onTap: widget.onToggleExpand,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
              padding: EdgeInsets.symmetric(
                horizontal: ManagerWidth.w14,
                vertical: ManagerHeight.h12,
              ),
              decoration: BoxDecoration(
                color: ManagerColors.primaryColor,
                borderRadius: BorderRadius.circular(ManagerRadius.r12),
              ),
              child: Row(
                children: [
                  // Chevron with rotation animation
                  AnimatedBuilder(
                    animation: _chevronAnimation,
                    builder: (_, child) => Transform.rotate(
                      angle: _chevronAnimation.value,
                      child: child,
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_up_rounded,
                      color: ManagerColors.white,
                      size: ManagerWidth.w20,
                    ),
                  ),

                  SizedBox(width: ManagerWidth.w8),

                  // Store avatar
                  Container(
                    width: ManagerWidth.w32,
                    height: ManagerHeight.h32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ManagerColors.white.withOpacity(0.2),
                    ),
                    child: Icon(Icons.store_rounded,
                        color: ManagerColors.white, size: ManagerWidth.w18),
                  ),
                  SizedBox(width: ManagerWidth.w10),

                  // Store name + count
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.shop.name,
                          style: getBoldTextStyle(
                            fontSize: ManagerFontSize.s13,
                            color: ManagerColors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: ManagerHeight.h2),
                        Text(
                          '${widget.shop.items.length} ${ManagerStrings.cartStoreProducts}',
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s11,
                            color: ManagerColors.white.withOpacity(0.75),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Chat icon
                  GestureDetector(
                    onTap: widget.onChat,
                    child: Container(
                      width: ManagerWidth.w32,
                      height: ManagerHeight.h32,
                      decoration: BoxDecoration(
                        color: ManagerColors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(ManagerRadius.r8),
                      ),
                      child: Icon(
                        Icons.chat_bubble_outline_rounded,
                        color: ManagerColors.white,
                        size: ManagerWidth.w16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: ManagerHeight.h8),

          // ── Collapsed Overview (visible when collapsed) ───────────────
          FadeTransition(
            opacity: _overviewOpacity,
            child: SizeTransition(
              sizeFactor: ReverseAnimation(_expandAnimation),
              axisAlignment: -1.0,
              child: _CollapsedOverview(shop: widget.shop),
            ),
          ),

          // ── Expanded Content (products list) ──────────────────────────
          SizeTransition(
            sizeFactor: _expandAnimation,
            axisAlignment: -1.0,
            child: FadeTransition(
              opacity: _expandAnimation,
              child: Column(
                children: [
                  // Products with staggered entrance
                  ...widget.shop.items.asMap().entries.map((entry) {
                    final productIndex = entry.key;
                    final item = entry.value;
                    return _AnimatedCartProductCard(
                      item: item,
                      delayMs: productIndex * 80,
                      isActionLoading: widget.isActionLoading,
                      onIncrement: () => widget.onIncrement(item),
                      onDecrement: () => widget.onDecrement(item),
                      onRemove: () => widget.onRemove(item),
                    );
                  }),
                ],
              ),
            ),
          ),

          // ── Store Subtotal ────────────────────────────────────────────
          Container(
            margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
            padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w14,
              vertical: ManagerHeight.h12,
            ),
            decoration: BoxDecoration(
              color: ManagerColors.white,
              borderRadius: BorderRadius.circular(ManagerRadius.r10),
              border: Border.all(
                color: ManagerColors.greyWhiteColor.withOpacity(0.12),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                  color: ManagerColors.primaryColor,
                  size: ManagerWidth.w18,
                ),
                SizedBox(width: ManagerWidth.w8),
                Text(
                  ManagerStrings.cartStoreSubtotal,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s12,
                    color: ManagerColors.greyWhiteColor,
                  ),
                ),
                const Spacer(),
                Text(
                  '${widget.shop.subtotal.toStringAsFixed(0)} ${ManagerStrings.cartCurrency}',
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s14,
                    color: ManagerColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Collapsed Overview (compact summary when store is collapsed)
// ═══════════════════════════════════════════════════════════════════════════════

class _CollapsedOverview extends StatelessWidget {
  final CartShopModel shop;

  const _CollapsedOverview({required this.shop});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w14,
        vertical: ManagerHeight.h12,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        border: Border.all(
          color: ManagerColors.primaryColor.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          // ── Product thumbnails (stacked) ─────────────────────────────
          SizedBox(
            width: ManagerWidth.w40 +
                (math.min(shop.items.length - 1, 2) * ManagerWidth.w14),
            height: ManagerHeight.h40,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                ...shop.items.take(3).toList().asMap().entries.map(
                  (entry) {
                    final i = entry.key;
                    final item = entry.value;
                    return Positioned(
                      left: i * ManagerWidth.w14,
                      child: Container(
                        width: ManagerWidth.w40,
                        height: ManagerHeight.h40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(ManagerRadius.r8),
                          border: Border.all(
                            color: ManagerColors.white,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: ManagerColors.black.withOpacity(0.08),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(ManagerRadius.r6),
                          child: CachedNetworkImage(
                            imageUrl: item.imageUrl,
                            fit: BoxFit.cover,
                            placeholder: (_, __) => Container(
                              color:
                                  ManagerColors.greyWhiteColor.withOpacity(0.1),
                            ),
                            errorWidget: (_, __, ___) => Container(
                              color:
                                  ManagerColors.greyWhiteColor.withOpacity(0.1),
                              child: Icon(
                                Icons.image_outlined,
                                size: ManagerWidth.w16,
                                color: ManagerColors.greyWhiteColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          SizedBox(width: ManagerWidth.w12),

          // ── Summary text ──────────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${shop.items.length} ${ManagerStrings.cartProductCount}',
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s12,
                    color: ManagerColors.black,
                  ),
                ),
                SizedBox(height: ManagerHeight.h2),
                Text(
                  shop.items.map((p) => p.name).join(', '),
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s11,
                    color: ManagerColors.greyWhiteColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // ── Total badge ───────────────────────────────────────────────
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w10,
              vertical: ManagerHeight.h6,
            ),
            decoration: BoxDecoration(
              color: ManagerColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(ManagerRadius.r8),
            ),
            child: Text(
              '${shop.subtotal.toStringAsFixed(0)} ${ManagerStrings.cartCurrency}',
              style: getBoldTextStyle(
                fontSize: ManagerFontSize.s12,
                color: ManagerColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Animated Product Card (staggered entrance)
// ═══════════════════════════════════════════════════════════════════════════════

class _AnimatedCartProductCard extends StatefulWidget {
  final CartItemModel item;
  final int delayMs;
  final bool isActionLoading;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  const _AnimatedCartProductCard({
    required this.item,
    required this.delayMs,
    required this.isActionLoading,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  @override
  State<_AnimatedCartProductCard> createState() =>
      _AnimatedCartProductCardState();
}

class _AnimatedCartProductCardState extends State<_AnimatedCartProductCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 450),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    Future.delayed(Duration(milliseconds: widget.delayMs), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: _CartProductCard(
            item: widget.item,
            isActionLoading: widget.isActionLoading,
            onIncrement: widget.onIncrement,
            onDecrement: widget.onDecrement,
            onRemove: widget.onRemove,
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Product Card
// ═══════════════════════════════════════════════════════════════════════════════

class _CartProductCard extends StatelessWidget {
  final CartItemModel item;
  final bool isActionLoading;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  const _CartProductCard({
    required this.item,
    required this.isActionLoading,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w16,
        vertical: ManagerHeight.h4,
      ),
      padding: EdgeInsets.all(ManagerWidth.w12),
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Product info (right side in RTL) ──────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  item.name,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s13,
                    color: ManagerColors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: ManagerHeight.h4),

                // Details (color, size)
                Row(
                  children: [
                    if (item.color != null) ...[
                      Text(
                        '${ManagerStrings.cartColor}: ${item.color}',
                        style: getRegularTextStyle(
                          fontSize: ManagerFontSize.s11,
                          color: ManagerColors.greyWhiteColor,
                        ),
                      ),
                      if (item.size != null)
                        Text(
                          ' / ',
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s11,
                            color: ManagerColors.greyWhiteColor,
                          ),
                        ),
                    ],
                    if (item.size != null)
                      Text(
                        '${ManagerStrings.cartSize}: ${item.size}',
                        style: getRegularTextStyle(
                          fontSize: ManagerFontSize.s11,
                          color: ManagerColors.greyWhiteColor,
                        ),
                      ),
                  ],
                ),

                SizedBox(height: ManagerHeight.h10),

                // Price + quantity controls row
                Row(
                  children: [
                    // Delete button
                    GestureDetector(
                      onTap: isActionLoading ? null : onRemove,
                      child: Icon(
                        Icons.delete_outline_rounded,
                        color: isActionLoading
                            ? ManagerColors.greyWhiteColor
                            : const Color(0xFFE53935),
                        size: ManagerWidth.w20,
                      ),
                    ),

                    SizedBox(width: ManagerWidth.w8),

                    // Price
                    Text(
                      '${item.lineTotal.toStringAsFixed(0)} ${ManagerStrings.cartCurrency}',
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s14,
                        color: ManagerColors.primaryColor,
                      ),
                    ),

                    const Spacer(),

                    // Quantity controls
                    _QuantityControls(
                      quantity: item.quantity,
                      isLoading: isActionLoading,
                      onIncrement: onIncrement,
                      onDecrement: onDecrement,
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(width: ManagerWidth.w12),

          // ── Product image (left side in RTL) ────────────────────────
          ClipRRect(
            borderRadius: BorderRadius.circular(ManagerRadius.r10),
            child: CachedNetworkImage(
              imageUrl: item.imageUrl,
              width: ManagerWidth.w80,
              height: ManagerHeight.h90,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(
                width: ManagerWidth.w80,
                height: ManagerHeight.h90,
                color: ManagerColors.greyWhiteColor.withOpacity(0.1),
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                    color: ManagerColors.primaryColor,
                  ),
                ),
              ),
              errorWidget: (_, __, ___) => Container(
                width: ManagerWidth.w80,
                height: ManagerHeight.h90,
                color: ManagerColors.greyWhiteColor.withOpacity(0.1),
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: ManagerColors.greyWhiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Quantity Controls (+, -, count)
// ═══════════════════════════════════════════════════════════════════════════════

class _QuantityControls extends StatelessWidget {
  final int quantity;
  final bool isLoading;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _QuantityControls({
    required this.quantity,
    required this.isLoading,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ManagerColors.greyWhiteColor.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(ManagerRadius.r8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Decrement
          _QuantityButton(
            icon: Icons.remove,
            onTap: isLoading ? null : onDecrement,
          ),

          // Count
          Container(
            constraints: BoxConstraints(minWidth: ManagerWidth.w32),
            alignment: Alignment.center,
            child: isLoading
                ? SizedBox(
                    width: ManagerWidth.w14,
                    height: ManagerHeight.h14,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      color: ManagerColors.primaryColor,
                    ),
                  )
                : Text(
                    '$quantity',
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s14,
                      color: ManagerColors.black,
                    ),
                  ),
          ),

          // Increment
          _QuantityButton(
            icon: Icons.add,
            onTap: isLoading ? null : onIncrement,
            isPrimary: true,
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool isPrimary;

  const _QuantityButton({
    required this.icon,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: ManagerWidth.w30,
        height: ManagerHeight.h30,
        decoration: BoxDecoration(
          color: isPrimary
              ? (onTap == null
                  ? ManagerColors.primaryColor.withOpacity(0.4)
                  : ManagerColors.primaryColor)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(ManagerRadius.r6),
        ),
        child: Icon(
          icon,
          size: ManagerWidth.w16,
          color: isPrimary ? ManagerColors.white : ManagerColors.greyWhiteColor,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Discount Code Section
// ═══════════════════════════════════════════════════════════════════════════════

class _DiscountCodeSection extends StatelessWidget {
  final TextEditingController controller;
  final bool hasCoupon;
  final String? couponCode;
  final bool isLoading;
  final VoidCallback onApply;
  final VoidCallback onRemove;

  const _DiscountCodeSection({
    required this.controller,
    required this.hasCoupon,
    required this.couponCode,
    required this.isLoading,
    required this.onApply,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
      padding: EdgeInsets.all(ManagerWidth.w16),
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.qr_code_rounded,
                color: ManagerColors.primaryColor,
                size: ManagerWidth.w20,
              ),
              SizedBox(width: ManagerWidth.w6),
              Text(
                ManagerStrings.cartDiscountCode,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s14,
                  color: ManagerColors.black,
                ),
              ),
            ],
          ),

          // Active coupon badge
          if (hasCoupon) ...[
            SizedBox(height: ManagerHeight.h10),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: ManagerWidth.w12,
                vertical: ManagerHeight.h8,
              ),
              decoration: BoxDecoration(
                color: ManagerColors.primaryColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(ManagerRadius.r8),
                border: Border.all(
                  color: ManagerColors.primaryColor.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_outline_rounded,
                    color: ManagerColors.primaryColor,
                    size: ManagerWidth.w16,
                  ),
                  SizedBox(width: ManagerWidth.w6),
                  Expanded(
                    child: Text(
                      '${ManagerStrings.cartCouponApplied}: $couponCode',
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s12,
                        color: ManagerColors.primaryColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: isLoading ? null : onRemove,
                    child: Icon(
                      Icons.close_rounded,
                      color: ManagerColors.primaryColor,
                      size: ManagerWidth.w16,
                    ),
                  ),
                ],
              ),
            ),
          ],

          if (!hasCoupon) ...[
            SizedBox(height: ManagerHeight.h12),

            // Input + button row
            Row(
              children: [
                // Apply button
                GestureDetector(
                  onTap: isLoading ? null : onApply,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ManagerWidth.w20,
                      vertical: ManagerHeight.h12,
                    ),
                    decoration: BoxDecoration(
                      color: isLoading
                          ? ManagerColors.primaryColor.withOpacity(0.5)
                          : ManagerColors.primaryColor,
                      borderRadius: BorderRadius.circular(ManagerRadius.r8),
                    ),
                    child: isLoading
                        ? SizedBox(
                            width: ManagerWidth.w16,
                            height: ManagerHeight.h16,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                              color: ManagerColors.white,
                            ),
                          )
                        : Text(
                            ManagerStrings.cartDiscountApply,
                            style: getBoldTextStyle(
                              fontSize: ManagerFontSize.s13,
                              color: ManagerColors.white,
                            ),
                          ),
                  ),
                ),

                SizedBox(width: ManagerWidth.w10),

                // Text field
                Expanded(
                  child: Container(
                    height: ManagerHeight.h42,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(ManagerRadius.r8),
                    ),
                    child: TextField(
                      controller: controller,
                      textAlign: TextAlign.right,
                      textDirection: Directionality.of(context),
                      style: getRegularTextStyle(
                        fontSize: ManagerFontSize.s13,
                        color: ManagerColors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: ManagerStrings.cartDiscountHint,
                        hintStyle: getRegularTextStyle(
                          fontSize: ManagerFontSize.s13,
                          color: ManagerColors.greyWhiteColor,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: ManagerWidth.w14,
                          vertical: ManagerHeight.h10,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Order Summary Section
// ═══════════════════════════════════════════════════════════════════════════════

class _OrderSummarySection extends StatelessWidget {
  final double subtotal;
  final int itemCount;
  final double shippingFees;
  final int storeCount;
  final double discountAmount;
  final double total;

  const _OrderSummarySection({
    required this.subtotal,
    required this.itemCount,
    required this.shippingFees,
    required this.storeCount,
    required this.discountAmount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
      padding: EdgeInsets.all(ManagerWidth.w16),
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
      ),
      child: Column(
        children: [
          // ── Header ──────────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.receipt_long_outlined,
                color: ManagerColors.primaryColor,
                size: ManagerWidth.w18,
              ),
              SizedBox(width: ManagerWidth.w6),
              Text(
                ManagerStrings.cartOrderSummary,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s14,
                  color: ManagerColors.black,
                ),
              ),
            ],
          ),

          SizedBox(height: ManagerHeight.h14),

          // ── Subtotal row ────────────────────────────────────────────
          _SummaryRow(
            label:
                '${ManagerStrings.cartSubtotal} ($itemCount ${ManagerStrings.cartItemCount})',
            value:
                '${subtotal.toStringAsFixed(0)} ${ManagerStrings.cartCurrency}',
          ),

          if (shippingFees > 0) ...[
            SizedBox(height: ManagerHeight.h10),

            // ── Shipping row ──────────────────────────────────────────
            _SummaryRow(
              label:
                  '${ManagerStrings.cartShippingFees} ($storeCount ${ManagerStrings.cartStoresShipping})',
              value:
                  '${shippingFees.toStringAsFixed(0)} ${ManagerStrings.cartCurrency}',
            ),
          ],

          if (discountAmount > 0) ...[
            SizedBox(height: ManagerHeight.h10),

            // ── Discount row ──────────────────────────────────────────
            _SummaryRow(
              label: ManagerStrings.cartDiscount,
              value:
                  '- ${discountAmount.toStringAsFixed(0)} ${ManagerStrings.cartCurrency}',
              valueColor: const Color(0xFF2E7D32),
            ),
          ],

          SizedBox(height: ManagerHeight.h14),

          // ── Separate order note ─────────────────────────────────────
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: ManagerHeight.h10,
              horizontal: ManagerWidth.w12,
            ),
            decoration: BoxDecoration(
              color: ManagerColors.primaryColor.withOpacity(0.06),
              borderRadius: BorderRadius.circular(ManagerRadius.r8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: ManagerColors.primaryColor,
                  size: ManagerWidth.w16,
                ),
                SizedBox(width: ManagerWidth.w6),
                Flexible(
                  child: Text(
                    '${ManagerStrings.cartSeparateOrderNote} ($storeCount ${ManagerStrings.cartOrdersCount})',
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s11,
                      color: ManagerColors.primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: ManagerHeight.h14),

          // ── Total row ───────────────────────────────────────────────
          Divider(
            height: 1,
            color: ManagerColors.greyWhiteColor.withOpacity(0.15),
          ),

          SizedBox(height: ManagerHeight.h12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ManagerStrings.cartTotal,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s14,
                  color: ManagerColors.black,
                ),
              ),
              Text(
                '${total.toStringAsFixed(0)} ${ManagerStrings.cartCurrency}',
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s18,
                  color: ManagerColors.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            label,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s12,
              color: ManagerColors.greyWhiteColor,
            ),
            textAlign: TextAlign.end,
          ),
        ),
        Text(
          value,
          style: getBoldTextStyle(
            fontSize: ManagerFontSize.s13,
            color: valueColor ?? ManagerColors.black,
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Bottom Actions (fixed at bottom)
// ═══════════════════════════════════════════════════════════════════════════════

class _BottomActions extends StatelessWidget {
  final double total;
  final bool isCheckingOut;
  final VoidCallback onContinueShopping;
  final VoidCallback onCheckout;

  const _BottomActions({
    required this.total,
    required this.isCheckingOut,
    required this.onContinueShopping,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w16,
        vertical: ManagerHeight.h12,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.white,
        boxShadow: [
          BoxShadow(
            color: ManagerColors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // ── Continue Shopping (outlined) ──────────────────────────
            Expanded(
              child: GestureDetector(
                onTap: onContinueShopping,
                child: Container(
                  height: ManagerHeight.h46,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ManagerColors.primaryColor,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(ManagerRadius.r8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    ManagerStrings.cartContinueShopping,
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s13,
                      color: ManagerColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(width: ManagerWidth.w10),

            // ── Checkout (filled) ────────────────────────────────────
            Expanded(
              child: GestureDetector(
                onTap: isCheckingOut ? null : onCheckout,
                child: Opacity(
                  opacity: isCheckingOut ? 0.7 : 1.0,
                  child: Container(
                    height: ManagerHeight.h46,
                    decoration: BoxDecoration(
                      color: ManagerColors.primaryColor,
                      borderRadius: BorderRadius.circular(ManagerRadius.r8),
                    ),
                    alignment: Alignment.center,
                    child: isCheckingOut
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            '${ManagerStrings.cartCheckout} (${total.toStringAsFixed(0)} ${ManagerStrings.cartCurrency})',
                            style: getBoldTextStyle(
                              fontSize: ManagerFontSize.s12,
                              color: ManagerColors.white,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
