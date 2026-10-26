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

class StoreHomeHeaderWidget extends StatelessWidget {
  final bool isAvailable;
  final ValueChanged<bool> onAvailabilityChanged;
  final String? shopName;
  final String? imageUrl;

  const StoreHomeHeaderWidget({
    super.key,
    required this.isAvailable,
    required this.onAvailabilityChanged,
    this.shopName,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: ManagerColors.primaryColor),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
          child: Column(
            children: [
              SizedBox(height: ManagerHeight.h8),
              // â”€â”€ Top row: avatar + shop name + action icons â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, Routes.profileProviderScreen),
                    child: Container(
                      width: ManagerWidth.w48,
                      height: ManagerHeight.h48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: ManagerColors.white, width: 2),
                      ),
                      child: ClipOval(
                        child: (imageUrl != null && imageUrl!.isNotEmpty)
                            ? CachedNetworkImage(
                                imageUrl: imageUrl!,
                                fit: BoxFit.cover,
                                placeholder: (_, __) => Container(
                                  color: ManagerColors.white.withOpacity(0.2),
                                  child: const Center(
                                    child: SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: ManagerColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                errorWidget: (_, __, ___) =>
                                    _defaultStoreAvatar(),
                              )
                            : _defaultStoreAvatar(),
                      ),
                    ),
                  ),
                  SizedBox(width: ManagerWidth.w10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ManagerStrings.shopHomeGreeting,
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s12,
                            color: ManagerColors.white.withOpacity(0.8),
                          ),
                        ),
                        SizedBox(height: ManagerHeight.h2),
                        Text(
                          shopName ?? ManagerStrings.homeShopName,
                          style: getBoldTextStyle(
                            fontSize: ManagerFontSize.s14,
                            color: ManagerColors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  _HeaderIconButton(
                    iconPath: ManagerIcons.walletIcon,
                    onTap: () => Navigator.pushNamed(
                        context, Routes.walletScreen),
                  ),
                  SizedBox(width: ManagerWidth.w8),
                  _HeaderIconButton(
                    iconPath: ManagerIcons.notificationIcon,
                    onTap: () => Navigator.pushNamed(
                        context, Routes.notificationScreen),
                  ),
                ],
              ),
              SizedBox(height: ManagerHeight.h12),
              // â”€â”€ Status card: store availability switch â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ManagerColors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(ManagerRadius.r12),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(ManagerRadius.r12),
                        child: Image.asset(
                          ManagerImages.homeBackgroundHeader,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ManagerWidth.w12,
                        vertical: ManagerHeight.h12,
                      ),
                      child: Row(
                        children: [
                          // Status icon badge
                          Container(
                            padding: EdgeInsets.all(ManagerWidth.w8),
                            decoration: BoxDecoration(
                              color: ManagerColors.white.withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isAvailable
                                  ? Icons.storefront_rounded
                                  : Icons.store_mall_directory_outlined,
                              color: ManagerColors.white,
                              size: ManagerFontSize.s18,
                            ),
                          ),
                          SizedBox(width: ManagerWidth.w10),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ManagerStrings.shopHomeVisibilityStatus,
                                  style: getMediumTextStyle(
                                    fontSize: ManagerFontSize.s10,
                                    color: ManagerColors.white,
                                  ),
                                ),
                                SizedBox(height: ManagerHeight.h2),
                                Text(
                                  ManagerStrings.shopHomeVisibilityNote,
                                  style: getRegularTextStyle(
                                    fontSize: ManagerFontSize.s7,
                                    color: ManagerColors.white.withOpacity(0.6),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: ManagerWidth.w8),
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

  Widget _defaultStoreAvatar() {
    return Container(
      color: ManagerColors.white.withOpacity(0.15),
      child: const Icon(
        Icons.storefront_rounded,
        color: ManagerColors.white,
        size: 26,
      ),
    );
  }
}

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
// Private widgets
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class _HeaderIconButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onTap;
  const _HeaderIconButton({required this.iconPath, required this.onTap});

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
          padding: EdgeInsets.all(ManagerWidth.w8),
          child: CustomSvgImage(path: iconPath, color: ManagerColors.white),
        ),
      ),
    );
  }
}

class _AvailabilitySwitch extends StatefulWidget {
  final bool isAvailable;
  final ValueChanged<bool> onChanged;
  const _AvailabilitySwitch(
      {required this.isAvailable, required this.onChanged});

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
    final curved =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _thumbAlignment =
        AlignmentTween(begin: Alignment.centerRight, end: Alignment.centerLeft)
            .animate(curved);
    _trackOpacity =
        Tween<double>(begin: 0.12, end: 0.3).animate(curved);
  }

  @override
  void didUpdateWidget(covariant _AvailabilitySwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isAvailable != widget.isAvailable) {
      widget.isAvailable ? _controller.forward() : _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(!widget.isAvailable),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => Container(
          width: ManagerWidth.w90,
          height: ManagerHeight.h32,
          decoration: BoxDecoration(
            color: ManagerColors.white.withOpacity(_trackOpacity.value),
            borderRadius: BorderRadius.circular(ManagerRadius.r20),
            border: Border.all(
              color: ManagerColors.white
                  .withOpacity(widget.isAvailable ? 0.4 : 0.15),
              width: 1,
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: Align(
                  alignment: widget.isAvailable
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w4),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        widget.isAvailable
                            ? ManagerStrings.shopHomeShopOpen
                            : ManagerStrings.shopHomeShopClosed,
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
        ),
      ),
    );
  }
}

