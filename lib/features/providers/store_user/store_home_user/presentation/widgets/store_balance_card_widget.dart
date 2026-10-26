import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_images.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/features/providers/store_user/store_home_user/presentation/controller/shop_owner_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Balance card for the shop-owner home — reads real data from [ShopOwnerHomeController].
class StoreBalanceCardWidget extends GetView<ShopOwnerHomeController> {
  const StoreBalanceCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: ManagerHeight.h147,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ManagerRadius.r5),
          color: ManagerColors.primaryColor,
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                ManagerImages.homeBalanceBackground1,
                width: ManagerWidth.w76,
                height: ManagerHeight.h88,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                ManagerImages.homeBalanceBackground2,
                width: ManagerWidth.w80,
                height: ManagerHeight.h65,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: ManagerHeight.h12),

                  // Title
                  Text(
                    ManagerStrings.shopHomeBalanceTitle,
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s12,
                      color: ManagerColors.white,
                    ),
                  ),

                  SizedBox(height: ManagerHeight.h12),

                  // Amount
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.formattedBalance,
                        style: getBoldTextStyle(
                          fontSize: ManagerFontSize.s48,
                          color: ManagerColors.white,
                        ),
                      ),
                      SizedBox(width: ManagerWidth.w6),
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: ManagerHeight.h10),
                        child: Text(
                          ManagerStrings.shopHomeBalanceCurrency,
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s12,
                            color: ManagerColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: ManagerHeight.h12),

                  // Last login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        ManagerStrings.shopHomeLastLogin,
                        style: getBoldTextStyle(
                          fontSize: ManagerFontSize.s10,
                          color: ManagerColors.white,
                        ),
                      ),
                      SizedBox(width: ManagerWidth.w4),
                      Text(
                        controller.formattedLastLogin,
                        style: getBoldTextStyle(
                          fontSize: ManagerFontSize.s10,
                          color: ManagerColors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
