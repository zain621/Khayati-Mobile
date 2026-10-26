/// Request model for the login OTP verification endpoint.
/// Sent when the provider submits their OTP after the initial login.
class CompleteLoginWithCodeRequest {
  final String phoneNumber;
  final String code;

  CompleteLoginWithCodeRequest({
    required this.phoneNumber,
    required this.code,
  });
}
