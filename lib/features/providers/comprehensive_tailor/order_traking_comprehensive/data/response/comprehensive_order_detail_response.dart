import 'package:json_annotation/json_annotation.dart';
import '../../../../../../constants/response_constants/response_constants.dart';
import 'comprehensive_orders_response.dart';

part 'comprehensive_order_detail_response.g.dart';

// ─── Root wrapper ─────────────────────────────────────────────────────────────

@JsonSerializable()
class ComprehensiveOrderDetailResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  @JsonKey(name: ResponseConstants.data)
  final ComprehensiveOrderDetailDataResponse? data;

  const ComprehensiveOrderDetailResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory ComprehensiveOrderDetailResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ComprehensiveOrderDetailResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ComprehensiveOrderDetailResponseToJson(this);
}

@JsonSerializable()
class ComprehensiveOrderDetailDataResponse {
  @JsonKey(name: ResponseConstants.source)
  final String? source;

  // shop order detail
  @JsonKey(name: ResponseConstants.order)
  final ComprehensiveShopOrderResponse? shopOrder;

  const ComprehensiveOrderDetailDataResponse({
    this.source,
    this.shopOrder,
  });

  factory ComprehensiveOrderDetailDataResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ComprehensiveOrderDetailDataResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ComprehensiveOrderDetailDataResponseToJson(this);
}
