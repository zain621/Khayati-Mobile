import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/features/providers/common_features/chat/data/request/create_conversation_request.dart';
import 'package:app_mobile/features/providers/common_features/chat/domain/use_case/create_conversation_use_case.dart';
import 'package:get/get.dart';
import '../../domain/model/product_details_model.dart';
import '../../domain/use_case/get_product_details_use_case.dart';

class ProductDetailsController extends GetxController {
  final GetProductDetailsUseCase _getProductDetailsUseCase;
  final String productId;

  ProductDetailsController(this._getProductDetailsUseCase, this.productId);

  final RxBool isLoading = false.obs;
  final RxBool isChatLoading = false.obs;
  final Rxn<ProductDetailsModel> product = Rxn<ProductDetailsModel>();

  // Selected variant state
  final Rxn<String> selectedColor = Rxn<String>();
  final Rxn<String> selectedSize = Rxn<String>();
  final RxInt quantity = 1.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProductDetails();
  }

  Future<void> fetchProductDetails() async {
    isLoading.value = true;
    try {
      final result = await _getProductDetailsUseCase.execute(productId);
      result.fold(
        (Failure failure) => AppSnackbar.error(failure.message),
        (ProductDetailsModel data) {
          product.value = data;
          // Pre-select first available color
          if (data.availableColors.isNotEmpty) {
            selectedColor.value = data.availableColors.first;
          }
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  void selectColor(String color) {
    selectedColor.value = color;
    // Reset size when color changes
    selectedSize.value = null;
    quantity.value = 1;
  }

  void selectSize(String size) {
    selectedSize.value = size;
    quantity.value = 1;
  }

  void incrementQty() {
    final variant = selectedVariant;
    if (variant == null) return;
    if (quantity.value < variant.quantity) {
      quantity.value++;
    }
  }

  void decrementQty() {
    if (quantity.value > 1) quantity.value--;
  }

  ProductVariantModel? get selectedVariant =>
      product.value?.findVariant(selectedColor.value, selectedSize.value);

  bool get canAddToCart =>
      selectedColor.value != null &&
      selectedSize.value != null &&
      selectedVariant != null;

  List<String> get availableSizes =>
      product.value?.sizesForColor(selectedColor.value ?? '') ?? [];

  String get errorMessage => ManagerStrings.productDetailsError;

  Future<void> startChatWithShop() async {
    final productData = product.value;
    if (productData == null) return;
    isChatLoading.value = true;
    try {
      final useCase = instance<CreateConversationUseCase>();
      final prefs = instance<AppSettingsPrefs>();
      final request = CreateConversationRequest(
        tailorId: productData.shopId,
        userId: prefs.getUserId(),
      );
      final result = await useCase.execute(request);
      result.fold(
        (Failure failure) => AppSnackbar.error(failure.message),
        (conversation) => Get.toNamed(
          Routes.userChatDetailScreen,
          arguments: {
            'conversationId': conversation.id,
            'userName': productData.shopName,
            'avatarUrl': '',
            'isOnline': false,
          },
        ),
      );
    } finally {
      isChatLoading.value = false;
    }
  }
}
