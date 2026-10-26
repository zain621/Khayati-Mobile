import 'dart:ui';

import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_images.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:flutter/material.dart';

/// Promotional card for the custom order feature shown on the home screen.
class HomeCustomOfferCardWidget extends StatelessWidget {
  final VoidCallback? onTap;

  const HomeCustomOfferCardWidget({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: ManagerHeight.h110,
          decoration: BoxDecoration(
            color: ManagerColors.primaryColor,
            borderRadius: BorderRadius.circular(ManagerRadius.r16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(ManagerRadius.r16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background pattern image â€” anchored to bottom-left
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Image.asset(
                    ManagerImages.backgroundCustomOffer,
                    fit: BoxFit.fitHeight,
                  ),
                ),

                // Frosted glass overlay + content
                Padding(
                    padding: EdgeInsets.symmetric(
                          horizontal: ManagerWidth.w12,
                          vertical: ManagerHeight.h12,
                        ),
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ManagerColors.white.withOpacity(0.15),
                          borderRadius:
                              BorderRadius.circular(ManagerRadius.r6),
                        ),
                      
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ManagerWidth.w12,
                            vertical: ManagerHeight.h10,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Icon box 32Ã—32
                              Container(
                                width: ManagerWidth.w32,
                                height: ManagerHeight.h32,
                                decoration: BoxDecoration(
                                  color: ManagerColors.white.withOpacity(0.15),
                                  borderRadius:
                                      BorderRadius.circular(ManagerRadius.r8),
                                ),
                                child: Icon(
                                  Icons.content_cut_rounded,
                                  color: ManagerColors.white,
                                  size: ManagerWidth.w18,
                                ),
                              ),
                                            
                              SizedBox(width: ManagerWidth.w12),
                                            
                              // Title + subtitle
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ManagerStrings.homeCustomOfferTitle,
                                      style: getBoldTextStyle(
                                        fontSize: ManagerFontSize.s14,
                                        color: ManagerColors.white,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                    SizedBox(height: ManagerHeight.h3),
                                    Text(
                                      ManagerStrings.homeCustomOfferSubtitle,
                                      style: getRegularTextStyle(
                                        fontSize: ManagerFontSize.s10,
                                        color: ManagerColors.white.withOpacity(0.85),
                                      ),
                                      textAlign: TextAlign.right,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                                            
                              // const Spacer(),
                                            
                              // Arrow icon
                              Center(
                                child: Icon(
                                  Icons.navigate_next_rounded,
                                  color: ManagerColors.white.withOpacity(0.7),
                                  size: ManagerWidth.w28,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
}
