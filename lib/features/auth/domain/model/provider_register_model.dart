/// Domain model for the provider register API response.
class ProviderRegisterModel {
  final String status;
  final int code;
  final String message;
  final String requestId;

  ProviderRegisterModel({
    required this.status,
    required this.code,
    required this.message,
    required this.requestId,
  });
}
