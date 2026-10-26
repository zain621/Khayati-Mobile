import 'package:cached_network_image/cached_network_image.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_icons.dart';
import 'package:app_mobile/core/resources/manager_images.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/widgets/custom_svg_image.dart';
import 'package:flutter/material.dart';

/// Dark-green curved header with profile info, rank chips, and visibility status.
class HomeHeaderWidget extends StatelessWidget {
  final bool isAvailable;
  final ValueChanged<bool> onAvailabilityChanged;

  /// Optionally supply real name from API; falls back to the hardcoded string.
  final String? fullName;

  /// Optionally supply a network image URL; falls back to the placeholder asset.
  final String? imageUrl;

  /// Optionally supply a rank label from API; falls back to the hardcoded string.
  final String? rankLabel;

  const HomeHeaderWidget({
    super.key,
    required this.isAvailable,
    required this.onAvailabilityChanged,
    this.fullName,
    this.imageUrl,
    this.rankLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ManagerColors.primaryColor,
        // borderRadius: BorderRadius.only(
        //   bottomLeft: Radius.circular(ManagerRadius.r24),
        //   bottomRight: Radius.circular(ManagerRadius.r24),
        // ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ManagerWidth.w16,
          ),
          child: Column(
            children: [
              SizedBox(height: ManagerHeight.h8),

              /// Top row: icons (left) + greeting + avatar (right)
              Row(
                children: [
                  /// Profile Avatar — tappable → ProfileProviderScreen
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, Routes.profileProviderScreen),
                    child: Container(
                      width: ManagerWidth.w48,
                      height: ManagerHeight.h48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ManagerColors.white,
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: (imageUrl != null && imageUrl!.isNotEmpty)
                            ? CachedNetworkImage(
                                imageUrl: imageUrl!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: ManagerColors.white,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.person, color: ManagerColors.white),
                              )
                            : const Icon(Icons.person, color: ManagerColors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: ManagerWidth.w10),

                  /// Greeting + Shop Name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ManagerStrings.homeGreeting,
                        style: getRegularTextStyle(
                          fontSize: ManagerFontSize.s12,
                          color: ManagerColors.white.withOpacity(0.8),
                        ),
                      ),
                      SizedBox(height: ManagerHeight.h2),
                      Text(
                        fullName ?? ManagerStrings.homeShopName,
                        style: getBoldTextStyle(
                          fontSize: ManagerFontSize.s14,
                          color: ManagerColors.white,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),

                  /// Notification Bell
                  _HeaderIconButton(
                    iconPath: ManagerIcons.walletIcon,
                    onTap: () {
                      Navigator.pushNamed(context, Routes.walletScreen);
                    },
                  ),
                  SizedBox(width: ManagerWidth.w8),

                  /// Notification Bell
                  _HeaderIconButton(
                    iconPath: ManagerIcons.notificationIcon,
                    onTap: () {
                      Navigator.pushNamed(context, Routes.notificationScreen);
                    },
                  ),
                ],
              ),

              SizedBox(height: ManagerHeight.h12),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ManagerColors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(ManagerRadius.r12),
                ),
                child: Stack(
                  children: [
                    /// Background image
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(ManagerRadius.r12),
                          child: Image.asset(
                            ManagerImages.homeBackgroundHeader,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    /// Content Row
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ManagerWidth.w12,
                        vertical: ManagerHeight.h12,
                      ),
                      child: Row(
                        children: [
                          /// Rank label
                          Text(
                            '${ManagerStrings.homeTailorRank} :',
                            style: getRegularTextStyle(
                              fontSize: ManagerFontSize.s10,
                              color: ManagerColors.white.withOpacity(0.8),
                            ),
                          ),
                          SizedBox(width: ManagerWidth.w6),

                          /// Rank value chip
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: ManagerWidth.w10,
                              vertical: ManagerHeight.h4,
                            ),
                            decoration: BoxDecoration(
                              color: ManagerColors.white.withOpacity(0.2),
                              borderRadius:
                                  BorderRadius.circular(ManagerRadius.r4),
                            ),
                            child: Text(
                              ManagerStrings.homeTailorRankLabel(rankLabel),
                              style: getBoldTextStyle(
                                fontSize: ManagerFontSize.s10,
                                color: ManagerColors.white,
                              ),
                            ),
                          ),

                          SizedBox(width: ManagerWidth.w10),

                          /// Visibility info
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ManagerStrings.homeVisibilityStatus,
                                  style: getMediumTextStyle(
                                    fontSize: ManagerFontSize.s10,
                                    color: ManagerColors.white,
                                  ),
                                ),
                                SizedBox(height: ManagerHeight.h2),
                                Text(
                                  ManagerStrings.homeVisibilityNote,
                                  style: getRegularTextStyle(
                                    fontSize: ManagerFontSize.s7,
                                    color: ManagerColors.white.withOpacity(0.6),
                                  ),
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: ManagerWidth.w8),

                          /// Custom Availability Switch
                          _AvailabilitySwitch(
                            isAvailable: isAvailable,
                            onChanged: onAvailabilityChanged,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: ManagerHeight.h16),
            ],
          ),
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

/// Custom animated availability toggle switch with sliding thumb.
class _AvailabilitySwitch extends StatefulWidget {
  final bool isAvailable;
  final ValueChanged<bool> onChanged;

  const _AvailabilitySwitch({
    required this.isAvailable,
    required this.onChanged,
  });

  @override
  State<_AvailabilitySwitch> createState() => _AvailabilitySwitchState();
}

class _AvailabilitySwitchState extends State<_AvailabilitySwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _thumbAlignment;
  late Animation<double> _trackOpacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: widget.isAvailable ? 1.0 : 0.0,
    );
    _setupAnimations();
  }

  void _setupAnimations() {
    final curved = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // In RTL: start = right, end = left.
    // Available (on): thumb on the left (end) side.
    // Unavailable (off): thumb on the right (start) side.
    _thumbAlignment = AlignmentTween(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
    ).animate(curved);

    _trackOpacity = Tween<double>(
      begin: 0.12,
      end: 0.3,
    ).animate(curved);
  }

  @override
  void didUpdateWidget(covariant _AvailabilitySwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isAvailable != widget.isAvailable) {
      if (widget.isAvailable) {
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

  void _handleTap() {
    widget.onChanged(!widget.isAvailable);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            width: ManagerWidth.w90,
            height: ManagerHeight.h32,
            decoration: BoxDecoration(
              color: ManagerColors.white.withOpacity(_trackOpacity.value),
              borderRadius: BorderRadius.circular(ManagerRadius.r20),
              border: Border.all(
                color: ManagerColors.white.withOpacity(
                  widget.isAvailable ? 0.4 : 0.15,
                ),
                width: 1,
              ),
            ),
            child: Stack(
              children: [
                /// Label text (centered)
                Center(
                  child: Align(
                    alignment: widget.isAvailable ? Alignment.centerRight : Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w4),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          widget.isAvailable
                              ? ManagerStrings.homeVisibilityAvailableSwitch
                              : ManagerStrings.homeVisibilityUnavailableSwitch,
                          key: ValueKey(widget.isAvailable),
                          style: getMediumTextStyle(
                            fontSize: ManagerFontSize.s9,
                            color: ManagerColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                /// Sliding thumb
                Align(
                  alignment: _thumbAlignment.value,
                  child: Padding(
                    padding: EdgeInsets.all(ManagerWidth.w3),
                    child: Container(
                      width: ManagerWidth.w26,
                      height: ManagerWidth.w26,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.isAvailable
                            ? ManagerColors.white
                            : ManagerColors.white.withOpacity(0.35),
                        boxShadow: [
                          BoxShadow(
                            color: ManagerColors.black.withOpacity(0.15),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          widget.isAvailable
                              ? Icons.check_rounded
                              : Icons.close_rounded,
                          key: ValueKey(widget.isAvailable),
                          size: 14,
                          color: widget.isAvailable
                              ? ManagerColors.primaryColor
                              : ManagerColors.white.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
