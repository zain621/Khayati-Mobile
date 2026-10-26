import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/product_card_widget.dart';
import 'package:app_mobile/features/user/home_user/domain/model/home_model.dart';
import 'package:flutter/material.dart';

/// Home screen section — "أحدث القصات" products grid.
///
/// Shows a 2-column grid of [ProductCardWidget] items with a header row.
class HomeProductsGridWidget extends StatelessWidget {
  final List<HomeProductModel>? products;

  // Called when the user taps "عرض الكل"
  final VoidCallback? onViewAll;

  // Called when the user taps a product card
  final void Function(HomeProductModel product)? onProductTap;

  // Called when the user taps the cart button on a card
  final void Function(HomeProductModel product)? onAddToCart;

  const HomeProductsGridWidget({
    super.key,
    this.products,
    this.onViewAll,
    this.onProductTap,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final List<HomeProductModel> resolvedProducts = products ?? [];

    if (resolvedProducts.isEmpty) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header row
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Section title
              Text(
                ManagerStrings.userHomeLatestProductsTitle,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s16,
                  color: ManagerColors.black,
                ),
              ),

              // View all button
              GestureDetector(
                onTap: onViewAll,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      ManagerStrings.userHomeViewAll,
                      style: getMediumTextStyle(
                        fontSize: ManagerFontSize.s13,
                        color: ManagerColors.primaryColor,
                      ),
                    ),
                    SizedBox(width: ManagerWidth.w4),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: ManagerWidth.w16,
                      color: ManagerColors.primaryColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: ManagerHeight.h14),

        // 2-column product grid
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
          child: GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: ManagerWidth.w10,
              mainAxisSpacing: ManagerHeight.h10,
              // ratio keeps image ~195px tall and info fits below — never overflows
              childAspectRatio: 0.54,
            ),
            itemCount: resolvedProducts.length,
            itemBuilder: (context, index) {
              final item = resolvedProducts[index];
              final product = ProductItemModel(
                id: item.id,
                name: item.name,
                shopName: item.shopName,
                imageUrl: item.imageUrl ?? '',
                price: item.price,
                isBestSeller: item.isBestSelling,
              );
              return ProductCardWidget(
                product: product,
                onTap: () => onProductTap?.call(item),
                onAddToCart: () => onAddToCart?.call(item),
              );
            },
          ),
        ),
      ],
    );
  }
}
