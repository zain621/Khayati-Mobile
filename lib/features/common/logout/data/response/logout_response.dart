class LogoutResponse {
  final String? message;

  const LogoutResponse({this.message});

  factory LogoutResponse.fromJson(Map<String, dynamic> json) =>
      LogoutResponse(message: json['message'] as String?);
}
