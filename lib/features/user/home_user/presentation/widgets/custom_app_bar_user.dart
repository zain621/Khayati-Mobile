// ignore_for_file: avoid_unused_constructor_parameters, unused_element
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_icons.dart';
import 'package:app_mobile/core/resources/manager_images.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/custom_svg_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomeUserAppBar extends StatelessWidget {
  final String userName;
  final String? userAvatar;
  final int loyaltyPoints;
  final TextEditingController? searchController;
  final Function(String)? onSearchChanged;
  final VoidCallback? onFilterTap;
  final VoidCallback? onSearchTap;
  final VoidCallback? onProfileTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onCartTap;
  final VoidCallback? onLocationTap;
  final VoidCallback? onLoyaltyTap;

  const HomeUserAppBar({
    super.key,
    required this.userName,
    this.userAvatar,
    this.loyaltyPoints = 800,
    this.searchController,
    this.onSearchChanged,
    this.onFilterTap,
    this.onSearchTap,
    this.onProfileTap,
    this.onNotificationTap,
    this.onCartTap,
    this.onLocationTap,
    this.onLoyaltyTap,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Container(
      decoration: BoxDecoration(
        color: ManagerColors.primaryColor,
        // borderRadius: BorderRadius.only(
        //   bottomLeft: Radius.circular(ManagerRadius.r20),
        //   bottomRight: Radius.circular(ManagerRadius.r20),
        // ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: topPadding + ManagerHeight.h12,
          bottom: ManagerHeight.h16,
          left: ManagerWidth.w16,
          right: ManagerWidth.w16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ═══════════ Top row: avatar + text + action icons ═══════════
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Profile avatar ──
                GestureDetector(
                  onTap: onProfileTap,
                  child: Container(
                    height: ManagerHeight.h63,
                    width: ManagerWidth.w41,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ManagerColors.white,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(ManagerRadius.r100),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(ManagerRadius.r100),
                      child: userAvatar != null && userAvatar!.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: userAvatar!,
                              fit: BoxFit.cover,
                              placeholder: (_, __) => _avatarPlaceholder(),
                              errorWidget: (_, __, ___) => _avatarFallback(),
                            )
                          : _avatarFallback(),
                    ),
                  ),
                ),

                SizedBox(width: ManagerWidth.w8),

                // ── Welcome text + name + loyalty ──
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: ManagerHeight.h4),
                      Text(
                        ManagerStrings.userHomeWelcomeBack,
                        style: getRegularTextStyle(
                          fontSize: ManagerFontSize.s10,
                          color: ManagerColors.white.withOpacity(0.85),
                        ),
                      ),
                      SizedBox(height: ManagerHeight.h2),
                      Text(
                        userName.isNotEmpty
                            ? userName
                            : ManagerStrings.userHomeDefaultUser,
                        style: getBoldTextStyle(
                          fontSize: ManagerFontSize.s12,
                          color: ManagerColors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: ManagerHeight.h6),

                      // ── Loyalty points badge ──
                      GestureDetector(
                        onTap: onLoyaltyTap,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ManagerWidth.w8,
                            vertical: ManagerHeight.h4,
                          ),
                          decoration: BoxDecoration(
                            color: ManagerColors.white.withOpacity(0.18),
                            borderRadius:
                                BorderRadius.circular(ManagerRadius.r4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: ManagerHeight.h16,
                                width: ManagerWidth.w16,
                                padding: EdgeInsets.symmetric(
                                    horizontal: ManagerWidth.w2,
                                    vertical: ManagerHeight.h2),
                                decoration: BoxDecoration(
                                  color: ManagerColors.primaryColor,
                                  borderRadius:
                                      BorderRadius.circular(ManagerRadius.r4),
                                ),
                                child: CustomSvgImage(
                                  path: ManagerIcons.loyaltyPointsIcon,
                                  height: ManagerHeight.h12,
                                  width: ManagerWidth.w12,
                                ),
                              ),
                              // Icon(
                              //   Icons.monetization_on_rounded,
                              //   color: ManagerColors.secondaryColor,
                              //   size: ManagerWidth.w14,
                              // ),
                              SizedBox(width: ManagerWidth.w4),
                              Text(
                                ManagerStrings.userHomeLoyaltyLabel,
                                style: getRegularTextStyle(
                                  fontSize: ManagerFontSize.s10,
                                  color: ManagerColors.white.withOpacity(0.9),
                                ),
                              ),
                              SizedBox(width: ManagerWidth.w6),
                              Text(
                                '$loyaltyPoints ${ManagerStrings.userHomeLoyaltyPointUnit}',
                                style: getBoldTextStyle(
                                  fontSize: ManagerFontSize.s10,
                                  color: ManagerColors.white,
                                ),
                              ),
                              SizedBox(width: ManagerWidth.w2),
                              Icon(
                                Icons.navigate_next_rounded,
                                color: ManagerColors.white.withOpacity(0.7),
                                size: ManagerWidth.w14,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Action circle buttons (notification, cart, location) ──
                Column(
                  children: [
                    SizedBox(height: ManagerHeight.h4),
                    Row(
                      children: [
                        // /// Notification Bell
                        // _HeaderIconButton(
                        //   iconPath: ManagerIcons.walletIcon,
                        //   onTap: () {
                        //     Navigator.pushNamed(context, Routes.walletScreen);
                        //   },
                        // ),

                        /// Settings / Currency
                        _HeaderIconButton(
                          iconPath: ManagerIcons.cartIcon,
                          onTap: onCartTap??(){},
                        ),
                        SizedBox(width: ManagerWidth.w8),

                        _HeaderIconButton(
                          iconPath: ManagerIcons.notificationIcon,
                          onTap: () {
                            onNotificationTap?.call();
                          },
                        ),
                        // _CircleActionBtn(
                        //   icon: Icons.notifications_none_rounded,
                        //   onTap: onNotificationTap,
                        // ),
                        // SizedBox(width: ManagerWidth.w8),
                        // _CircleActionBtn(
                        //   icon: Icons.shopping_cart_outlined,
                        //   onTap: onCartTap,
                        // ),
                        // SizedBox(width: ManagerWidth.w8),
                        // _CircleActionBtn(
                        //   icon: Icons.location_on_outlined,
                        //   onTap: onLocationTap,
                        // ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: ManagerHeight.h14),

            // ═══════════ Search bar ═══════════
            Container(
              height: ManagerHeight.h40,
              decoration: BoxDecoration(
                color: ManagerColors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(ManagerRadius.r8),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w12),
                child: Row(
                  children: [
                    // ── Search icon (right side in RTL) ──
                    CustomSvgImage(path: ManagerIcons.searchIcon),
                    // ── TextField ──
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: onSearchChanged,
                        onTap: onSearchTap,
                        readOnly: onSearchTap != null,
                        style: getRegularTextStyle(
                          fontSize: ManagerFontSize.s14,
                          color: ManagerColors.white,
                        ),
                        cursorColor: ManagerColors.white,
                        textAlign: TextAlign.right,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: ManagerStrings.userHomeSearchHint,
                          hintStyle: getRegularTextStyle(
                            fontSize: ManagerFontSize.s14,
                            color: ManagerColors.white.withOpacity(0.6),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: ManagerWidth.w8,
                            vertical: ManagerHeight.h12,
                          ),
                        ),
                      ),
                    ),
                    // ── Vertical Divider ──
                    SizedBox(
                      height: ManagerHeight.h22,
                      child: VerticalDivider(
                        color: ManagerColors.white.withOpacity(0.4),
                        thickness: 1,
                        width: ManagerWidth.w16,
                      ),
                    ),

                    // ── Filter icon (left side in RTL) ──
                    GestureDetector(
                      onTap: onFilterTap,
                      child: Container(
                        width: ManagerWidth.w36,
                        height: ManagerHeight.h40,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.tune_rounded,
                          color: ManagerColors.white.withOpacity(0.8),
                          size: ManagerWidth.w22,
                        ),
                      ),
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

  /// Shown while the network avatar is loading.
  Widget _avatarPlaceholder() {
    return Container(
      color: ManagerColors.primaryColor,
      child: Center(
        child: SizedBox(
          width: ManagerWidth.w20,
          height: ManagerHeight.h20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              ManagerColors.white.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }

  /// Shown when no avatar URL is provided or when the network request fails.
  Widget _avatarFallback() {
    return Image.asset(
      ManagerImages.defaultProfileImage,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }
}

/// Small dark circle button used for notification / cart / location.
class _CircleActionBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap = null;

  const _CircleActionBtn({
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: ManagerWidth.w36,
        height: ManagerHeight.h36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ManagerColors.white.withOpacity(0.15),
        ),
        child: Icon(
          icon,
          color: ManagerColors.white,
          size: ManagerWidth.w18,
        ),
      ),
    );
  }
}

/// Small circular icon button for the header.
class _HeaderIconButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onTap;

  const _HeaderIconButton({
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: ManagerWidth.w36,
        height: ManagerHeight.h36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ManagerColors.white.withOpacity(0.12),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w8, vertical: ManagerHeight.h8),
          child: CustomSvgImage(
            path: iconPath,
            color: ManagerColors.white,
          ),
        ),
      ),
    );
  }
}
