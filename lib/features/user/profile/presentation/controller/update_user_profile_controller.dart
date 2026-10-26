import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import 'package:app_mobile/features/user/home_user/presentation/controller/home_user_controller.dart';
import '../../data/request/update_user_profile_request.dart';
import '../../domain/model/update_user_profile_model.dart';
import '../../domain/use_case/update_user_profile_use_case.dart';
import 'user_profile_controller.dart';

class UpdateUserProfileController extends GetxController {
  final UpdateUserProfileUseCase _updateUseCase;
  final AppSettingsPrefs _appSettingsPrefs;

  final String initialFullName;
  final String phone;
  final String? initialImage;

  UpdateUserProfileController(
    this._updateUseCase,
    this._appSettingsPrefs, {
    required this.initialFullName,
    required this.phone,
    this.initialImage,
  });

  // ── State ──────────────────────────────────────────────────────────────────

  final RxBool isLoading = false.obs;

  /// Locally selected image file — null if the user has not changed it.
  final Rxn<File> selectedImage = Rxn<File>();

  late final TextEditingController fullNameController;

  // ── Lifecycle ──────────────────────────────────────────────────────────────

  @override
  void onInit() {
    super.onInit();
    fullNameController = TextEditingController(text: initialFullName);
  }

  @override
  void onClose() {
    fullNameController.dispose();
    super.onClose();
  }

  // ── Image picker ───────────────────────────────────────────────────────────

  /// Opens the system picker for [source] (camera or gallery) and stores
  /// the chosen file in [selectedImage].
  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(
      source: source,
      imageQuality: 85,
      maxWidth: 800,
      maxHeight: 800,
    );
    if (picked != null) {
      selectedImage.value = File(picked.path);
    }
  }

  // ── Submit ─────────────────────────────────────────────────────────────────

  /// Validates input then calls the use case. Returns [true] when the save
  /// navigation should proceed (so the view can pop after this resolves).
  Future<void> submitUpdate() async {
    final name = fullNameController.text.trim();

    if (name.isEmpty) {
      AppSnackbar.warning(
        ManagerStrings.updateUserProfileErrorNameEmpty,
        englishMessage: ManagerStrings.updateUserProfileErrorNameEmptyEn,
      );
      return;
    }

    isLoading.value = true;

    final Either<Failure, UpdateUserProfileModel> result =
        await _updateUseCase.execute(
      UpdateUserProfileRequest(
        fullName: name,
        image: selectedImage.value,
      ),
    );

    result.fold(
      (failure) {
        AppSnackbar.error(failure.message);
      },
      (data) {
        // ── 1. Persist updated values to SharedPrefs ──────────────────
        // Fire-and-forget: SharedPrefs writes are essentially instant.
        _appSettingsPrefs.setUserFullName(data.fullName);
        if (data.image != null) _appSettingsPrefs.setUserImage(data.image!);

        // ── 2. Reload Home app bar reactively (user won't notice) ─────
        try {
          Get.find<HomeUserController>().reloadUserInfo();
        } catch (_) {}

        // ── 3. Show success & navigate back ───────────────────────────
        AppSnackbar.success(
          ManagerStrings.updateUserProfileSuccess,
          englishMessage: ManagerStrings.updateUserProfileSuccessEn,
        );
        // Refresh the parent profile screen silently
        try {
          Get.find<UserProfileController>().refreshProfile();
        } catch (_) {}
        Get.back();
      },
    );

    isLoading.value = false;
  }
}
