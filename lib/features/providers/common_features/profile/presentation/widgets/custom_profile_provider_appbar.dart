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
import 'package:shimmer/shimmer.dart';

class CustomProfileProviderAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final String? fullName;
  final String? phoneNumber;
  final String? imageUrl;
  final String? role;
  final String? rankLabel;
  final bool isLoading;

  const CustomProfileProviderAppbar({
    super.key,
    required this.title,
    this.subtitle,
    this.showBackButton = true,
    this.onBackPressed,
    this.fullName,
    this.phoneNumber,
    this.imageUrl,
    this.role,
    this.rankLabel,
    this.isLoading = false,
  });

  @override
  Size get preferredSize => Size.fromHeight(
        subtitle != null ? ManagerHeight.h120 : ManagerHeight.h80,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ManagerColors.primaryColor,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: ManagerWidth.w16,
        right: ManagerWidth.w16,
        // bottom: ManagerHeight.h64,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// Back Button and Title Row
              if (showBackButton)
                GestureDetector(
                  onTap: () {
                    if (onBackPressed != null) {
                      onBackPressed!();
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
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
              SizedBox(width: ManagerWidth.w5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: ManagerHeight.h12),

                  /// Title
                  Text(
                    title,
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s16,
                      color: ManagerColors.white,
                    ),
                  ),

                  /// Subtitle
                  if (subtitle != null) ...[
                    SizedBox(height: ManagerHeight.h4),
                    Text(
                      subtitle!,
                      style: getRegularTextStyle(
                        fontSize: ManagerFontSize.s10,
                        color: ManagerColors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          SizedBox(
            height: ManagerHeight.h12,
          ),
          Container(
            height: ManagerHeight.h90,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ManagerRadius.r8),
              color: ManagerColors.white.withOpacity(0.05),
            ),
            child: isLoading
                ? _buildShimmerCard()
                : Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Image.asset(
                          ManagerImages.profileProvider,
                        ),
                      ),
                      Center(
                          child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: ManagerWidth.w8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Profile Image
                            Container(
                              width: ManagerWidth.w70,
                              height: ManagerHeight.h70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: ManagerColors.white,
                                  width: 2,
                                ),
                              ),
                              child: ClipOval(
                                child: imageUrl != null && imageUrl!.isNotEmpty
                                    ? CachedNetworkImage(
                                        imageUrl: imageUrl!,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: ManagerColors.white,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.person,
                                                color: ManagerColors.white),
                                      )
                                    : Icon(Icons.person,
                                        color: ManagerColors.white),
                              ),
                            ),

                            SizedBox(width: ManagerWidth.w8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          fullName ?? '',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: getBoldTextStyle(
                                            fontSize: ManagerFontSize.s12,
                                            color: ManagerColors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: ManagerWidth.w3,
                                      ),
                                      CustomSvgImage(
                                        path: ManagerIcons.verfiedIcon,
                                        color: ManagerColors.white,
                                        height: ManagerHeight.h14,
                                        width: ManagerWidth.w14,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: ManagerHeight.h4),
                                  Text(
                                    phoneNumber ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: getRegularTextStyle(
                                      fontSize: ManagerFontSize.s12,
                                      color: ManagerColors.white,
                                    ),
                                  ),
                                  SizedBox(height: ManagerHeight.h6),
                                  Wrap(
                                    spacing: ManagerWidth.w6,
                                    runSpacing: ManagerHeight.h4,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      /// Role chip (account type)
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: ManagerWidth.w10,
                                          vertical: ManagerHeight.h4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: ManagerColors.white
                                              .withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(
                                              ManagerRadius.r4),
                                        ),
                                        child: Text(
                                          ManagerStrings.roleLabel(role),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: getBoldTextStyle(
                                            fontSize: ManagerFontSize.s10,
                                            color: ManagerColors.white,
                                          ),
                                        ),
                                      ),
                                      // Rank chip — shown only for tailors when rankLabel is available
                                      if (role != 'shop_owner' &&
                                          rankLabel != null &&
                                          rankLabel!.isNotEmpty)
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: ManagerWidth.w10,
                                            vertical: ManagerHeight.h4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: ManagerColors.white
                                                .withOpacity(0.12),
                                            borderRadius: BorderRadius.circular(
                                                ManagerRadius.r4),
                                            border: Border.all(
                                              color: ManagerColors.white
                                                  .withOpacity(0.4),
                                              width: 1,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.military_tech_rounded,
                                                size: ManagerFontSize.s10,
                                                color: ManagerColors.white
                                                    .withOpacity(0.9),
                                              ),
                                              SizedBox(width: ManagerWidth.w3),
                                              Text(
                                                rankLabel!,
                                                style: getRegularTextStyle(
                                                  fontSize: ManagerFontSize.s10,
                                                  color: ManagerColors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
          )
        ],
      ),
    );
  }

  /// Shimmer placeholder matching the real profile-card layout exactly.
  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: ManagerColors.white.withOpacity(0.15),
      highlightColor: ManagerColors.white.withOpacity(0.35),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar circle placeholder
            Container(
              width: ManagerWidth.w70,
              height: ManagerHeight.h70,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),

            SizedBox(width: ManagerWidth.w8),

            // Text lines placeholder
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Name line
                Container(
                  width: ManagerWidth.w120,
                  height: ManagerHeight.h14,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(ManagerRadius.r4),
                  ),
                ),
                SizedBox(height: ManagerHeight.h8),
                // Phone line
                Container(
                  width: ManagerWidth.w80,
                  height: ManagerHeight.h12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(ManagerRadius.r4),
                  ),
                ),
                SizedBox(height: ManagerHeight.h8),
                // Role chip placeholder
                Container(
                  width: ManagerWidth.w60,
                  height: ManagerHeight.h20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(ManagerRadius.r4),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
