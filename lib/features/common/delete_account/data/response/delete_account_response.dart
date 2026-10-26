class DeleteAccountResponse {
  final String? message;

  const DeleteAccountResponse({this.message});

  factory DeleteAccountResponse.fromJson(Map<String, dynamic> json) =>
      DeleteAccountResponse(message: json['message'] as String?);
}
