import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/full_screen_image_viewer.dart';
import 'package:app_mobile/features/user/my_oredrs/domain/model/tailor_offer_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TailorOfferCard extends StatelessWidget {
  final TailorOfferModel offer;
  final VoidCallback? onViewProfile;
  final VoidCallback? onAccept;

  const TailorOfferCard({
    super.key,
    required this.offer,
    this.onViewProfile,
    this.onAccept,
  });

  bool get _isAvailable => offer.availability == TailorAvailability.available;

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w16,
        vertical: ManagerHeight.h6,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
        boxShadow: [
          BoxShadow(
            color: ManagerColors.black.withOpacity(0.07),
            blurRadius: 20,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              ManagerWidth.w14,
              ManagerHeight.h14,
              ManagerWidth.w14,
              ManagerHeight.h12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Tailor header row ──────────────────────────────────────
                _buildTailorRow(),

                SizedBox(height: ManagerHeight.h14),

                // ── Duration + Price boxes ─────────────────────────────────
                _buildInfoBoxes(),

                SizedBox(height: ManagerHeight.h14),

                // ── Description ────────────────────────────────────────────
                Text(
                  offer.description,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s12,
                    color: const Color(0xFF555555),
                  ),
                ),

                SizedBox(height: ManagerHeight.h12),

                // ── Fabric samples ─────────────────────────────────────────
                _buildSamplesSection(context),
              ],
            ),
          ),

          // ── Divider ───────────────────────────────────────────────────────
          const Divider(height: 1, thickness: 0.8, color: Color(0xFFEEEEEE)),

          // ── Action buttons ────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(
              ManagerWidth.w14,
              ManagerHeight.h12,
              ManagerWidth.w14,
              ManagerHeight.h14,
            ),
            child: _buildActions(context),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // TAILOR HEADER ROW
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildTailorRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar
        _buildAvatar(),

        SizedBox(width: ManagerWidth.w10),

        // Name + badge + rating
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name row: name + status dot
              Row(
                children: [
                  Expanded(
                    child: Text(
                      offer.tailorName,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s14,
                        color: ManagerColors.black,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(width: ManagerWidth.w6),
                  _buildAvailabilityDot(),
                ],
              ),

              SizedBox(height: ManagerHeight.h4),

              // Badge + rating on same row
              Row(
                children: [
                  _buildBadge(),
                  SizedBox(width: ManagerWidth.w8),
                  Icon(Icons.star_rounded,
                      size: ManagerFontSize.s13,
                      color: const Color(0xFFFFC107)),
                  SizedBox(width: ManagerWidth.w2),
                  Text(
                    '${offer.rating}',
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s12,
                      color: ManagerColors.black,
                    ),
                  ),
                  SizedBox(width: ManagerWidth.w3),
                  Text(
                    '(${offer.reviewCount} ${ManagerStrings.submittedOffersOrders})',
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s11,
                      color: ManagerColors.greyWhiteColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Replied-ago time (end of row)
        Text(
          '${ManagerStrings.submittedOffersRepliedAgo} ${offer.repliedAgo}',
          style: getRegularTextStyle(
            fontSize: ManagerFontSize.s10,
            color: ManagerColors.greyWhiteColor,
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: ManagerColors.primaryColor.withOpacity(0.18),
          width: 2,
        ),
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: offer.tailorAvatarUrl,
          fit: BoxFit.cover,
          placeholder: (_, __) => Container(
            color: ManagerColors.greyWhiteColor.withOpacity(0.12),
          ),
          errorWidget: (_, __, ___) => Container(
            color: ManagerColors.greyWhiteColor.withOpacity(0.12),
            child: Icon(Icons.person_outline_rounded,
                color: ManagerColors.greyWhiteColor),
          ),
        ),
      ),
    );
  }

  Widget _buildAvailabilityDot() {
    final isAvail = _isAvailable;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            color: isAvail
                ? const Color(0xFF43A047)
                : ManagerColors.greyWhiteColor,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: ManagerWidth.w3),
        Text(
          isAvail
              ? ManagerStrings.submittedOffersAvailable
              : ManagerStrings.submittedOffersBusy,
          style: getMediumTextStyle(
            fontSize: ManagerFontSize.s11,
            color: isAvail
                ? const Color(0xFF43A047)
                : ManagerColors.greyWhiteColor,
          ),
        ),
      ],
    );
  }

  Widget _buildBadge() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w8,
        vertical: ManagerHeight.h3,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.primaryColor.withOpacity(0.10),
        borderRadius: BorderRadius.circular(ManagerRadius.r20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified_rounded,
              size: ManagerFontSize.s11, color: ManagerColors.primaryColor),
          SizedBox(width: ManagerWidth.w3),
          Text(
            offer.tailorBadge,
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s10,
              color: ManagerColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // INFO BOXES — duration (grey) + price (primary green)
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildInfoBoxes() {
    return Row(
      children: [
        // Right box — Duration (grey bg)
        Expanded(
          child: _InfoBox(
            label: ManagerStrings.submittedOffersDuration,
            value: '${offer.durationDays}',
            unit: ManagerStrings.submittedOffersDays,
            isHighlighted: false,
          ),
        ),

        SizedBox(width: ManagerWidth.w10),

        // Left box — Price (primary green bg)
        Expanded(
          child: _InfoBox(
            label: ManagerStrings.submittedOffersPrice,
            value: offer.price.toInt().toString(),
            unit: ManagerStrings.submittedOffersCurrency,
            isHighlighted: true,
          ),
        ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // FABRIC SAMPLES
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildSamplesSection(BuildContext context) {
    final samples = offer.sampleImageUrls;
    if (samples.isEmpty) return const SizedBox.shrink();

    const int maxVisible = 4;
    final visible = samples.take(maxVisible).toList();
    final remaining = samples.length - visible.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ManagerStrings.submittedOffersSamples,
          style: getMediumTextStyle(
            fontSize: ManagerFontSize.s11,
            color: ManagerColors.greyWhiteColor,
          ),
        ),
        SizedBox(height: ManagerHeight.h8),
        Row(
          children: List.generate(visible.length, (i) {
            // Show a "+N" overlay on the last visible tile when there are more.
            final isLast = i == visible.length - 1;
            final overflow = isLast && remaining > 0 ? remaining : 0;
            return Padding(
              padding: EdgeInsetsDirectional.only(end: ManagerWidth.w8),
              child: _SampleThumb(
                imageUrl: visible[i],
                overflowCount: overflow,
                onTap: () => showImagePreview(
                  context,
                  images: samples,
                  initialIndex: i,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // ACTION BUTTONS
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildActions(BuildContext ctx) {
    return Row(
      children: [
        Expanded(
          child: _OutlineBtn(
            label: ManagerStrings.submittedOffersViewProfile,
            icon: Icons.person_outline_rounded,
            onTap: onViewProfile,
          ),
        ),
        SizedBox(width: ManagerWidth.w10),
        Expanded(
          child: _PrimaryBtn(
            label: ManagerStrings.submittedOffersAccept,
            icon: Icons.check_circle_outline_rounded,
            // Tap shows confirmation sheet; calls onAccept only after confirm
            onTap: () => _showAcceptDialog(ctx),
          ),
        ),
      ],
    );
  }

  void _showAcceptDialog(BuildContext ctx) {
    showModalBottomSheet<void>(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AcceptOfferBottomSheet(
        offer: offer,
        onConfirm: () {
          Navigator.of(ctx).pop();
          onAccept?.call();
        },
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Sub-widgets
// ══════════════════════════════════════════════════════════════════════════════

/// Tappable fabric-sample thumbnail. Opens a full-screen preview on tap and
/// renders a "+N" overlay when it represents additional hidden samples.
class _SampleThumb extends StatelessWidget {
  final String imageUrl;
  final int overflowCount;
  final VoidCallback onTap;

  const _SampleThumb({
    required this.imageUrl,
    required this.overflowCount,
    required this.onTap,
  });

  static const double _w = 60;
  static const double _h = 68;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(ManagerRadius.r8),
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              width: _w,
              height: _h,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(
                width: _w,
                height: _h,
                color: ManagerColors.greyWhiteColor.withOpacity(0.10),
              ),
              errorWidget: (_, __, ___) => Container(
                width: _w,
                height: _h,
                color: ManagerColors.greyWhiteColor.withOpacity(0.10),
                child: Icon(Icons.image_not_supported_outlined,
                    color: ManagerColors.greyWhiteColor.withOpacity(0.4),
                    size: 20),
              ),
            ),
            if (overflowCount > 0)
              Positioned.fill(
                child: Container(
                  alignment: Alignment.center,
                  color: ManagerColors.black.withOpacity(0.45),
                  child: Text(
                    '+$overflowCount',
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s16,
                      color: ManagerColors.white,
                    ),
                  ),
                ),
              )
            else
              // Subtle zoom affordance so users know it's tappable.
              Positioned(
                right: 3,
                bottom: 3,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: ManagerColors.black.withOpacity(0.40),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(
                    Icons.zoom_in_rounded,
                    color: Colors.white,
                    size: 13,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Info box: label on top, big value in center, unit below.
class _InfoBox extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final bool isHighlighted;

  const _InfoBox({
    required this.label,
    required this.value,
    required this.unit,
    required this.isHighlighted,
  });

  @override
  Widget build(BuildContext context) {
    final Color bg =
        isHighlighted ? ManagerColors.primaryColor : const Color(0xFFF5F5F5);
    final Color textColor =
        isHighlighted ? ManagerColors.white : ManagerColors.black;
    final Color subColor = isHighlighted
        ? ManagerColors.white.withOpacity(0.80)
        : ManagerColors.greyWhiteColor;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w12,
        vertical: ManagerHeight.h12,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s11,
              color: subColor,
            ),
          ),
          SizedBox(height: ManagerHeight.h4),
          Text(
            value,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s24,
              color: textColor,
            ),
          ),
          Text(
            unit,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s11,
              color: subColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// outlined button (view profile)
class _OutlineBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  const _OutlineBtn({required this.label, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ManagerRadius.r12),
      child: Container(
        height: ManagerHeight.h40,
        decoration: BoxDecoration(
          color: ManagerColors.white,
          borderRadius: BorderRadius.circular(ManagerRadius.r12),
          border: Border.all(
            color: ManagerColors.primaryColor.withOpacity(0.50),
            width: 1.2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: ManagerFontSize.s15, color: ManagerColors.primaryColor),
            SizedBox(width: ManagerWidth.w6),
            Text(
              label,
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s13,
                color: ManagerColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// filled primary button (accept offer)
class _PrimaryBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  const _PrimaryBtn({required this.label, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ManagerRadius.r12),
      child: Container(
        height: ManagerHeight.h40,
        decoration: BoxDecoration(
          color: ManagerColors.primaryColor,
          borderRadius: BorderRadius.circular(ManagerRadius.r12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: ManagerFontSize.s15, color: ManagerColors.white),
            SizedBox(width: ManagerWidth.w6),
            Text(
              label,
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s13,
                color: ManagerColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// disabled grey button (tailor unavailable)
// ignore: unused_element
class _DisabledBtn extends StatelessWidget {
  final String label;

  const _DisabledBtn({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ManagerHeight.h40,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.block_rounded,
              size: ManagerFontSize.s14, color: ManagerColors.greyWhiteColor),
          SizedBox(width: ManagerWidth.w6),
          Text(
            label,
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s12,
              color: ManagerColors.greyWhiteColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// _AcceptOfferBottomSheet — confirmation sheet with full offer overview
// ══════════════════════════════════════════════════════════════════════════════

/// A professional modal bottom sheet that presents a concise offer overview
/// and asks the user to confirm acceptance.
class _AcceptOfferBottomSheet extends StatelessWidget {
  final TailorOfferModel offer;
  final VoidCallback onConfirm;

  const _AcceptOfferBottomSheet({
    required this.offer,
    required this.onConfirm,
  });

  bool get _isBusy => offer.availability == TailorAvailability.busy;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w12),
      // Extra bottom padding for devices with home indicator
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom +
            MediaQuery.of(context).padding.bottom +
            ManagerHeight.h12,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ManagerRadius.r28),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Drag handle ────────────────────────────────────────────────
          _buildDragHandle(),

          SizedBox(height: ManagerHeight.h4),

          // ── Header title ───────────────────────────────────────────────
          _buildSheetTitle(),

          SizedBox(height: ManagerHeight.h20),

          // ── Tailor identity row ────────────────────────────────────────
          _buildTailorRow(context),

          SizedBox(height: ManagerHeight.h16),

          // ── Offer overview grid (price / duration) ─────────────────────
          _buildOfferGrid(),

          SizedBox(height: ManagerHeight.h14),

          // ── Description snippet ────────────────────────────────────────
          _buildDescription(),

          // ── Busy warning (conditional) ─────────────────────────────────
          if (_isBusy) ...[
            SizedBox(height: ManagerHeight.h12),
            _buildBusyWarning(),
          ],

          SizedBox(height: ManagerHeight.h24),

          // ── CTA buttons ────────────────────────────────────────────────
          _buildButtons(context),

          SizedBox(height: ManagerHeight.h8),
        ],
      ),
    );
  }

  // ── Drag handle ──────────────────────────────────────────────────────────

  Widget _buildDragHandle() {
    return Padding(
      padding: EdgeInsets.only(top: ManagerHeight.h12),
      child: Center(
        child: Container(
          width: ManagerWidth.w40,
          height: 4,
          decoration: BoxDecoration(
            color: const Color(0xFFDDDDDD),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  // ── Sheet title ──────────────────────────────────────────────────────────

  Widget _buildSheetTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
      child: Text(
        ManagerStrings.submittedOffersAccept,
        style: getBoldTextStyle(
          fontSize: ManagerFontSize.s17,
          color: ManagerColors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // ── Tailor identity ──────────────────────────────────────────────────────

  Widget _buildTailorRow(BuildContext context) {
    final bool isAvail = !_isBusy;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ManagerColors.primaryColor.withOpacity(0.18),
                width: 2,
              ),
            ),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: offer.tailorAvatarUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  color: ManagerColors.greyWhiteColor.withOpacity(0.12),
                ),
                errorWidget: (_, __, ___) => Container(
                  color: ManagerColors.greyWhiteColor.withOpacity(0.12),
                  child: Icon(Icons.person_outline_rounded,
                      color: ManagerColors.greyWhiteColor),
                ),
              ),
            ),
          ),

          SizedBox(width: ManagerWidth.w12),

          // Name + badge + rating
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  offer.tailorName,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s14,
                    color: ManagerColors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: ManagerHeight.h4),
                Row(
                  children: [
                    // Badge
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ManagerWidth.w7,
                        vertical: ManagerHeight.h2,
                      ),
                      decoration: BoxDecoration(
                        color: ManagerColors.primaryColor.withOpacity(0.10),
                        borderRadius:
                            BorderRadius.circular(ManagerRadius.r20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.verified_rounded,
                              size: ManagerFontSize.s10,
                              color: ManagerColors.primaryColor),
                          SizedBox(width: ManagerWidth.w3),
                          Text(
                            offer.tailorBadge,
                            style: getMediumTextStyle(
                              fontSize: ManagerFontSize.s10,
                              color: ManagerColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: ManagerWidth.w8),

                    // Star rating
                    Icon(Icons.star_rounded,
                        size: ManagerFontSize.s12,
                        color: const Color(0xFFFFC107)),
                    SizedBox(width: ManagerWidth.w2),
                    Text(
                      '${offer.rating}',
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s12,
                        color: ManagerColors.black,
                      ),
                    ),
                    SizedBox(width: ManagerWidth.w2),
                    Text(
                      '(${offer.reviewCount})',
                      style: getRegularTextStyle(
                        fontSize: ManagerFontSize.s11,
                        color: ManagerColors.greyWhiteColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Availability chip
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w8,
              vertical: ManagerHeight.h4,
            ),
            decoration: BoxDecoration(
              color: isAvail
                  ? const Color(0xFF43A047).withOpacity(0.10)
                  : ManagerColors.greyWhiteColor.withOpacity(0.10),
              borderRadius: BorderRadius.circular(ManagerRadius.r20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isAvail
                        ? const Color(0xFF43A047)
                        : ManagerColors.greyWhiteColor,
                  ),
                ),
                SizedBox(width: ManagerWidth.w4),
                Text(
                  isAvail
                      ? ManagerStrings.submittedOffersAvailable
                      : ManagerStrings.submittedOffersBusy,
                  style: getMediumTextStyle(
                    fontSize: ManagerFontSize.s10,
                    color: isAvail
                        ? const Color(0xFF43A047)
                        : ManagerColors.greyWhiteColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Offer overview grid ──────────────────────────────────────────────────

  Widget _buildOfferGrid() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
      child: Row(
        children: [
          // Price tile
          Expanded(
            child: _OverviewTile(
              icon: Icons.payments_outlined,
              iconColor: ManagerColors.primaryColor,
              bgColor: ManagerColors.primaryColor.withOpacity(0.08),
              label: ManagerStrings.submittedOffersPrice,
              value:
                  '${offer.price.toInt()} ${ManagerStrings.submittedOffersCurrency}',
            ),
          ),
          SizedBox(width: ManagerWidth.w10),
          // Duration tile
          Expanded(
            child: _OverviewTile(
              icon: Icons.schedule_rounded,
              iconColor: const Color(0xFF1565C0),
              bgColor: const Color(0xFF1565C0).withOpacity(0.08),
              label: ManagerStrings.submittedOffersDuration,
              value:
                  '${offer.durationDays} ${ManagerStrings.submittedOffersDays}',
            ),
          ),
          SizedBox(width: ManagerWidth.w10),
          // Reviews tile
          Expanded(
            child: _OverviewTile(
              icon: Icons.star_rounded,
              iconColor: const Color(0xFFFFA000),
              bgColor: const Color(0xFFFFA000).withOpacity(0.08),
              label: ManagerStrings.submittedOffersOrders,
              value: '${offer.reviewCount}',
            ),
          ),
        ],
      ),
    );
  }

  // ── Description snippet ──────────────────────────────────────────────────

  Widget _buildDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(ManagerWidth.w14),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(ManagerRadius.r12),
        ),
        child: Text(
          offer.description,
          style: getRegularTextStyle(
            fontSize: ManagerFontSize.s12,
            color: const Color(0xFF555555),
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  // ── Busy warning ─────────────────────────────────────────────────────────

  Widget _buildBusyWarning() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w14,
          vertical: ManagerHeight.h10,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF3E0),
          borderRadius: BorderRadius.circular(ManagerRadius.r12),
          border: Border.all(color: const Color(0xFFFFB300), width: 1),
        ),
        child: Row(
          children: [
            const Icon(Icons.info_outline_rounded,
                color: Color(0xFFFFB300), size: 18),
            SizedBox(width: ManagerWidth.w10),
            Expanded(
              child: Text(
                ManagerStrings.submittedOffersBusyWarning,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s11,
                  color: const Color(0xFF7A5800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── CTA buttons ──────────────────────────────────────────────────────────

  Widget _buildButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
      child: Row(
        children: [
          // Cancel — outline
          Expanded(
            child: _OutlineBtn(
              label: ManagerStrings.cancel,
              icon: Icons.close_rounded,
              onTap: () => Navigator.of(context).pop(),
            ),
          ),

          SizedBox(width: ManagerWidth.w12),

          // Confirm — primary filled
          Expanded(
            flex: 2,
            child: _PrimaryBtn(
              label: ManagerStrings.submittedOffersConfirm,
              icon: Icons.check_circle_rounded,
              onTap: onConfirm,
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// _OverviewTile — compact icon + label + value tile used in the dialog grid
// ══════════════════════════════════════════════════════════════════════════════

class _OverviewTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final String label;
  final String value;

  const _OverviewTile({
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w10,
        vertical: ManagerHeight.h10,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: ManagerFontSize.s18, color: iconColor),
          SizedBox(height: ManagerHeight.h6),
          Text(
            value,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s13,
              color: ManagerColors.black,
            ),
          ),
          SizedBox(height: ManagerHeight.h2),
          Text(
            label,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s10,
              color: ManagerColors.greyWhiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
