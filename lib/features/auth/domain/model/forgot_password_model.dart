/// Result of a successful forgot-password call.
/// Holds the userId needed for the verify-code step.
class ForgotPasswordModel {
  final String userId;

  const ForgotPasswordModel({required this.userId});
}
