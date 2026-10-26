/// Domain model for a single category.
class CategoryModel {
  final String id;
  final String name;

  CategoryModel({
    required this.id,
    required this.name,
  });
}

/// Domain model for the get categories API response.
class GetCategoriesModel {
  final String status;
  final int code;
  final String message;
  final List<CategoryModel> categories;

  GetCategoriesModel({
    required this.status,
    required this.code,
    required this.message,
    required this.categories,
  });
}
