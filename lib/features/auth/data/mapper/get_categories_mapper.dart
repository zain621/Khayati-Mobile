import 'package:app_mobile/core/extensions/extensions.dart';
import '../response/get_categories_response.dart';
import '../../domain/model/category_model.dart';

/// Maps CategoryItemResponse → CategoryModel.
extension CategoryItemMapper on CategoryItemResponse {
  CategoryModel toDomain() {
    return CategoryModel(
      id: id.onNull(),
      name: name.onNull(),
    );
  }
}

/// Maps GetCategoriesResponse → GetCategoriesModel.
extension GetCategoriesMapper on GetCategoriesResponse {
  GetCategoriesModel toDomain() {
    return GetCategoriesModel(
      status: status.onNull(),
      code: code.onNull(),
      message: message.onNull(),
      categories:
          data?.items?.map((item) => item.toDomain()).toList() ?? [],
    );
  }
}
