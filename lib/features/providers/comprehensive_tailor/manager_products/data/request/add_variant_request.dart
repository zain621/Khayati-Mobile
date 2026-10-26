/// Request data for adding or updating a product variant.
class AddVariantRequest {
  final String color;
  final String colorHexCode;
  final String size;
  final int quantity;

  const AddVariantRequest({
    required this.color,
    required this.colorHexCode,
    required this.size,
    required this.quantity,
  });

  Map<String, dynamic> toMap() => {
        'color': color,
        'colorHexCode': colorHexCode,
        'size': size,
        'quantity': quantity,
      };
}
