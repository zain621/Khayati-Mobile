import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/features/user/cart/domain/di/di.dart' as cart_di;
import 'package:app_mobile/features/user/cart/presentation/controller/cart_controller.dart';
import 'package:app_mobile/features/user/product_details/domain/di/di.dart'
    as product_details_di;
import 'package:app_mobile/features/user/product_details/domain/model/product_details_model.dart';
import 'package:app_mobile/features/user/product_details/presentation/controller/product_details_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

/// Shows a bottom sheet for selecting variant + quantity then adding to cart.
Future<void> showAddToCartSheet(
  BuildContext context, {
  required String productId,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _AddToCartSheetBody(productId: productId),
  );
}

// ─────────────────────────────────────────────────────────────────────────────

class _AddToCartSheetBody extends StatefulWidget {
  final String productId;

  const _AddToCartSheetBody({required this.productId});

  @override
  State<_AddToCartSheetBody> createState() => _AddToCartSheetBodyState();
}

class _AddToCartSheetBodyState extends State<_AddToCartSheetBody> {
  late ProductDetailsController _ctrl;

  @override
  void initState() {
    super.initState();
    product_details_di.initProductDetails(productId: widget.productId);
    _ctrl = Get.find<ProductDetailsController>();
    cart_di.initCart();
  }

  @override
  void dispose() {
    product_details_di.disposeProductDetails();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.78,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ManagerRadius.r20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Drag handle ──────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.only(top: ManagerHeight.h12),
            child: Container(
              width: ManagerWidth.w36,
              height: ManagerHeight.h4,
              decoration: BoxDecoration(
                color: ManagerColors.greyWhiteColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(ManagerRadius.r4),
              ),
            ),
          ),

          // ── Content ──────────────────────────────────────────────────
          Flexible(
            child: Obx(() {
              if (_ctrl.isLoading.value) {
                return const _SheetShimmer();
              }
              final product = _ctrl.product.value;
              if (product == null) {
                return Padding(
                  padding: EdgeInsets.all(ManagerWidth.w24),
                  child: Text(
                    ManagerStrings.productDetailsError,
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s14,
                      color: ManagerColors.greyWhiteColor,
                    ),
                  ),
                );
              }
              return _SheetContent(
                ctrl: _ctrl,
                product: product,
                cartController: cartController,
              );
            }),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _SheetContent extends StatelessWidget {
  final ProductDetailsController ctrl;
  final ProductDetailsModel product;
  final CartController cartController;

  const _SheetContent({
    required this.ctrl,
    required this.product,
    required this.cartController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        ManagerWidth.w16,
        ManagerHeight.h12,
        ManagerWidth.w16,
        ManagerHeight.h16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Product header ────────────────────────────────────────────
          _SheetProductHeader(product: product),

          SizedBox(height: ManagerHeight.h16),

          // ── Color selector ────────────────────────────────────────────
          if (product.availableColors.isNotEmpty) ...[
            _SheetSectionTitle(title: ManagerStrings.productDetailsColor),
            SizedBox(height: ManagerHeight.h8),
            Obx(() => _SheetChipRow(
                  items: product.availableColors,
                  selected: ctrl.selectedColor.value,
                  onSelect: ctrl.selectColor,
                )),
            SizedBox(height: ManagerHeight.h14),
          ],

          // ── Size selector ─────────────────────────────────────────────
          Obx(() {
            final sizes = ctrl.availableSizes;
            if (sizes.isEmpty) return const SizedBox.shrink();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SheetSectionTitle(title: ManagerStrings.productDetailsSize),
                SizedBox(height: ManagerHeight.h8),
                Obx(() => _SheetChipRow(
                      items: sizes,
                      selected: ctrl.selectedSize.value,
                      onSelect: ctrl.selectSize,
                    )),
                SizedBox(height: ManagerHeight.h14),
              ],
            );
          }),

          // ── Quantity ──────────────────────────────────────────────────
          Obx(() => _SheetQuantityRow(
                quantity: ctrl.quantity.value,
                onDecrement: ctrl.decrementQty,
                onIncrement: ctrl.incrementQty,
              )),

          SizedBox(height: ManagerHeight.h20),

          // ── Add to cart button ─────────────────────────────────────────
          Obx(() {
            final isLoading = cartController.isActionLoading.value;
            final canAdd = ctrl.canAddToCart && product.isAvailable;
            return GestureDetector(
              onTap: canAdd && !isLoading
                  ? () {
                      final variant = ctrl.selectedVariant;
                      if (variant == null) return;
                      cartController
                          .addToCart(
                            productId: product.id,
                            variantId: variant.id,
                            quantity: ctrl.quantity.value,
                          )
                          .then((ok) {
                        if (!ok) return;
                        Get.back();
                        cartController.openCartAfterAdd();
                      });
                    }
                  : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: ManagerHeight.h50,
                decoration: BoxDecoration(
                  color: (canAdd && !isLoading)
                      ? ManagerColors.primaryColor
                      : ManagerColors.primaryColor.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(ManagerRadius.r12),
                ),
                alignment: Alignment.center,
                child: isLoading
                    ? SizedBox(
                        width: ManagerWidth.w20,
                        height: ManagerHeight.h20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: ManagerColors.white,
                        ),
                      )
                    : Text(
                        !product.isAvailable
                            ? ManagerStrings.productDetailsOutOfStock
                            : !ctrl.canAddToCart
                                ? ManagerStrings.productDetailsSelectVariant
                                : ManagerStrings.productDetailsAddToCart,
                        style: getBoldTextStyle(
                          fontSize: ManagerFontSize.s15,
                          color: ManagerColors.white,
                        ),
                      ),
              ),
            );
          }),

          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}

// ── Sheet Product Header ───────────────────────────────────────────────────────

class _SheetProductHeader extends StatelessWidget {
  final ProductDetailsModel product;

  const _SheetProductHeader({required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // image
        ClipRRect(
          borderRadius: BorderRadius.circular(ManagerRadius.r10),
          child: CachedNetworkImage(
            imageUrl: product.images.isNotEmpty ? product.images.first : '',
            width: ManagerWidth.w80,
            height: ManagerHeight.h80,
            fit: BoxFit.cover,
            placeholder: (_, __) => Container(
              color: ManagerColors.greyWhiteColor.withOpacity(0.1),
            ),
            errorWidget: (_, __, ___) => Container(
              color: ManagerColors.greyWhiteColor.withOpacity(0.1),
              child: Icon(
                Icons.image_outlined,
                color: ManagerColors.greyWhiteColor,
              ),
            ),
          ),
        ),

        SizedBox(width: ManagerWidth.w12),

        // name + price
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s14,
                  color: ManagerColors.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: ManagerHeight.h4),
              Text(
                product.shopName,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s12,
                  color: ManagerColors.greyWhiteColor,
                ),
              ),
              SizedBox(height: ManagerHeight.h8),
              Text(
                '${product.price.toStringAsFixed(0)} ${ManagerStrings.productDetailsCurrency}',
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s16,
                  color: ManagerColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Section title ─────────────────────────────────────────────────────────────

class _SheetSectionTitle extends StatelessWidget {
  final String title;

  const _SheetSectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: getBoldTextStyle(
        fontSize: ManagerFontSize.s13,
        color: ManagerColors.black,
      ),
    );
  }
}

// ── Chip Row ──────────────────────────────────────────────────────────────────

class _SheetChipRow extends StatelessWidget {
  final List<String> items;
  final String? selected;
  final void Function(String) onSelect;

  const _SheetChipRow({
    required this.items,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: ManagerWidth.w8,
      runSpacing: ManagerHeight.h8,
      children: items
          .map((item) => GestureDetector(
                onTap: () => onSelect(item),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: EdgeInsets.symmetric(
                    horizontal: ManagerWidth.w14,
                    vertical: ManagerHeight.h8,
                  ),
                  decoration: BoxDecoration(
                    color: selected == item
                        ? ManagerColors.primaryColor
                        : ManagerColors.primaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(ManagerRadius.r8),
                    border: Border.all(
                      color: selected == item
                          ? ManagerColors.primaryColor
                          : ManagerColors.primaryColor.withOpacity(0.2),
                    ),
                  ),
                  child: Text(
                    item,
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s12,
                      color: selected == item
                          ? ManagerColors.white
                          : ManagerColors.primaryColor,
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}

// ── Quantity Row ──────────────────────────────────────────────────────────────

class _SheetQuantityRow extends StatelessWidget {
  final int quantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const _SheetQuantityRow({
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w14,
        vertical: ManagerHeight.h12,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
      ),
      child: Row(
        children: [
          Text(
            ManagerStrings.productDetailsQty,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s14,
              color: ManagerColors.black,
            ),
          ),
          const Spacer(),
          // Decrement
          _QtyBtn(icon: Icons.remove, onTap: onDecrement),
          // Count
          Container(
            constraints: BoxConstraints(minWidth: ManagerWidth.w34),
            alignment: Alignment.center,
            child: Text(
              '$quantity',
              style: getBoldTextStyle(
                fontSize: ManagerFontSize.s14,
                color: ManagerColors.black,
              ),
            ),
          ),
          // Increment
          _QtyBtn(icon: Icons.add, onTap: onIncrement, isPrimary: true),
        ],
      ),
    );
  }
}

class _QtyBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;

  const _QtyBtn({required this.icon, required this.onTap, this.isPrimary = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: ManagerWidth.w34,
        height: ManagerHeight.h34,
        decoration: BoxDecoration(
          color: isPrimary ? ManagerColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(ManagerRadius.r6),
          border: isPrimary
              ? null
              : Border.all(
                  color: ManagerColors.greyWhiteColor.withOpacity(0.2),
                ),
        ),
        child: Icon(
          icon,
          size: ManagerWidth.w18,
          color: isPrimary ? ManagerColors.white : ManagerColors.greyWhiteColor,
        ),
      ),
    );
  }
}

// ── Shimmer ───────────────────────────────────────────────────────────────────

class _SheetShimmer extends StatelessWidget {
  const _SheetShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ManagerColors.greyWhiteColor.withOpacity(0.15),
      highlightColor: ManagerColors.greyWhiteColor.withOpacity(0.05),
      child: Padding(
        padding: EdgeInsets.all(ManagerWidth.w16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                _Box(w: ManagerWidth.w80, h: ManagerHeight.h80),
                SizedBox(width: ManagerWidth.w12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Box(w: double.infinity, h: ManagerHeight.h16),
                      SizedBox(height: ManagerHeight.h8),
                      _Box(w: ManagerWidth.w100, h: ManagerHeight.h14),
                      SizedBox(height: ManagerHeight.h8),
                      _Box(w: ManagerWidth.w80, h: ManagerHeight.h18),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: ManagerHeight.h20),
            _Box(w: ManagerWidth.w80, h: ManagerHeight.h14),
            SizedBox(height: ManagerHeight.h10),
            Row(children: [
              _Box(w: ManagerWidth.w60, h: ManagerHeight.h34),
              SizedBox(width: ManagerWidth.w8),
              _Box(w: ManagerWidth.w60, h: ManagerHeight.h34),
              SizedBox(width: ManagerWidth.w8),
              _Box(w: ManagerWidth.w60, h: ManagerHeight.h34),
            ]),
            SizedBox(height: ManagerHeight.h20),
            _Box(w: double.infinity, h: ManagerHeight.h50),
          ],
        ),
      ),
    );
  }
}

class _Box extends StatelessWidget {
  final double w;
  final double h;

  const _Box({required this.w, required this.h});

  @override
  Widget build(BuildContext context) => Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: ManagerColors.white,
          borderRadius: BorderRadius.circular(ManagerRadius.r8),
        ),
      );
}
