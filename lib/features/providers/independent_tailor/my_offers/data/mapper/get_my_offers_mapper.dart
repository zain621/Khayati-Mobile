import 'package:app_mobile/core/extensions/extensions.dart';
import '../response/get_my_offers_response.dart';
import '../../domain/model/my_offer_model.dart';

/// Maps [MyOfferDetailResponse] → [OfferDetailModel].
extension MyOfferDetailMapper on MyOfferDetailResponse {
  OfferDetailModel toDomain() {
    return OfferDetailModel(
      id: id.onNull(),
      proposedPrice: (proposedPrice ?? 0).toDouble(),
      executionDays: executionDays ?? 0,
      details: details.onNull(),
      status: _parseStatus(status),
      createdAt: createdAt.onNull(),
    );
  }
}

/// Maps [ClientBudgetResponse] → [ClientBudgetModel].
extension ClientBudgetMapper on ClientBudgetResponse {
  ClientBudgetModel toDomain() {
    return ClientBudgetModel(
      minExpectedBudget: (minExpectedBudget ?? 0).toDouble(),
      maxExpectedBudget: (maxExpectedBudget ?? 0).toDouble(),
    );
  }
}

/// Maps [MyOfferItemResponse] → [MyOfferModel].
extension MyOfferItemMapper on MyOfferItemResponse {
  MyOfferModel toDomain() {
    return MyOfferModel(
      orderId: orderId.onNull(),
      orderNumber: orderNumber.onNull(),
      requesterImage: requesterImage,
      requesterName: requesterName.onNull(),
      requesterDescription: requesterDescription,
      myOffer: myOffer?.toDomain() ??
          OfferDetailModel(
            id: '',
            proposedPrice: 0,
            executionDays: 0,
            details: '',
            status: OfferStatus.underReview,
            createdAt: '',
          ),
      clientBudget: clientBudget?.toDomain() ??
          const ClientBudgetModel(
            minExpectedBudget: 0,
            maxExpectedBudget: 0,
          ),
      competitorsCount: competitors?.length ?? 0,
    );
  }
}

/// Maps [GetMyOffersResponse] → list of [MyOfferModel].
extension GetMyOffersMapper on GetMyOffersResponse {
  List<MyOfferModel> toDomain() {
    return (data ?? []).map((item) => item.toDomain()).toList();
  }
}

OfferStatus _parseStatus(String? raw) {
  switch (raw) {
    case 'accepted':
      return OfferStatus.accepted;
    case 'rejected':
      return OfferStatus.rejected;
    case 'pending':
    default:
      return OfferStatus.underReview;
  }
}
