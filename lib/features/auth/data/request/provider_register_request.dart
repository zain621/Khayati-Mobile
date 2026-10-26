/// Request body for the provider register endpoint.
class ProviderRegisterRequest {
  final String role;
  final String businessName;
  final String ownerName;
  final String phone;
  final String? email;
  final String city;
  final String latitude;
  final String longitude;
  final String detailedAddress;
  final String yearsOfExperience;
  final String bio;
  final List<String> categoryIds;
  final String? agreementSignerName;
  final String? agreementSignatureDataUrl;
  final String? agreementVersion;
  final Map<String, dynamic>? agreementPayload;

  ProviderRegisterRequest({
    required this.role,
    required this.businessName,
    required this.ownerName,
    required this.phone,
    this.email,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.detailedAddress,
    required this.yearsOfExperience,
    required this.bio,
    required this.categoryIds,
    this.agreementSignerName,
    this.agreementSignatureDataUrl,
    this.agreementVersion,
    this.agreementPayload,
  });

  bool get needsVendorAgreement =>
      role == 'independent_tailor' || role == 'comprehensive_tailor';
}
