import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import '../../domain/model/provider_profile_model.dart';
import '../../domain/use_case/update_tailor_profile_use_case.dart';
import '../../domain/use_case/update_shop_profile_use_case.dart';
import 'provider_profile_controller.dart';

class UpdateProviderProfileController extends GetxController {
  final UpdateTailorProfileUseCase _updateTailorUseCase;
  final UpdateShopProfileUseCase _updateShopUseCase;
  final AppSettingsPrefs _prefs;

  UpdateProviderProfileController(
    this._updateTailorUseCase,
    this._updateShopUseCase,
    this._prefs,
  );

  // ── State ──────────────────────────────────────────────────────────────────

  final RxBool isSaving = false.obs;
  final Rxn<File> pickedImage = Rxn<File>();
  final Rxn<File> pickedCoverImage = Rxn<File>();

  late final TextEditingController fullNameController;
  late final TextEditingController nameArController;
  late final TextEditingController nameEnController;
  late final TextEditingController bioController;

  bool get isShopOwner    => _prefs.getUserRole() == 'shop_owner';
  bool get isComprehensive => _prefs.getUserRole() == 'comprehensive_tailor';

  // ── Lifecycle ──────────────────────────────────────────────────────────────

  @override
  void onInit() {
    super.onInit();
    final profile = _profileOrNull;
    fullNameController = TextEditingController(text: profile?.fullName ?? '');
    nameArController = TextEditingController(text: profile?.fullName ?? '');
    nameEnController = TextEditingController(text: profile?.nameEn ?? '');
    bioController = TextEditingController(text: profile?.bio ?? '');
  }

  @override
  void onClose() {
    fullNameController.dispose();
    nameArController.dispose();
    nameEnController.dispose();
    bioController.dispose();
    super.onClose();
  }

  ProviderProfileModel? get _profileOrNull {
    try {
      return Get.find<ProviderProfileController>().profile.value;
    } catch (_) {
      return null;
    }
  }

  // ── Image picker ───────────────────────────────────────────────────────────

  Future<void> pickImage() async {
    final XFile? picked = await _pickFromGallery();
    if (picked != null) pickedImage.value = File(picked.path);
  }

  Future<void> pickCoverImage() async {
    final XFile? picked = await _pickFromGallery(maxW: 1920, maxH: 640);
    if (picked != null) pickedCoverImage.value = File(picked.path);
  }

  Future<XFile?> _pickFromGallery({double maxW = 800, double maxH = 800}) {
    return ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: maxW,
      maxHeight: maxH,
    );
  }

  // ── Save ───────────────────────────────────────────────────────────────────

  Future<void> saveTailorProfile() async {
    final name = fullNameController.text.trim();
    if (name.isEmpty) {
      AppSnackbar.warning(ManagerStrings.updateProfileNameEmpty);
      return;
    }

    isSaving.value = true;

    final Either<Failure, void> result = await _updateTailorUseCase.execute(
      fullName: name,
      bio: bioController.text.trim().isEmpty ? null : bioController.text.trim(),
      image: pickedImage.value,
    );

    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (_) {
        AppSnackbar.success(ManagerStrings.updateProfileSuccess);
        try {
          Get.find<ProviderProfileController>().refreshProfile();
        } catch (_) {}
        Get.back();
      },
    );

    isSaving.value = false;
  }

  Future<void> saveShopProfile() async {
    final nameAr = nameArController.text.trim();
    final nameEn = nameEnController.text.trim();

    if (nameAr.isEmpty) {
      AppSnackbar.warning(ManagerStrings.updateProfileNameEmpty);
      return;
    }
    if (nameEn.isEmpty) {
      AppSnackbar.warning(ManagerStrings.updateProfileNameEmpty);
      return;
    }

    isSaving.value = true;

    final Either<Failure, void> result = await _updateShopUseCase.execute(
      nameAr: nameAr,
      nameEn: nameEn,
      bio: bioController.text.trim().isEmpty ? null : bioController.text.trim(),
      image: pickedImage.value,
      coverImage: pickedCoverImage.value,
    );

    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (_) {
        AppSnackbar.success(ManagerStrings.updateProfileSuccess);
        try {
          Get.find<ProviderProfileController>().refreshProfile();
        } catch (_) {}
        Get.back();
      },
    );

    isSaving.value = false;
  }
}
