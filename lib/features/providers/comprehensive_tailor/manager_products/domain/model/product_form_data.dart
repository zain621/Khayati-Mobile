import 'package:image_picker/image_picker.dart';
import 'selected_color_entry.dart';

/// Complete form data for adding or editing a product.
class ProductFormData {
  final String name;
  final String categoryId;
  final double price;
  final double? priceBeforeDiscount;
  final String description;
  final int stockCount;
  final List<SelectedColorEntry> colors;
  final List<String> sizes;
  final List<XFile> images;

  const ProductFormData({
    required this.name,
    required this.categoryId,
    required this.price,
    this.priceBeforeDiscount,
    required this.description,
    required this.stockCount,
    required this.colors,
    required this.sizes,
    required this.images,
  });
}
