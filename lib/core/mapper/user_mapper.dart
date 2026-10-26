import 'package:app_mobile/core/extensions/extensions.dart';
import '../model/user_model.dart';
import '../response/user_response.dart';

/// Maps UserResponse → UserModel.
/// Lives in core because UserResponse/UserModel are shared across all features and roles.
extension UserMapper on UserResponse {
  UserModel toDomain() {
    return UserModel(
      id: id.onNull(),
      fullName: fullName.onNull(),
      image: image,
      phoneNumber: phoneNumber.onNull(),
      role: role.onNull(),
    );
  }
}
