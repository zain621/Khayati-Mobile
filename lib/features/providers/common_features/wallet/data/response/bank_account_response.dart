import 'package:json_annotation/json_annotation.dart';
import '../../../../../../constants/response_constants/response_constants.dart';

part 'bank_account_response.g.dart';

// ── GET /trader/wallet/bank-accounts ────────────────────────────────────

@JsonSerializable()
class BankAccountsResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.data)
  final List<BankAccountDataResponse>? data;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  BankAccountsResponse({this.status, this.code, this.data, this.message});

  factory BankAccountsResponse.fromJson(Map<String, dynamic> json) =>
      _$BankAccountsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BankAccountsResponseToJson(this);
}

// ── Single bank account data ──────────────────────────────────────────

@JsonSerializable()
class BankAccountDataResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.bankName)
  final String? bankName;

  @JsonKey(name: ResponseConstants.accountHolderName)
  final String? accountHolderName;

  @JsonKey(name: ResponseConstants.accountNumber)
  final String? accountNumber;

  @JsonKey(name: ResponseConstants.iban)
  final String? iban;

  @JsonKey(name: ResponseConstants.createdAt)
  final String? createdAt;

  BankAccountDataResponse({
    this.id,
    this.bankName,
    this.accountHolderName,
    this.accountNumber,
    this.iban,
    this.createdAt,
  });

  factory BankAccountDataResponse.fromJson(Map<String, dynamic> json) =>
      _$BankAccountDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BankAccountDataResponseToJson(this);
}

// ── POST / PATCH bank account: response wraps a single BankAccountDataResponse

@JsonSerializable()
class BankAccountActionResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.data)
  final BankAccountDataResponse? data;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  BankAccountActionResponse({this.status, this.code, this.data, this.message});

  factory BankAccountActionResponse.fromJson(Map<String, dynamic> json) =>
      _$BankAccountActionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BankAccountActionResponseToJson(this);
}
