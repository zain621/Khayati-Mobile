import 'package:json_annotation/json_annotation.dart';
import '../../../../../../constants/response_constants/response_constants.dart';

part 'transactions_response.g.dart';

@JsonSerializable()
class TransactionsResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.data)
  final TransactionsDataResponse? data;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  TransactionsResponse({this.status, this.code, this.data, this.message});

  factory TransactionsResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionsResponseToJson(this);
}

@JsonSerializable()
class TransactionsDataResponse {
  @JsonKey(name: ResponseConstants.items)
  final List<TransactionItemResponse>? items;

  @JsonKey(name: ResponseConstants.total)
  final int? total;

  TransactionsDataResponse({this.items, this.total});

  factory TransactionsDataResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionsDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionsDataResponseToJson(this);
}

@JsonSerializable()
class TransactionItemResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.transactionType)
  final String? type;

  @JsonKey(name: ResponseConstants.typeLabel)
  final String? typeLabel;

  @JsonKey(name: ResponseConstants.amount)
  final double? amount;

  @JsonKey(name: ResponseConstants.description)
  final String? description;

  @JsonKey(name: ResponseConstants.createdAt)
  final String? createdAt;

  TransactionItemResponse({
    this.id,
    this.type,
    this.typeLabel,
    this.amount,
    this.description,
    this.createdAt,
  });

  factory TransactionItemResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionItemResponseToJson(this);
}
