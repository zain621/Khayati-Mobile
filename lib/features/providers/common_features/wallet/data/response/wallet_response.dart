import 'package:json_annotation/json_annotation.dart';
import '../../../../../../constants/response_constants/response_constants.dart';

part 'wallet_response.g.dart';

@JsonSerializable()
class WalletResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.data)
  final WalletDataResponse? data;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  WalletResponse({this.status, this.code, this.data, this.message});

  factory WalletResponse.fromJson(Map<String, dynamic> json) =>
      _$WalletResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WalletResponseToJson(this);
}

@JsonSerializable()
class WalletDataResponse {
  @JsonKey(name: ResponseConstants.pendingBalance)
  final double? pendingBalance;

  @JsonKey(name: ResponseConstants.withdrawableBalance)
  final double? withdrawableBalance;

  @JsonKey(name: ResponseConstants.totalBalance)
  final double? totalBalance;

  WalletDataResponse({
    this.pendingBalance,
    this.withdrawableBalance,
    this.totalBalance,
  });

  factory WalletDataResponse.fromJson(Map<String, dynamic> json) =>
      _$WalletDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WalletDataResponseToJson(this);
}
