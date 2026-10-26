import 'package:json_annotation/json_annotation.dart';
import '../../../../../../constants/response_constants/response_constants.dart';

part 'shop_owner_home_response.g.dart';

@JsonSerializable()
class ShopOwnerHomeResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;

  @JsonKey(name: ResponseConstants.code)
  int? code;

  @JsonKey(name: ResponseConstants.message)
  String? message;

  @JsonKey(name: ResponseConstants.data)
  ShopOwnerHomeDataResponse? data;

  ShopOwnerHomeResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory ShopOwnerHomeResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopOwnerHomeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShopOwnerHomeResponseToJson(this);
}

/// Maps the flat `data` object returned by `GET /shop-owner/home`.
@JsonSerializable()
class ShopOwnerHomeDataResponse {
  @JsonKey(name: ResponseConstants.shopOwnerShopStatus)
  String? shopStatus;

  @JsonKey(name: ResponseConstants.isAcceptingOrders)
  bool? isAcceptingOrders;

  @JsonKey(name: ResponseConstants.withdrawableBalance)
  double? withdrawableBalance;

  @JsonKey(name: ResponseConstants.lastLoginAt)
  String? lastLoginAt;

  @JsonKey(name: ResponseConstants.reviews)
  List<dynamic>? reviews;

  @JsonKey(name: ResponseConstants.averageRating)
  double? averageRating;

  @JsonKey(name: ResponseConstants.reviewsCount)
  int? reviewsCount;

  ShopOwnerHomeDataResponse({
    this.shopStatus,
    this.isAcceptingOrders,
    this.withdrawableBalance,
    this.lastLoginAt,
    this.reviews,
    this.averageRating,
    this.reviewsCount,
  });

  factory ShopOwnerHomeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopOwnerHomeDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShopOwnerHomeDataResponseToJson(this);
}
