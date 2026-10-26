/// Shared demo credentials for the four mobile roles.
/// Must stay in sync with `Khayati-backend/src/constants/demo.constants.ts`.
class DemoAccount {
  const DemoAccount({
    required this.role,
    required this.fullName,
    required this.dialCode,
    required this.nationalNumber,
    required this.e164Phone,
  });

  final String role;
  final String fullName;
  final String dialCode;
  final String nationalNumber;
  final String e164Phone;
}

class DemoAccounts {
  const DemoAccounts._();

  static const String otp = '000000';
  static const String password = 'Demo@123';
  static const String couponCode = 'KHAYATI10';

  static const DemoAccount customer = DemoAccount(
    role: 'user',
    fullName: 'Sara Khayati',
    dialCode: '+971',
    nationalNumber: '0000971',
    e164Phone: '9710000971',
  );

  static const DemoAccount independentTailor = DemoAccount(
    role: 'independent_tailor',
    fullName: 'Ahmed Independent',
    dialCode: '+971',
    nationalNumber: '0000972',
    e164Phone: '9710000972',
  );

  static const DemoAccount shopOwner = DemoAccount(
    role: 'shop_owner',
    fullName: 'Ahmed Shop',
    dialCode: '+971',
    nationalNumber: '0000973',
    e164Phone: '9710000973',
  );

  static const DemoAccount comprehensiveTailor = DemoAccount(
    role: 'comprehensive_tailor',
    fullName: 'Fatima Comprehensive',
    dialCode: '+971',
    nationalNumber: '0000974',
    e164Phone: '9710000974',
  );

  static const List<DemoAccount> all = [
    customer,
    independentTailor,
    shopOwner,
    comprehensiveTailor,
  ];

  static bool isDemoPhone(String? phone) {
    if (phone == null || phone.isEmpty) return false;
    final digits = phone.replaceAll(RegExp(r'\D'), '');
    return all.any(
      (account) =>
          digits == account.e164Phone ||
          digits == account.nationalNumber ||
          digits.endsWith(account.nationalNumber) ||
          digits.endsWith(account.e164Phone),
    );
  }
}
