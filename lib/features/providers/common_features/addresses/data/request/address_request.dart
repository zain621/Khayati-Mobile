class AddressRequest {
  final String fullName;
  final double latitude;
  final double longitude;
  final String detailedDescription;

  AddressRequest({
    required this.fullName,
    required this.latitude,
    required this.longitude,
    required this.detailedDescription,
  });
}
