import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import '../../data/request/create_order_request.dart';
import '../../domain/use_case/create_order_use_case.dart';

class CreateOrderController extends GetxController {
  final CreateOrderUseCase _createOrderUseCase;

  CreateOrderController(this._createOrderUseCase);

  // ── Loading state ──────────────────────────────────────────────────────────

  final RxBool isLoading = false.obs;

  // ── Form controllers ───────────────────────────────────────────────────────

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController specialRequestsController =
      TextEditingController();
  final TextEditingController minBudgetController = TextEditingController();
  final TextEditingController maxBudgetController = TextEditingController();

  // ── Reactive form state ────────────────────────────────────────────────────

  final Rxn<String> selectedFabric = Rxn<String>();
  final Rxn<DateTime> selectedDeadline = Rxn<DateTime>();
  final RxList<File> referenceImages = <File>[].obs;

  // ── Lifecycle ──────────────────────────────────────────────────────────────

  @override
  void onClose() {
    productNameController.dispose();
    descriptionController.dispose();
    specialRequestsController.dispose();
    minBudgetController.dispose();
    maxBudgetController.dispose();
    super.onClose();
  }

  // ── Image picker ───────────────────────────────────────────────────────────

  /// Pick multiple images from gallery and append them to the list.
  Future<void> pickImages() async {
    final picker = ImagePicker();
    final List<XFile> picked = await picker.pickMultiImage(
      imageQuality: 85,
      maxWidth: 1200,
      maxHeight: 1200,
    );
    if (picked.isNotEmpty) {
      referenceImages.addAll(picked.map((xf) => File(xf.path)));
    }
  }

  /// Remove image at [index] from the list.
  void removeImage(int index) {
    if (index >= 0 && index < referenceImages.length) {
      referenceImages.removeAt(index);
    }
  }

  // ── Deadline ───────────────────────────────────────────────────────────────

  /// Stores the chosen deadline date.
  void setDeadline(DateTime date) {
    selectedDeadline.value = date;
  }

  // ── Validation ─────────────────────────────────────────────────────────────

  /// Returns false and shows a warning snackbar if the form is invalid.
  bool validate() {
    if (productNameController.text.trim().isEmpty) {
      AppSnackbar.warning(ManagerStrings.createOrderValidateName);
      return false;
    }
    if (descriptionController.text.trim().isEmpty) {
      AppSnackbar.warning(ManagerStrings.createOrderValidateDesc);
      return false;
    }
    if (selectedFabric.value == null) {
      AppSnackbar.warning(ManagerStrings.createOrderValidateFabric);
      return false;
    }
    if (minBudgetController.text.trim().isEmpty) {
      AppSnackbar.warning(ManagerStrings.createOrderValidateMinBudget);
      return false;
    }
    if (maxBudgetController.text.trim().isEmpty) {
      AppSnackbar.warning(ManagerStrings.createOrderValidateMaxBudget);
      return false;
    }
    if (selectedDeadline.value == null) {
      AppSnackbar.warning(ManagerStrings.createOrderValidateDeadline);
      return false;
    }
    return true;
  }

  // ── Submit ─────────────────────────────────────────────────────────────────

  /// Builds the request and calls the use case. Shows a confirm dialog first.
  Future<void> submitOrder() async {
    if (!validate()) return;

    isLoading.value = true;

    final minBudget = double.tryParse(minBudgetController.text.trim()) ?? 0;
    final maxBudget = double.tryParse(maxBudgetController.text.trim()) ?? 0;

    final deliveryDate = selectedDeadline.value!;
    final dateStr =
        '${deliveryDate.year}-${deliveryDate.month.toString().padLeft(2, '0')}-${deliveryDate.day.toString().padLeft(2, '0')}';

    final request = CreateOrderRequest(
      productName: productNameController.text.trim(),
      description: descriptionController.text.trim(),
      specialRequests: specialRequestsController.text.trim(),
      fabricType: selectedFabric.value!,
      deliveryDate: dateStr,
      minExpectedBudget: minBudget,
      maxExpectedBudget: maxBudget,
      similarImages: referenceImages.isEmpty ? null : referenceImages.toList(),
    );

    final Either<Failure, dynamic> result =
        await _createOrderUseCase.execute(request);

    isLoading.value = false;

    result.fold(
      (failure) {
        AppSnackbar.error(failure.message);
      },
      (_) {
        AppSnackbar.success(
          ManagerStrings.createOrderSuccess,
          englishMessage: ManagerStrings.createOrderSuccessEn,
        );
        Get.back();
      },
    );
  }
}
