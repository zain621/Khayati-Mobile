import 'package:app_mobile/core/extensions/extensions.dart';
import '../response/tailor_details_response.dart';
import '../../domain/model/tailor_details_model.dart';

extension TailorDetailsMapper on TailorDetailsResponse {
  TailorDetailsModel toDomain() {
    final d = data;
    return TailorDetailsModel(
      id: d?.id.onNull() ?? '',
      name: d?.fullName.onNull() ?? '',
      image: d?.image,
      bio: d?.bio,
      role: d?.role.onNull() ?? '',
      isAvailable: d?.isAvailable ?? false,
      rank: d?.rank.onNull() ?? '',
      rankLabel: d?.rankLabel.onNull() ?? '',
      rating: (d?.rating as num?)?.toDouble() ?? 0.0,
      ratersCount: d?.ratersCount ?? 0,
      offersCount: d?.offersCount ?? 0,
      completedOrdersCount: d?.completedOrdersCount ?? 0,
      portfolioImages: d?.portfolio?.images
              ?.map((img) => img.imageUrl ?? '')
              .where((url) => url.isNotEmpty)
              .toList() ??
          [],
      specializations: d?.portfolio?.specializations ?? [],
      address: d?.address,
    );
  }
}
