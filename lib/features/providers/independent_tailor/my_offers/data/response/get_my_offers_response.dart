import 'package:json_annotation/json_annotation.dart';
import '../../../../../../constants/response_constants/response_constants.dart';

part 'get_my_offers_response.g.dart';

/// The tailor's own offer detail nested inside each record.
@JsonSerializable()
class MyOfferDetailResponse {
  @JsonKey(name: ResponseConstants.entityId)
  String? id;

  @JsonKey(name: ResponseConstants.proposedPrice)
  num? proposedPrice;

  @JsonKey(name: ResponseConstants.executionDays)
  int? executionDays;

  @JsonKey(name: ResponseConstants.details)
  String? details;

  @JsonKey(name: ResponseConstants.orderStatus)
  String? status;

  @JsonKey(name: ResponseConstants.createdAt)
  String? createdAt;

  MyOfferDetailResponse({
    this.id,
    this.proposedPrice,
    this.executionDays,
    this.details,
    this.status,
    this.createdAt,
  });

  factory MyOfferDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$MyOfferDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyOfferDetailResponseToJson(this);
}

/// Client budget range nested inside each record.
@JsonSerializable()
class ClientBudgetResponse {
  @JsonKey(name: ResponseConstants.minExpectedBudget)
  num? minExpectedBudget;

  @JsonKey(name: ResponseConstants.maxExpectedBudget)
  num? maxExpectedBudget;

  ClientBudgetResponse({this.minExpectedBudget, this.maxExpectedBudget});

  factory ClientBudgetResponse.fromJson(Map<String, dynamic> json) =>
      _$ClientBudgetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ClientBudgetResponseToJson(this);
}

/// A single offer record from the my-offers list.
@JsonSerializable()
class MyOfferItemResponse {
  @JsonKey(name: ResponseConstants.orderId)
  String? orderId;

  @JsonKey(name: ResponseConstants.orderNumber)
  String? orderNumber;

  @JsonKey(name: ResponseConstants.requesterImage)
  String? requesterImage;

  @JsonKey(name: ResponseConstants.requesterName)
  String? requesterName;

  @JsonKey(name: ResponseConstants.requesterDescription)
  String? requesterDescription;

  @JsonKey(name: ResponseConstants.myOffer)
  MyOfferDetailResponse? myOffer;

  @JsonKey(name: ResponseConstants.clientBudget)
  ClientBudgetResponse? clientBudget;

  @JsonKey(name: ResponseConstants.competitors)
  List<dynamic>? competitors;

  MyOfferItemResponse({
    this.orderId,
    this.orderNumber,
    this.requesterImage,
    this.requesterName,
    this.requesterDescription,
    this.myOffer,
    this.clientBudget,
    this.competitors,
  });

  factory MyOfferItemResponse.fromJson(Map<String, dynamic> json) =>
      _$MyOfferItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyOfferItemResponseToJson(this);
}

/// Top-level response wrapper for GET /independent-tailor/zoqak/my-offers.
@JsonSerializable()
class GetMyOffersResponse {
  @JsonKey(name: ResponseConstants.data)
  List<MyOfferItemResponse>? data;

  GetMyOffersResponse({this.data});

  factory GetMyOffersResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMyOffersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetMyOffersResponseToJson(this);
}
