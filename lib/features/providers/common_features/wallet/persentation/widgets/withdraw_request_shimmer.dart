import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WithdrawRequestShimmer extends StatelessWidget {
  const WithdrawRequestShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ManagerColors.greyWhiteColor.withOpacity(0.3),
      highlightColor: ManagerColors.greyWhiteColor.withOpacity(0.1),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ManagerHeight.h12),

            /// Withdraw Request Card Shimmer
            Container(
              padding: EdgeInsets.all(ManagerWidth.w16),
              decoration: BoxDecoration(
                color: ManagerColors.white,
                borderRadius: BorderRadius.circular(ManagerRadius.r12),
                boxShadow: [
                  BoxShadow(
                    color: ManagerColors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Header
                  Row(
                    children: [
                      Container(
                        width: ManagerWidth.w48,
                        height: ManagerHeight.h48,
                        decoration: BoxDecoration(
                          color: ManagerColors.white,
                          borderRadius:
                              BorderRadius.circular(ManagerRadius.r12),
                        ),
                      ),
                      SizedBox(width: ManagerWidth.w12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: ManagerHeight.h14,
                              decoration: BoxDecoration(
                                color: ManagerColors.white,
                                borderRadius:
                                    BorderRadius.circular(ManagerRadius.r4),
                              ),
                            ),
                            SizedBox(height: ManagerHeight.h8),
                            Container(
                              width: ManagerWidth.w150,
                              height: ManagerHeight.h12,
                              decoration: BoxDecoration(
                                color: ManagerColors.white,
                                borderRadius:
                                    BorderRadius.circular(ManagerRadius.r4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: ManagerHeight.h24),

                  /// Amount Label
                  Container(
                    width: ManagerWidth.w80,
                    height: ManagerHeight.h12,
                    decoration: BoxDecoration(
                      color: ManagerColors.white,
                      borderRadius: BorderRadius.circular(ManagerRadius.r4),
                    ),
                  ),

                  SizedBox(height: ManagerHeight.h8),

                  /// Amount Field
                  Container(
                    width: double.infinity,
                    height: ManagerHeight.h56,
                    decoration: BoxDecoration(
                      color: ManagerColors.white,
                      borderRadius: BorderRadius.circular(ManagerRadius.r8),
                    ),
                  ),

                  SizedBox(height: ManagerHeight.h12),

                  /// Max Limit
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: ManagerWidth.w120,
                      height: ManagerHeight.h12,
                      decoration: BoxDecoration(
                        color: ManagerColors.white,
                        borderRadius: BorderRadius.circular(ManagerRadius.r4),
                      ),
                    ),
                  ),

                  SizedBox(height: ManagerHeight.h16),

                  /// Notes Label
                  Container(
                    width: ManagerWidth.w60,
                    height: ManagerHeight.h12,
                    decoration: BoxDecoration(
                      color: ManagerColors.white,
                      borderRadius: BorderRadius.circular(ManagerRadius.r4),
                    ),
                  ),

                  SizedBox(height: ManagerHeight.h8),

                  /// Notes Field
                  Container(
                    width: double.infinity,
                    height: ManagerHeight.h100,
                    decoration: BoxDecoration(
                      color: ManagerColors.white,
                      borderRadius: BorderRadius.circular(ManagerRadius.r8),
                    ),
                  ),

                  SizedBox(height: ManagerHeight.h16),

                  /// Bank Account Section
                  Container(
                    padding: EdgeInsets.all(ManagerWidth.w14),
                    decoration: BoxDecoration(
                      color: ManagerColors.white,
                      borderRadius: BorderRadius.circular(ManagerRadius.r8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: ManagerWidth.w100,
                                height: ManagerHeight.h12,
                                decoration: BoxDecoration(
                                  color: ManagerColors.greyWhiteColor
                                      .withOpacity(0.5),
                                  borderRadius:
                                      BorderRadius.circular(ManagerRadius.r4),
                                ),
                              ),
                              SizedBox(height: ManagerHeight.h6),
                              Container(
                                width: ManagerWidth.w180,
                                height: ManagerHeight.h14,
                                decoration: BoxDecoration(
                                  color: ManagerColors.greyWhiteColor
                                      .withOpacity(0.5),
                                  borderRadius:
                                      BorderRadius.circular(ManagerRadius.r4),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: ManagerWidth.w60,
                          height: ManagerHeight.h28,
                          decoration: BoxDecoration(
                            color:
                                ManagerColors.greyWhiteColor.withOpacity(0.5),
                            borderRadius:
                                BorderRadius.circular(ManagerRadius.r6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: ManagerHeight.h24),

            /// Confirm Button Shimmer
            Container(
              width: double.infinity,
              height: ManagerHeight.h56,
              decoration: BoxDecoration(
                color: ManagerColors.white,
                borderRadius: BorderRadius.circular(ManagerRadius.r12),
              ),
            ),

            SizedBox(height: ManagerHeight.h12),

            /// Processing Time Info Shimmer
            Center(
              child: Container(
                width: ManagerWidth.w200,
                height: ManagerHeight.h12,
                decoration: BoxDecoration(
                  color: ManagerColors.white,
                  borderRadius: BorderRadius.circular(ManagerRadius.r4),
                ),
              ),
            ),

            SizedBox(height: ManagerHeight.h24),
          ],
        ),
      ),
    );
  }
}
