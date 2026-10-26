import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/features/user/home_user/domain/model/home_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Home screen section — "أفضل الخياطين" vertical list of tailor cards.
class HomeBestTailorsWidget extends StatelessWidget {
  final List<HomeTailorModel>? tailors;

  // Called when the user taps "عرض الكل"
  final VoidCallback? onViewAll;

  // Called when the user taps a tailor card
  final void Function(HomeTailorModel tailor)? onTailorTap;

  const HomeBestTailorsWidget({
    super.key,
    this.tailors,
    this.onViewAll,
    this.onTailorTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<HomeTailorModel> resolvedTailors = tailors ?? [];

    if (resolvedTailors.isEmpty) return const SizedBox.shrink();

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
                ManagerStrings.userHomeBestTailorsTitle,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s16,
                  color: ManagerColors.black,
                ),
              ),
              const Spacer(),
              // View all button
              // GestureDetector(
              //   onTap: onViewAll,
              //   child: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       Text(
              //         ManagerStrings.userHomeViewAll,
              //         style: getMediumTextStyle(
              //           fontSize: ManagerFontSize.s13,
              //           color: ManagerColors.primaryColor,
              //         ),
              //       ),
              //       SizedBox(width: ManagerWidth.w4),
              //       Icon(
              //         Icons.arrow_forward_rounded,
              //         size: ManagerWidth.w16,
              //         color: ManagerColors.primaryColor,
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),

        SizedBox(height: ManagerHeight.h14),

        // Vertical list — each card separated by spacing
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
          itemCount: resolvedTailors.length,
          separatorBuilder: (_, __) => SizedBox(height: ManagerHeight.h12),
          itemBuilder: (context, index) {
            final tailor = resolvedTailors[index];
            return _TailorCard(
              tailor: tailor,
              onTap: () => onTailorTap?.call(tailor),
            );
          },
        ),
      ],
    );
  }
}

class _TailorCard extends StatelessWidget {
  final HomeTailorModel tailor;
  final VoidCallback? onTap;

  const _TailorCard({required this.tailor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // padding: EdgeInsets.all(ManagerWidth.w14),
        decoration: BoxDecoration(
          color: ManagerColors.white,
          borderRadius: BorderRadius.circular(ManagerRadius.r16),
          boxShadow: [
            BoxShadow(
              color: ManagerColors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row 1: avatar + content
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ManagerWidth.w12, vertical: ManagerHeight.h12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TailorAvatar(imageUrl: tailor.imageUrl),
                  SizedBox(width: ManagerWidth.w12),
                  Expanded(child: _TailorCardContent(tailor: tailor)),
                ],
              ),
            ),
            _TailorStatusBar(tailor: tailor),
          ],
        ),
      ),
    );
  }
}

/// Bottom status bar — shows availability state with a colored dot + label.
class _TailorStatusBar extends StatelessWidget {
  final HomeTailorModel tailor;

  const _TailorStatusBar({required this.tailor});

  static const Color _availableColor = Color(0xFF0AAD46);
  static const Color _availableBg = Color(0xFFEEFDF5);

  // Maps rank string → foreground colour
  static Color _fgColor(String rank) {
    switch (rank.toLowerCase()) {
      case 'master':
        return const Color(0xFFE53935);
      case 'gold':
        return const Color(0xFFF9A825);
      case 'silver':
        return const Color(0xFF607D8B);
      default:
        return _availableColor; // 'new' or unrecognised
    }
  }

  // Maps rank string → background colour
  static Color _bgColor(String rank) {
    switch (rank.toLowerCase()) {
      case 'master':
        return const Color(0xFFFFF3F3);
      case 'gold':
        return const Color(0xFFFFFDE7);
      case 'silver':
        return const Color(0xFFF0F4F8);
      default:
        return _availableBg;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color statusColor = _fgColor(tailor.rank);
    final Color bgColor = _bgColor(tailor.rank);

    return Container(
      height: ManagerHeight.h28,
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(ManagerRadius.r12),
          bottomRight: Radius.circular(ManagerRadius.r12),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w12),
      child: Row(
        children: [
          // Status dot
          Container(
            width: ManagerWidth.w8,
            height: ManagerWidth.w8,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: ManagerWidth.w6),
          // Rank label
          Text(
            tailor.rankLabel,
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s11,
              color: statusColor,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: ManagerWidth.w16,
            color: statusColor,
          ),
        ],
      ),
    );
  }
}

/// The text/data content section inside the tailor card.
class _TailorCardContent extends StatelessWidget {
  final HomeTailorModel tailor;

  const _TailorCardContent({required this.tailor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row 1: name (right) + rank badge (left)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Name
            Flexible(
              child: Text(
                tailor.name,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s12,
                  color: ManagerColors.black,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
              ),
            ), // Rank badge
            _RankBadge(label: tailor.rankLabel),
          ],
        ),

        SizedBox(height: ManagerHeight.h8),

        // Row 2: rating
        _RatingRow(rating: tailor.rating, reviewCount: tailor.reviewCount),

        SizedBox(height: ManagerHeight.h8),

        // Row 3: offer count chips
        Wrap(
          spacing: ManagerWidth.w6,
          runSpacing: ManagerHeight.h4,
          children: [
            _SpecTag(
              label:
                  '${tailor.offersCount} ${ManagerStrings.tailorOffersCount}',
            ),
          ],
        ),

        SizedBox(height: ManagerHeight.h10),

        // Row 4: completed orders count
        _InfoChip(
          icon: Icons.check_circle_outline_rounded,
          label:
              '${tailor.ordersCount} ${ManagerStrings.tailorCompletedOrders}',
        ),
      ],
    );
  }
}

/// Rounded tailor avatar image.
class _TailorAvatar extends StatelessWidget {
  final String? imageUrl;

  const _TailorAvatar({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final safeUrl = _safeImageUrl(imageUrl);

    if (safeUrl == null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(ManagerRadius.r8),
        child: Container(
          width: ManagerWidth.w64,
          height: ManagerHeight.h64,
          color: ManagerColors.greyWhiteColor.withOpacity(0.15),
          child: Icon(
            Icons.person_rounded,
            color: ManagerColors.greyWhiteColor,
            size: ManagerWidth.w32,
          ),
        ),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(ManagerRadius.r8),
      child: CachedNetworkImage(
        imageUrl: safeUrl,
        width: ManagerWidth.w64,
        height: ManagerHeight.h64,
        fit: BoxFit.cover,
        fadeInDuration: const Duration(milliseconds: 220),
        placeholder: (_, __) => const _AvatarLoadingPlaceholder(),
        errorWidget: (_, __, ___) => Container(
          width: ManagerWidth.w64,
          height: ManagerHeight.h64,
          color: ManagerColors.greyWhiteColor.withOpacity(0.15),
          child: Icon(
            Icons.person_rounded,
            color: ManagerColors.greyWhiteColor,
            size: ManagerWidth.w32,
          ),
        ),
      ),
    );
  }
}

/// Light green rank badge — e.g. "خياط متمكن 👑".
class _AvatarLoadingPlaceholder extends StatelessWidget {
  const _AvatarLoadingPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE4ECE8),
      highlightColor: const Color(0xFFF8FBF9),
      child: Container(
        width: ManagerWidth.w64,
        height: ManagerHeight.h64,
        color: ManagerColors.white,
        padding: EdgeInsets.all(ManagerWidth.w14),
        child: const DecoratedBox(
          decoration: BoxDecoration(
            color: ManagerColors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

String? _safeImageUrl(String? value) {
  if (value == null) return null;

  final normalized = value.trim();
  if (normalized.isEmpty || normalized.toLowerCase() == 'null') {
    return null;
  }

  final uri = Uri.tryParse(normalized);
  if (uri == null || !uri.hasScheme || !uri.hasAuthority) {
    return null;
  }

  return normalized;
}

class _RankBadge extends StatelessWidget {
  final String label;

  const _RankBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w12,
        vertical: ManagerHeight.h4,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.primaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(ManagerRadius.r20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s10,
              color: ManagerColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingRow extends StatelessWidget {
  final double rating;
  final int reviewCount;

  const _RatingRow({required this.rating, required this.reviewCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.star_rounded,
          size: ManagerWidth.w14,
          color: const Color(0xFFFFC107),
        ),
        SizedBox(width: ManagerWidth.w3),
        Text(
          rating.toString(),
          style: getBoldTextStyle(
            fontSize: ManagerFontSize.s12,
            color: ManagerColors.black,
          ),
        ),
        Text(
          '($reviewCount)',
          style: getRegularTextStyle(
            fontSize: ManagerFontSize.s10,
            color: ManagerColors.greyWhiteColor,
          ),
        ),
        SizedBox(width: ManagerWidth.w4),
      ],
    );
  }
}

/// Grey pill chip for tailor specialization tags.
class _SpecTag extends StatelessWidget {
  final String label;

  const _SpecTag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w12,
        vertical: ManagerHeight.h4,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.primaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(ManagerRadius.r20),
        // border: Border.all(
        //   color: ManagerColors.greyWhiteColor.withOpacity(0.25),
        //   width: 1,
        // ),
      ),
      child: Text(
        label,
        style: getRegularTextStyle(
          fontSize: ManagerFontSize.s10,
          color: ManagerColors.primaryColor,
        ),
      ),
    );
  }
}

/// Small icon + text info chip — used for price and duration.
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: ManagerWidth.w13,
          color: ManagerColors.primaryColor,
        ),
        SizedBox(width: ManagerWidth.w4),
        Text(
          label,
          style: getBoldTextStyle(
            fontSize: ManagerFontSize.s12,
            color: ManagerColors.greyWhiteColor,
          ),
        ),
      ],
    );
  }
}
