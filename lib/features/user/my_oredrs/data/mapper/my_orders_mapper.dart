import '../../domain/model/user_order_domain_model.dart';
import '../../domain/model/zoqak_offer_domain_model.dart';
import '../response/user_orders_response.dart';
import '../response/zoqak_offers_response.dart';

// ─── User order list mapper ───────────────────────────────────────────────────

extension UserOrderItemMapper on UserOrderItemResponse {
  UserOrderDomainModel toDomain() {
    final typeStr = orderType?.toLowerCase() ?? '';
    final type = typeStr == 'shop' ? UserOrderApiType.shop : UserOrderApiType.zoqak;

    final statusStr = status?.toLowerCase() ?? '';
    UserOrderApiStatus domainStatus;
    switch (statusStr) {
      case 'active':
        domainStatus = UserOrderApiStatus.active;
        break;
      case 'accepted':
        domainStatus = UserOrderApiStatus.accepted;
        break;
      case 'completed':
        domainStatus = UserOrderApiStatus.completed;
        break;
      case 'cancelled':
        domainStatus = UserOrderApiStatus.cancelled;
        break;
      default:
        domainStatus = UserOrderApiStatus.unknown;
    }

    final mappedStages = (stages ?? [])
        .map((s) => OrderStageDomain(
              key: s.key ?? '',
              label: s.label ?? '',
              completed: s.completed ?? false,
              statusDate: s.statusDate,
            ))
        .toList();

    final mappedItems = (items ?? [])
        .map((i) => OrderItemLineDomain(
              id: i.id ?? '',
              productId: i.productId,
              productName: i.productName,
              variantId: i.variantId,
              color: i.color,
              size: i.size,
              quantity: i.quantity ?? 1,
              unitPrice: _toDouble(i.unitPrice),
              totalPrice: _toDouble(i.totalPrice),
              imageUrl: i.imageUrl,
            ))
        .toList();

    return UserOrderDomainModel(
      id: id ?? '',
      orderNumber: orderNumber ?? '',
      orderType: type,
      shopId: shopId,
      shopName: shopName,
      totalAmount: _toDoubleNullable(totalAmount),
      paymentStatus: paymentStatus,
      items: mappedItems,
      productName: zoqak?.productName,
      description: zoqak?.description,
      fabricType: zoqak?.fabricType,
      minBudget: _toDoubleNullable(zoqak?.minExpectedBudget),
      maxBudget: _toDoubleNullable(zoqak?.maxExpectedBudget),
      deliveryDate: zoqak?.deliveryDate,
      similarImages: zoqak?.similarImages,
      acceptedByProviderId: acceptedByProviderId,
      acceptedByProviderName: acceptedByProviderName,
      status: domainStatus,
      stages: mappedStages,
      totalStages: stagesSummary?.totalStages ?? mappedStages.length,
      completedStages: stagesSummary?.completedStagesCount ??
          mappedStages.where((s) => s.completed).length,
      createdAt: createdAt ?? '',
      updatedAt: updatedAt,
    );
  }
}

// ─── Zoqak offer mapper ───────────────────────────────────────────────────────

extension ZoqakOfferItemMapper on ZoqakOfferItemResponse {
  ZoqakOfferDomainModel toDomain() {
    final statusStr = status?.toLowerCase() ?? '';
    ZoqakOfferStatus domainStatus;
    switch (statusStr) {
      case 'accepted':
        domainStatus = ZoqakOfferStatus.accepted;
        break;
      case 'rejected':
        domainStatus = ZoqakOfferStatus.rejected;
        break;
      case 'pending':
        domainStatus = ZoqakOfferStatus.pending;
        break;
      default:
        domainStatus = ZoqakOfferStatus.unknown;
    }

    return ZoqakOfferDomainModel(
      id: id ?? '',
      orderId: orderId,
      providerId: providerId,
      proposedPrice: _toDouble(proposedPrice),
      executionDays: executionDays ?? 0,
      details: details,
      status: domainStatus,
      createdAt: createdAt,
      providerName: providerName ?? '',
      providerImage: providerImage,
      providerIsAvailable: providerIsAvailable ?? true,
      providerRank: providerRank,
      providerRankLabel: providerRankLabel,
      providerRating: _toDouble(providerRating),
      providerRatersCount: providerRatersCount ?? 0,
      providerOffersCount: providerOffersCount ?? 0,
      orderOffersCount: orderOffersCount ?? 0,
    );
  }
}

// ─── Helpers ─────────────────────────────────────────────────────────────────

double _toDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  return double.tryParse(value.toString()) ?? 0.0;
}

double? _toDoubleNullable(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  return double.tryParse(value.toString());
}
