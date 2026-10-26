import 'package:app_mobile/core/extensions/extensions.dart';
import '../response/user_profile_response.dart';
import '../../domain/model/user_profile_model.dart';

/// Maps UserProfileDataResponse → UserProfileModel.
extension UserProfileDataMapper on UserProfileDataResponse {
  UserProfileModel toDomain() {
    return UserProfileModel(
      fullName: fullName.onNull(),
      phoneNumber: phoneNumber.onNull(),
      image: image,
      completedOrdersCount: completedOrdersCount.onNull(),
      inProgressOrdersCount: inProgressOrdersCount.onNull(),
      loyaltyPoints: loyaltyPoints.onNull(),
    );
  }
}

/// Maps UserProfileResponse → UserProfileModel.
extension UserProfileMapper on UserProfileResponse {
  UserProfileModel toDomain() {
    return data!.toDomain();
  }
}
