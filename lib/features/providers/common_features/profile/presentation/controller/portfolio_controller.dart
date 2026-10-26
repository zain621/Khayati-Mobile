import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import '../../domain/model/provider_profile_model.dart';
import '../../domain/use_case/add_portfolio_images_use_case.dart';
import '../../domain/use_case/delete_portfolio_image_use_case.dart';
import '../../domain/use_case/add_specialization_use_case.dart';
import '../../domain/use_case/delete_specialization_use_case.dart';
import 'provider_profile_controller.dart';

class PortfolioController extends GetxController {
  final AddPortfolioImagesUseCase _addImagesUseCase;
  final DeletePortfolioImageUseCase _deleteImageUseCase;
  final AddSpecializationUseCase _addSpecializationUseCase;
  final DeleteSpecializationUseCase _deleteSpecializationUseCase;
  final ProviderProfileController _profileController;

  PortfolioController(
    this._addImagesUseCase,
    this._deleteImageUseCase,
    this._addSpecializationUseCase,
    this._deleteSpecializationUseCase,
    this._profileController,
  );

  static const int maxPhotos = 20;

  final RxList<PortfolioImageModel> images = <PortfolioImageModel>[].obs;
  final RxList<SpecializationModel> specializations =
      <SpecializationModel>[].obs;

  final RxBool isAddingImage = false.obs;
  final RxBool isDeletingImage = false.obs;
  final RxBool isAddingSpecialization = false.obs;
  final RxBool isDeletingSpecialization = false.obs;

  // Tracks which imageId is being deleted
  final RxString deletingImageId = ''.obs;
  // Tracks which specializationId is being deleted
  final RxString deletingSpecializationId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _syncFromProfile();
    ever(_profileController.profile, (_) => _syncFromProfile());
  }

  void _syncFromProfile() {
    final portfolio = _profileController.profile.value?.portfolio;
    if (portfolio != null) {
      images.value = List.from(portfolio.images);
      specializations.value = List.from(portfolio.specializations);
    }
  }

  // ── Add images (image picker → API) ───────────────────────────────────────

  Future<void> pickAndAddImages() async {
    if (isAddingImage.value || images.length >= maxPhotos) return;

    final picker = ImagePicker();
    final remaining = maxPhotos - images.length;
    final picked =
        await picker.pickMultiImage(imageQuality: 85, limit: remaining);
    if (picked.isEmpty) return;

    final files = picked.take(remaining).map((x) => File(x.path)).toList();
    await _doAddImages(files);
  }

  Future<void> _doAddImages(List<File> files) async {
    isAddingImage.value = true;

    final result = await _addImagesUseCase.execute(files);

    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (_) {
        AppSnackbar.success(ManagerStrings.portfolioAddImageSuccess);
        _profileController.refreshProfile();
      },
    );

    isAddingImage.value = false;
  }

  // ── Delete image ──────────────────────────────────────────────────────────

  Future<void> deleteImage(String imageId) async {
    isDeletingImage.value = true;
    deletingImageId.value = imageId;

    final result = await _deleteImageUseCase.execute(imageId);

    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (_) {
        AppSnackbar.success(ManagerStrings.portfolioDeleteImageSuccess);
        _profileController.refreshProfile();
      },
    );

    isDeletingImage.value = false;
    deletingImageId.value = '';
  }

  // ── Add specialization ────────────────────────────────────────────────────

  Future<void> addSpecialization(String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;

    isAddingSpecialization.value = true;

    final result = await _addSpecializationUseCase.execute(trimmed);

    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (_) {
        AppSnackbar.success(ManagerStrings.addSpecializationSuccess);
        _profileController.refreshProfile();
      },
    );

    isAddingSpecialization.value = false;
  }

  // ── Delete specialization ─────────────────────────────────────────────────

  Future<void> deleteSpecialization(String specializationId) async {
    isDeletingSpecialization.value = true;
    deletingSpecializationId.value = specializationId;

    final result = await _deleteSpecializationUseCase.execute(specializationId);

    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (_) {
        AppSnackbar.success(ManagerStrings.deleteSpecializationSuccess);
        _profileController.refreshProfile();
      },
    );

    isDeletingSpecialization.value = false;
    deletingSpecializationId.value = '';
  }
}
