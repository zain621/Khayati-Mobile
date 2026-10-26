import 'user_orders_response.dart';

// ─────────────────────────────────────────────────────────────────────────────
// OrderDetailResponse
// Endpoint: GET /user/orders/:orderId
//
// The 'data' payload is structurally identical to a single UserOrderItemResponse
// (same fields: id, orderNumber, orderType, stages, items, zoqak, etc.)
// so we reuse it directly — no code generation required.
// ─────────────────────────────────────────────────────────────────────────────

class UserOrderDetailResponse {
  final String? status;
  final int? code;
  final UserOrderItemResponse? data;
  final String? message;

  const UserOrderDetailResponse({
    this.status,
    this.code,
    this.data,
    this.message,
  });

  factory UserOrderDetailResponse.fromJson(Map<String, dynamic> json) {
    return UserOrderDetailResponse(
      status: json['status'] as String?,
      code: json['code'] as int?,
      data: json['data'] != null
          ? UserOrderItemResponse.fromJson(
              json['data'] as Map<String, dynamic>)
          : null,
      message: json['message'] as String?,
    );
  }
}
