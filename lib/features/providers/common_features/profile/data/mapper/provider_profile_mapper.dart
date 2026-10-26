import 'package:app_mobile/core/extensions/extensions.dart';
import '../response/provider_profile_response.dart';
import '../response/shop_owner_profile_response.dart';
import '../../domain/model/provider_profile_model.dart';

// ── Tailor profile mapping ─────────────────────────────────────────────────

extension ProviderProfileDataMapper on ProviderProfileDataResponse {
  ProviderProfileModel toDomain() {
    return ProviderProfileModel(
      id: id.onNull(),
      fullName: fullName.onNull(),
      phoneNumber: phoneNumber.onNull(),
      image: image,
      bio: bio,
      role: role.onNull(),
      rank: rank,
      rankLabel: rankLabel,
      portfolio: portfolio?.toDomain(),
    );
  }
}

extension ProfilePortfolioMapper on ProfilePortfolioResponse {
  PortfolioModel toDomain() {
    return PortfolioModel(
      images: (images ?? []).map((e) => e.toDomain()).toList(),
      specializations: (specializations ?? []).map((e) => e.toDomain()).toList(),
    );
  }
}

extension ProfilePortfolioImageMapper on ProfilePortfolioImageResponse {
  PortfolioImageModel toDomain() {
    return PortfolioImageModel(
      id: id.onNull(),
      imageUrl: imageUrl.onNull(),
      sortOrder: sortOrder ?? 0,
    );
  }
}

extension ProfileSpecializationMapper on ProfileSpecializationResponse {
  SpecializationModel toDomain() {
    return SpecializationModel(id: id.onNull(), name: name.onNull());
  }
}

extension ProviderProfileMapper on ProviderProfileResponse {
  ProviderProfileModel toDomain() => data!.toDomain();
}

// ── Shop owner profile mapping ─────────────────────────────────────────────

extension ShopOwnerProfileDataMapper on ShopOwnerProfileDataResponse {
  ProviderProfileModel toDomain() {
    return ProviderProfileModel(
      id: id.onNull(),
      fullName: nameAr.onNull(),
      nameEn: nameEn,
      phoneNumber: '',
      image: imageUrl,
      bio: bio,
      role: 'shop_owner',
      portfolio: null,
    );
  }
}

extension ShopOwnerProfileMapper on ShopOwnerProfileResponse {
  ProviderProfileModel toDomain() => data!.toDomain();
}
