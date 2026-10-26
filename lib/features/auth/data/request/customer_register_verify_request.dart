class CustomerRegisterVerifyRequest {
  final String phoneNumber;
  final String code;

  CustomerRegisterVerifyRequest({
    required this.phoneNumber,
    required this.code,
  });
}
