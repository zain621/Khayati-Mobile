import 'package:app_mobile/core/extensions/extensions.dart';
import '../response/address_response.dart';
import '../../domain/model/address_model.dart';

extension AddressDataMapper on AddressDataResponse {
  AddressModel toDomain() {
    return AddressModel(
      id: id.onNull(),
      fullName: fullName.onNull(),
      latitude: latitude.onNull(),
      longitude: longitude.onNull(),
      detailedDescription: detailedDescription.onNull(),
      createdAt: createdAt.onNull(),
      updatedAt: updatedAt.onNull(),
    );
  }
}

extension AddressResponseMapper on AddressResponse {
  AddressModel? toDomain() {
    return data?.toDomain();
  }
}
