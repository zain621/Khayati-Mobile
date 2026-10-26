import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resources/manager_colors.dart';
import '../resources/manager_font_size.dart';
import '../resources/manager_styles.dart';

class AppSnackbar {
  static bool get isArabic => Get.locale?.languageCode == 'ar';

  static void _showSnackBar({
    required BuildContext? context,
    required Widget titleWidget,
    required Widget messageWidget,
    required Color backgroundColor,
    required IconData icon,
    required Color iconColor,
    int durationSeconds = 3,
  }) {
    final buildContext = context ?? Get.context;
    if (buildContext == null) return;

    // Keep snackbar above fixed bottom bars (cart checkout, nav, safe area).
    final bottomInset = MediaQuery.of(buildContext).viewPadding.bottom;
    ScaffoldMessenger.of(buildContext)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleWidget,
                    const SizedBox(height: 4),
                    messageWidget,
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: backgroundColor,
          margin: EdgeInsets.fromLTRB(16, 12, 16, 96 + bottomInset),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          duration: Duration(seconds: durationSeconds),
          dismissDirection: DismissDirection.horizontal,
        ),
      );
  }

  /// عرض رسالة نجاح
  static void success(
    String arabicMessage, {
    String? englishMessage,
    String? title,
  }) {
    final isArabic = Get.locale?.languageCode == 'ar';
    final message = isArabic ? arabicMessage : (englishMessage ?? arabicMessage);

    _showSnackBar(
      context: null,
      titleWidget: Text(
        title ?? (isArabic ? 'تم بنجاح' : 'Success'),
        style: getBoldTextStyle(
          fontSize: ManagerFontSize.s14,
          color: Colors.green.shade900,
        ),
      ),
      messageWidget: Text(
        message,
        style: getRegularTextStyle(
          fontSize: ManagerFontSize.s12,
          color: ManagerColors.black,
        ),
      ),
      backgroundColor: Colors.green.shade100,
      icon: Icons.check_circle,
      iconColor: Colors.green,
      durationSeconds: 3,
    );
  }

  /// عرض رسالة خطأ
  static void error(
    String arabicMessage, {
    String? englishMessage,
    String? title,
  }) {
    final isArabic = Get.locale?.languageCode == 'ar';
    final message = isArabic ? arabicMessage : (englishMessage ?? arabicMessage);

    _showSnackBar(
      context: null,
      titleWidget: Text(
        title ?? (isArabic ? 'حدث خطأ' : 'Error'),
        style: getBoldTextStyle(
          fontSize: ManagerFontSize.s14,
          color: Colors.red.shade900,
        ),
      ),
      messageWidget: Text(
        message,
        maxLines: 8,
        overflow: TextOverflow.ellipsis,
        style: getRegularTextStyle(
          fontSize: ManagerFontSize.s12,
          color: ManagerColors.black,
        ),
      ),
      backgroundColor: Colors.red.shade100,
      icon: Icons.error_outline,
      iconColor: Colors.red,
      durationSeconds: 5,
    );
  }

  /// عرض رسالة تحذير
  static void warning(
    String arabicMessage, {
    String? englishMessage,
    String? title,
  }) {
    final isArabic = Get.locale?.languageCode == 'ar';
    final message = isArabic ? arabicMessage : (englishMessage ?? arabicMessage);

    _showSnackBar(
      context: null,
      titleWidget: Text(
        title ?? (isArabic ? 'تنبيه' : 'Warning'),
        style: getBoldTextStyle(
          fontSize: ManagerFontSize.s14,
          color: Colors.orange.shade900,
        ),
      ),
      messageWidget: Text(
        message,
        style: getRegularTextStyle(
          fontSize: ManagerFontSize.s12,
          color: ManagerColors.black,
        ),
      ),
      backgroundColor: Colors.orange.shade100,
      icon: Icons.warning_amber_outlined,
      iconColor: Colors.orange,
      durationSeconds: 3,
    );
  }

  /// عرض رسالة معالجة/تحميل
  static void loading(
    String arabicMessage, {
    String? englishMessage,
    String? title,
  }) {
    final isArabic = Get.locale?.languageCode == 'ar';
    final message = isArabic ? arabicMessage : (englishMessage ?? arabicMessage);

    _showSnackBar(
      context: null,
      titleWidget: Text(
        title ?? (isArabic ? 'جاري المعالجة' : 'Processing...'),
        style: getBoldTextStyle(
          fontSize: ManagerFontSize.s14,
          color: Colors.blue.shade900,
        ),
      ),
      messageWidget: Text(
        message,
        style: getRegularTextStyle(
          fontSize: ManagerFontSize.s12,
          color: ManagerColors.black,
        ),
      ),
      backgroundColor: Colors.blue.shade100,
      icon: Icons.hourglass_bottom,
      iconColor: Colors.blue,
      durationSeconds: 2,
    );
  }

}
