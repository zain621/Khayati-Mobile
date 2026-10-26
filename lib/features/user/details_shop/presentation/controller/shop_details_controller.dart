import 'package:get/get.dart';
import '../../../../../constants/di/dependency_injection.dart';
import '../../../../../core/error_handler/failure.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/storage/local/app_settings_prefs.dart';
import '../../../../../core/util/app_snack_bar.dart';
import '../../../../providers/common_features/chat/data/request/create_conversation_request.dart';
import '../../../../providers/common_features/chat/domain/use_case/create_conversation_use_case.dart';
import '../../domain/model/shop_details_model.dart';
import '../../domain/use_case/get_shop_details_use_case.dart';

class ShopDetailsController extends GetxController {
  final GetShopDetailsUseCase _getShopDetailsUseCase;
  final String shopId;

  ShopDetailsController(this._getShopDetailsUseCase, {required this.shopId});

  final RxBool isLoading = false.obs;
  final RxBool isChatLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final Rxn<ShopDetailsModel> shop = Rxn<ShopDetailsModel>();
  final RxInt selectedCategoryIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchShopDetails();
  }

  Future<void> fetchShopDetails() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final result = await _getShopDetailsUseCase.execute(shopId);
      result.fold(
        (Failure failure) {
          shop.value = null;
          errorMessage.value = failure.message;
          AppSnackbar.error(failure.message);
        },
        (ShopDetailsModel data) {
          errorMessage.value = '';
          shop.value = data;
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  List<ShopProductModel> get displayedProducts {
    final shopData = shop.value;
    if (shopData == null) return [];
    if (shopData.categories.isEmpty) return shopData.products;
    final idx = selectedCategoryIndex.value;
    if (idx == 0) return shopData.products;
    final catIdx = idx - 1;
    if (catIdx >= shopData.categories.length) return shopData.products;
    return shopData.categories[catIdx].products;
  }

  Future<void> startChat() async {
    final shopData = shop.value;
    if (shopData == null) return;
    isChatLoading.value = true;
    try {
      final useCase = instance<CreateConversationUseCase>();
      final prefs = instance<AppSettingsPrefs>();
      final request = CreateConversationRequest(
        tailorId: shopData.tailorUserId.isNotEmpty ? shopData.tailorUserId : shopData.id,
        userId: prefs.getUserId(),
      );
      final result = await useCase.execute(request);
      result.fold(
        (Failure failure) => AppSnackbar.error(failure.message),
        (conversation) => Get.toNamed(
          Routes.userChatDetailScreen,
          arguments: {
            'conversationId': conversation.id,
            'userName': shopData.name,
            'avatarUrl': shopData.imageUrl,
            'isOnline': false,
          },
        ),
      );
    } finally {
      isChatLoading.value = false;
    }
  }
}
