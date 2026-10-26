import 'package:app_mobile/core/extensions/extensions.dart';
import '../response/update_user_profile_response.dart';
import '../../domain/model/update_user_profile_model.dart';

/// Maps [UpdateUserProfileDataResponse] → [UpdateUserProfileModel].
extension UpdateUserProfileDataMapper on UpdateUserProfileDataResponse {
  UpdateUserProfileModel toDomain() {
    return UpdateUserProfileModel(
      fullName: fullName.onNull(),
      phoneNumber: phoneNumber.onNull(),
      image: image,
    );
  }
}

/// Maps top-level [UpdateUserProfileResponse] → [UpdateUserProfileModel].
extension UpdateUserProfileMapper on UpdateUserProfileResponse {
  UpdateUserProfileModel toDomain() {
    return data!.toDomain();
  }
}
