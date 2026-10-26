import 'package:json_annotation/json_annotation.dart';
import '../../../../../../constants/request_constants/request_constants.dart';

part 'update_shop_profile_request.g.dart';

@JsonSerializable()
class UpdateShopProfileRequest {
  @JsonKey(name: RequestConstants.nameAr)
  final String nameAr;

  @JsonKey(name: RequestConstants.nameEn)
  final String nameEn;

  @JsonKey(name: RequestConstants.bio)
  final String? bio;

  const UpdateShopProfileRequest({
    required this.nameAr,
    required this.nameEn,
    this.bio,
  });

  factory UpdateShopProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateShopProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateShopProfileRequestToJson(this);
}
