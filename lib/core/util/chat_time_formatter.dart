/// Formats an ISO‑8601 date string into Arabic chat time (e.g. "02:30 م").
String formatMessageTime(String isoString) {
  try {
    final date = DateTime.parse(isoString).toLocal();
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final period = date.hour < 12 ? 'ص' : 'م';
    return '${hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} $period';
  } catch (_) {
    return '';
  }
}

/// Formats an ISO‑8601 date for conversation list:
/// today → time, yesterday → "أمس", older → day/month.
String formatConversationTime(String isoString) {
  try {
    final date = DateTime.parse(isoString).toLocal();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final msgDay = DateTime(date.year, date.month, date.day);

    if (msgDay == today) {
      return formatMessageTime(isoString);
    } else if (msgDay == today.subtract(const Duration(days: 1))) {
      return 'أمس';
    } else {
      return '${date.day}/${date.month}';
    }
  } catch (_) {
    return '';
  }
}
