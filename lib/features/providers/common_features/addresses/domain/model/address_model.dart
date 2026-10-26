class AddressModel {
  final String id;
  final String fullName;
  final double latitude;
  final double longitude;
  final String detailedDescription;
  final String createdAt;
  final String updatedAt;

  AddressModel({
    required this.id,
    required this.fullName,
    required this.latitude,
    required this.longitude,
    required this.detailedDescription,
    required this.createdAt,
    required this.updatedAt,
  });
}
