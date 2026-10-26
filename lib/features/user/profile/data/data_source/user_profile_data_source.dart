import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:app_mobile/core/network/app_api.dart';
import 'package:app_mobile/constants/request_constants/request_constants.dart';
import 'package:app_mobile/constants/request_constants/request_constants_endpoints.dart';
import '../request/update_user_profile_request.dart';
import '../response/update_user_profile_response.dart';
import '../response/user_profile_response.dart';

abstract class UserProfileDataSource {
  Future<UserProfileResponse> fetchProfile();
  Future<UpdateUserProfileResponse> updateProfile(UpdateUserProfileRequest request);
}

class UserProfileDataSourceImplement implements UserProfileDataSource {
  final AppService _appService;
  final Dio _dio;

  UserProfileDataSourceImplement(this._appService, this._dio);

  @override
  Future<UserProfileResponse> fetchProfile() async {
    return await _appService.getUserProfile();
  }

  @override
  Future<UpdateUserProfileResponse> updateProfile(
    UpdateUserProfileRequest request,
  ) async {
    final formMap = <String, dynamic>{
      RequestConstants.fullName: request.fullName,
    };

    if (request.image != null) {
      final path = request.image!.path;
      final extension = path.split('.').last.toLowerCase();
      final mimeType = switch (extension) {
        'png' => 'image/png',
        'gif' => 'image/gif',
        'webp' => 'image/webp',
        _ => 'image/jpeg',
      };
      formMap[RequestConstants.image] = await MultipartFile.fromFile(
        path,
        filename: path.split('/').last.split('\\').last,
        contentType: MediaType.parse(mimeType),
      );
    }

    final response = await _dio.patch(
      RequestConstantsEndpoints.userProfile,
      data: FormData.fromMap(formMap),
    );
    return UpdateUserProfileResponse.fromJson(response.data);
  }
}
