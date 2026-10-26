/// Domain model for customer register step-1 API response.
class CustomerRegisterModel {
  final String status;
  final int code;
  final String message;
  final String verificationCode;

  CustomerRegisterModel({
    required this.status,
    required this.code,
    required this.message,
    required this.verificationCode,
  });
}
