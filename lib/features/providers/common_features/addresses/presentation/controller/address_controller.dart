import 'package:get/get.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import '../../data/request/address_request.dart';
import '../../domain/model/address_model.dart';
import '../../domain/use_case/get_address_use_case.dart';
import '../../domain/use_case/create_address_use_case.dart';
import '../../domain/use_case/update_address_use_case.dart';

class AddressController extends GetxController {
  final GetAddressUseCase getAddressUseCase;
  final CreateAddressUseCase createAddressUseCase;
  final UpdateAddressUseCase updateAddressUseCase;

  AddressController({
    required this.getAddressUseCase,
    required this.createAddressUseCase,
    required this.updateAddressUseCase,
  });

  final RxBool isLoading = true.obs;
  final RxBool isSubmitting = false.obs;
  final Rxn<AddressModel> address = Rxn<AddressModel>();

  bool get hasAddress => address.value != null;

  @override
  void onInit() {
    super.onInit();
    fetchAddress();
  }

  Future<void> fetchAddress() async {
    isLoading.value = true;
    final result = await getAddressUseCase.execute();
    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (data) => address.value = data,
    );
    isLoading.value = false;
  }

  Future<void> refreshAddress() async => await fetchAddress();

  Future<bool> submitAddress({
    required String fullName,
    required double latitude,
    required double longitude,
    required String detailedDescription,
  }) async {
    isSubmitting.value = true;
    final request = AddressRequest(
      fullName: fullName,
      latitude: latitude,
      longitude: longitude,
      detailedDescription: detailedDescription,
    );

    final result = hasAddress
        ? await updateAddressUseCase.execute(request)
        : await createAddressUseCase.execute(request);

    bool success = false;
    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (data) {
        address.value = data;
        success = true;
      },
    );
    isSubmitting.value = false;
    return success;
  }
}
