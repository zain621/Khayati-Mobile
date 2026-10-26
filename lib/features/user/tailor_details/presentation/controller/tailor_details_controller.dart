import 'package:get/get.dart';
import '../../../../../constants/di/dependency_injection.dart';
import '../../../../../core/error_handler/failure.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/storage/local/app_settings_prefs.dart';
import '../../../../../core/util/app_snack_bar.dart';
import '../../../../providers/common_features/chat/data/request/create_conversation_request.dart';
import '../../../../providers/common_features/chat/domain/use_case/create_conversation_use_case.dart';
import '../../domain/model/tailor_details_model.dart';
import '../../domain/use_case/get_tailor_details_use_case.dart';

class TailorDetailsController extends GetxController {
  final GetTailorDetailsUseCase _getTailorDetailsUseCase;
  final String tailorId;

  TailorDetailsController(this._getTailorDetailsUseCase,
      {required this.tailorId});

  final RxBool isLoading = false.obs;
  final RxBool isChatLoading = false.obs;
  final Rxn<TailorDetailsModel> tailor = Rxn<TailorDetailsModel>();
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTailorDetails();
  }

  Future<void> fetchTailorDetails() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final result = await _getTailorDetailsUseCase.execute(tailorId);
      result.fold(
        (Failure failure) {
          errorMessage.value = failure.message;
          AppSnackbar.error(failure.message);
        },
        (TailorDetailsModel data) => tailor.value = data,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> startChat() async {
    final tailorData = tailor.value;
    if (tailorData == null) return;
    isChatLoading.value = true;
    try {
      final useCase = instance<CreateConversationUseCase>();
      final prefs = instance<AppSettingsPrefs>();
      final request = CreateConversationRequest(
        tailorId: tailorData.id,
        userId: prefs.getUserId(),
      );
      final result = await useCase.execute(request);
      result.fold(
        (Failure failure) => AppSnackbar.error(failure.message),
        (conversation) => Get.toNamed(
          Routes.userChatDetailScreen,
          arguments: {
            'conversationId': conversation.id,
            'userName': tailorData.name,
            'avatarUrl': tailorData.image ?? '',
            'isOnline': tailorData.isAvailable,
          },
        ),
      );
    } finally {
      isChatLoading.value = false;
    }
  }
}
