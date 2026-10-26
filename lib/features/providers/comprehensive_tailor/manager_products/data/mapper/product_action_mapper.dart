import 'package:app_mobile/core/extensions/extensions.dart';
import '../response/product_action_response.dart';
import '../../domain/model/product_action_model.dart';

/// Mapper extension for ProductActionResponse to ProductActionModel.
extension ProductActionMapper on ProductActionResponse {
  ProductActionModel toDomain() {
    return ProductActionModel(
      status: status.onNull(),
      message: message.onNull(),
    );
  }
}
