class ContactUsRequest {
  final String name;
  final String email;
  final String subject;
  final String message;

  const ContactUsRequest({
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
  });
}
