import 'package:app_mobile/features/auth/domain/model/demo_accounts.dart';

/// Centralized phone-number validation & normalization for the auth flows.
class PhoneValidator {
  const PhoneValidator._();

  /// Dial codes ordered longest-first for prefix auto-detect.
  static const List<String> knownDialCodes = [
    '+970',
    '+972',
    '+966',
    '+971',
    '+965',
    '+974',
    '+973',
    '+968',
    '+962',
    '+92',
    '+20',
  ];

  static const Map<String, int> _nationalLengths = {
    '+92': 10,
    '+966': 9,
    '+971': 9,
    '+965': 8,
    '+974': 8,
    '+973': 8,
    '+968': 8,
    '+962': 9,
    '+970': 9,
    '+972': 9,
    '+20': 10,
  };

  static const int _defaultLength = 9;

  static int expectedLength(String dialCode) =>
      _nationalLengths[dialCode] ?? _defaultLength;

  /// Allows national + trunk 0 + pasted country code digits.
  static int maxInputLength(String dialCode) =>
      expectedLength(dialCode) + 1 + 4;

  static bool isDemoInput(String raw, [String? dialCode]) {
    final digits = raw.replaceAll(RegExp(r'\D'), '');
    if (DemoAccounts.isDemoPhone(digits)) return true;
    if (RegExp(r'^(971)?000097[1-4]$').hasMatch(digits)) return true;
    if (dialCode != null) {
      final e164 = toE164(raw, dialCode);
      if (DemoAccounts.isDemoPhone(e164)) return true;
    }
    return false;
  }

  /// When user types/pastes digits starting with a country code.
  static ({String dialCode, String national})? detectCountryFromDigits(
    String raw,
  ) {
    final digits = raw.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 3) return null;

    final sorted = [...knownDialCodes]..sort(
        (a, b) => b
            .replaceAll('+', '')
            .length
            .compareTo(a.replaceAll('+', '').length),
      );

    for (final dial in sorted) {
      final cc = dial.replaceAll('+', '');
      if (digits.startsWith(cc) && digits.length > cc.length) {
        return (dialCode: dial, national: digits.substring(cc.length));
      }
    }
    return null;
  }

  /// National digits for [dialCode]. Demo UAE keeps leading zeros.
  static String normalize(String raw, [String? dialCode]) {
    var digits = raw.replaceAll(RegExp(r'\D'), '');

    final cc = (dialCode ?? '').replaceAll('+', '');
    if (cc.isNotEmpty && digits.startsWith(cc) && digits.length > cc.length) {
      digits = digits.substring(cc.length);
    }

    if (RegExp(r'^000097[1-4]$').hasMatch(digits)) return digits;
    if (RegExp(r'^971000097[1-4]$').hasMatch(digits)) {
      return digits.substring(3);
    }

    if (digits.startsWith('0') && digits.length > 1) {
      digits = digits.substring(1);
    }
    return digits;
  }

  static PhoneValidationError? validate(String raw, String dialCode) {
    if (raw.trim().isEmpty) return PhoneValidationError.empty;
    if (isDemoInput(raw, dialCode)) return null;

    final national = normalize(raw, dialCode);
    if (national.length != expectedLength(dialCode)) {
      return PhoneValidationError.invalid;
    }
    if (dialCode == '+92' && !national.startsWith('3')) {
      return PhoneValidationError.invalid;
    }
    if (dialCode == '+971' && !national.startsWith('5')) {
      return PhoneValidationError.invalid;
    }
    return null;
  }

  static bool isValid(String raw, String dialCode) =>
      validate(raw, dialCode) == null;

  /// E.164 digits without `+` (e.g. `9710000971`).
  static String toE164(String raw, String dialCode) {
    final digits = raw.replaceAll(RegExp(r'\D'), '');
    if (RegExp(r'^971000097[1-4]$').hasMatch(digits)) return digits;

    final dial = dialCode.replaceAll('+', '');
    final national = normalize(raw, dialCode);
    if (RegExp(r'^000097[1-4]$').hasMatch(national)) {
      return '971$national';
    }
    return dial + national;
  }
}

enum PhoneValidationError { empty, invalid }
