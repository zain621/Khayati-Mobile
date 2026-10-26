import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/button_app.dart';
import 'package:app_mobile/features/providers/common_features/profile/domain/model/provider_profile_model.dart';
import 'package:app_mobile/features/providers/common_features/profile/presentation/controller/portfolio_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Portfolio Bottom Sheet
// ─────────────────────────────────────────────────────────────────────────────

Future<void> showPortfolioBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _PortfolioSheet(),
  );
}

// ══════════════════════════════════════════════════════════════════════════════

class _PortfolioSheet extends StatelessWidget {
  const _PortfolioSheet();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      bottom: true,
      child: Container(
        decoration: BoxDecoration(
          color: ManagerColors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(ManagerRadius.r24),
          ),
        ),
        padding: EdgeInsets.fromLTRB(
          ManagerWidth.w20,
          ManagerHeight.h16,
          ManagerWidth.w20,
          ManagerHeight.h16 + bottomInset,
        ),
        child: Obx(() {
          final images = controller.images;
          final bool canAdd = images.length < PortfolioController.maxPhotos;
          final int totalCells = images.length + (canAdd ? 1 : 0);

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Drag handle ──────────────────────────────────────────────
              Center(
                child: Container(
                  width: ManagerWidth.w40,
                  height: ManagerHeight.h4,
                  decoration: BoxDecoration(
                    color: ManagerColors.greyWhiteColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(ManagerRadius.r4),
                  ),
                ),
              ),

              SizedBox(height: ManagerHeight.h16),

              // ── Header: title + close ────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ManagerStrings.portfolioTitle,
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s17,
                      color: ManagerColors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: ManagerWidth.w32,
                      height: ManagerHeight.h32,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(ManagerRadius.r8),
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        size: ManagerFontSize.s18,
                        color: ManagerColors.greyWhiteColor,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: ManagerHeight.h20),

              // ── Loading indicator while adding ───────────────────────────
              if (controller.isAddingImage.value)
                Padding(
                  padding: EdgeInsets.only(bottom: ManagerHeight.h12),
                  child: LinearProgressIndicator(
                    color: ManagerColors.primaryColor,
                    backgroundColor: ManagerColors.primaryColor.withOpacity(0.12),
                    minHeight: 2,
                  ),
                ),

              // ── Photo grid ───────────────────────────────────────────────
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.45,
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: ManagerWidth.w8,
                    mainAxisSpacing: ManagerHeight.h8,
                  ),
                  itemCount: totalCells,
                  itemBuilder: (_, index) {
                    final bool isAddCell = canAdd && index == images.length;

                    if (isAddCell) {
                      return _AddPhotoCell(
                        onTap: controller.isAddingImage.value
                            ? null
                            : controller.pickAndAddImages,
                      );
                    }

                    final image = images[index];
                    final bool isDeleting =
                        controller.isDeletingImage.value &&
                        controller.deletingImageId.value == image.id;

                    return _PhotoCell(
                      image: image,
                      isDeleting: isDeleting,
                      onRemove: () => controller.deleteImage(image.id),
                    );
                  },
                ),
              ),

              // ── Hint text ────────────────────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(vertical: ManagerHeight.h12),
                child: Center(
                  child: Text(
                    ManagerStrings.portfolioHint,
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s12,
                      color: ManagerColors.greyWhiteColor,
                    ),
                  ),
                ),
              ),

              // ── Done button ──────────────────────────────────────────────
              ButtonApp(
                onPressed: () => Navigator.pop(context),
                title: ManagerStrings.portfolioDoneButton,
                paddingWidth: 0,
              ),
            ],
          );
        }),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Photo cell (network image from server)
// ══════════════════════════════════════════════════════════════════════════════

class _PhotoCell extends StatelessWidget {
  final PortfolioImageModel image;
  final bool isDeleting;
  final VoidCallback onRemove;

  const _PhotoCell({
    required this.image,
    required this.isDeleting,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Network image
        ClipRRect(
          borderRadius: BorderRadius.circular(ManagerRadius.r12),
          child: CachedNetworkImage(
            imageUrl: image.imageUrl,
            fit: BoxFit.cover,
            placeholder: (_, __) => Container(
              color: ManagerColors.greyWhiteColor.withOpacity(0.15),
            ),
            errorWidget: (_, __, ___) => Container(
              color: ManagerColors.greyWhiteColor.withOpacity(0.15),
              child: Icon(
                Icons.broken_image_outlined,
                color: ManagerColors.greyWhiteColor,
                size: ManagerFontSize.s20,
              ),
            ),
          ),
        ),

        // Loading overlay while deleting
        if (isDeleting)
          ClipRRect(
            borderRadius: BorderRadius.circular(ManagerRadius.r12),
            child: Container(
              color: ManagerColors.black.withOpacity(0.45),
              child: Center(
                child: SizedBox(
                  width: ManagerWidth.w20,
                  height: ManagerHeight.h20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: ManagerColors.white,
                  ),
                ),
              ),
            ),
          ),

        // Remove button (top-left) — hidden while deleting
        if (!isDeleting)
          Positioned(
            top: ManagerHeight.h4,
            left: ManagerWidth.w4,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                width: ManagerWidth.w22,
                height: ManagerHeight.h22,
                decoration: BoxDecoration(
                  color: ManagerColors.black.withOpacity(0.45),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close_rounded,
                  size: ManagerFontSize.s13,
                  color: ManagerColors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Add photo cell
// ══════════════════════════════════════════════════════════════════════════════

class _AddPhotoCell extends StatelessWidget {
  final VoidCallback? onTap;

  const _AddPhotoCell({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(ManagerRadius.r12),
          border: Border.all(
            color: ManagerColors.greyWhiteColor.withOpacity(0.2),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_rounded,
              size: ManagerFontSize.s28,
              color: ManagerColors.greyWhiteColor.withOpacity(0.7),
            ),
            SizedBox(height: ManagerHeight.h4),
            Text(
              ManagerStrings.portfolioAddLabel,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s12,
                color: ManagerColors.greyWhiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// ─────────────────────────────────────────────────────────────────────────────
// Portfolio Bottom Sheet
// ─────────────────────────────────────────────────────────────────────────────
