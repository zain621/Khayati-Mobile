import 'package:flutter/material.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';

/// Custom app bar for chat screens with user info.
/// Supports an optional embedded search bar (for conversations list).
class ChatAppBar extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? avatarUrl;
  final bool isOnline;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  /// Search bar (optional — only shown on conversations list)
  final bool showSearchBar;
  final TextEditingController? searchController;
  final FocusNode? searchFocusNode;
  final ValueChanged<String>? onSearchChanged;

  const ChatAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.avatarUrl,
    this.isOnline = false,
    this.showBackButton = true,
    this.onBackPressed,
    this.showSearchBar = false,
    this.searchController,
    this.searchFocusNode,
    this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
     color: ManagerColors.primaryColor,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: ManagerWidth.w16,
        right: ManagerWidth.w16,
        bottom: ManagerHeight.h18,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Title row
          Row(
            children: [
              /// Back button (arrow →)
              if (showBackButton)
                GestureDetector(
                  onTap: onBackPressed ?? () => Navigator.pop(context),
                  child: Container(
                    width: ManagerWidth.w32,
                    height: ManagerHeight.h32,
                    decoration: BoxDecoration(
                      color: ManagerColors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(ManagerRadius.r8),
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: ManagerColors.white,
                      size: ManagerWidth.w18,
                    ),
                  ),
                ),

              if (showBackButton) SizedBox(width: ManagerWidth.w10),

              /// Avatar (only for chat detail)
              if (avatarUrl != null || isOnline)
                Stack(
                  children: [
                    Container(
                      width: ManagerWidth.w36,
                      height: ManagerHeight.h36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ManagerColors.white.withOpacity(0.2),
                        border: Border.all(
                          color: ManagerColors.white.withOpacity(0.5),
                          width: 1.5,
                        ),
                        image: avatarUrl != null && avatarUrl!.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(avatarUrl!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: avatarUrl == null || avatarUrl!.isEmpty
                          ? Icon(
                              Icons.person,
                              color: ManagerColors.white,
                              size: ManagerWidth.w20,
                            )
                          : null,
                    ),
                    if (isOnline)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          width: ManagerWidth.w10,
                          height: ManagerHeight.h10,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF50),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: ManagerColors.white,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),

              if (avatarUrl != null || isOnline)
                SizedBox(width: ManagerWidth.w10),

              /// Title and subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s16,
                        color: ManagerColors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: ManagerHeight.h3),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Status dot (green = online, grey = offline)
                          Container(
                            width: ManagerWidth.w7,
                            height: ManagerHeight.h7,
                            margin: EdgeInsets.only(left: ManagerWidth.w5),
                            decoration: BoxDecoration(
                              color: isOnline
                                  ? const Color(0xFF69F0AE)
                                  : ManagerColors.white.withOpacity(0.45),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Text(
                            subtitle!,
                            style: getRegularTextStyle(
                              fontSize: ManagerFontSize.s11,
                              color: ManagerColors.white.withOpacity(0.85),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          /// Search bar (embedded inside the green app bar)
          if (showSearchBar) ...[
            SizedBox(height: ManagerHeight.h12),
            Container(
              height: ManagerHeight.h40,
              decoration: BoxDecoration(
                color: ManagerColors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(ManagerRadius.r8),
              ),
              child: TextField(
                controller: searchController,
                focusNode: searchFocusNode,
                textAlign: TextAlign.right,
                textDirection: Directionality.of(context),
                onChanged: onSearchChanged,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s13,
                  color: ManagerColors.black,
                ),
                decoration: InputDecoration(
                  hintText: ManagerStrings.chatSearchHint,
                  hintStyle: getRegularTextStyle(
                    fontSize: ManagerFontSize.s13,
                    color: ManagerColors.white,
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: ManagerColors.white,
                    size: ManagerWidth.w20,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: ManagerWidth.w14,
                    vertical: ManagerHeight.h10,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
