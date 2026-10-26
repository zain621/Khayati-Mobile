import 'dart:io';
import 'dart:typed_data';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/network/app_api.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/service/translation_service.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../../data/request/add_variant_request.dart';
import '../../domain/model/product_model.dart';
import '../../domain/model/selected_color_entry.dart';
import '../../domain/use_case/get_product_details_use_case.dart';
import '../../domain/use_case/create_shop_owner_product_use_case.dart';
import '../../domain/use_case/update_shop_owner_product_use_case.dart';
import '../../domain/use_case/add_variant_use_case.dart';
import '../../domain/use_case/update_variant_use_case.dart';
import '../../domain/use_case/delete_variant_use_case.dart';

/// Controller for the add/edit product form.
class AddEditProductController extends GetxController {
  final GetProductDetailsUseCase _getProductDetailsUseCase;
  final CreateShopOwnerProductUseCase _createProductUseCase;
  final UpdateShopOwnerProductUseCase _updateProductUseCase;
  final AddVariantUseCase _addVariantUseCase;
  final UpdateVariantUseCase _updateVariantUseCase;
  final DeleteVariantUseCase _deleteVariantUseCase;
  final TranslationService _translationService;
  final ProductModel? editProduct;

  AddEditProductController(
    this._getProductDetailsUseCase,
    this._createProductUseCase,
    this._updateProductUseCase,
    this._addVariantUseCase,
    this._updateVariantUseCase,
    this._deleteVariantUseCase,
    this._translationService, {
    this.editProduct,
  });

  bool get isEditMode => editProduct != null;

  /// Predefined fashion color palette.
  static const List<Map<String, String>> kPredefinedColors = [
    {'nameAr': 'أسود',    'hex': '#111111'},
    {'nameAr': 'أبيض',    'hex': '#F5F5F5'},
    {'nameAr': 'بيج',     'hex': '#C8A97E'},
    {'nameAr': 'بني',     'hex': '#8B5E3C'},
    {'nameAr': 'كحلي',    'hex': '#1B2A4A'},
    {'nameAr': 'رمادي',   'hex': '#9E9E9E'},
    {'nameAr': 'أحمر',    'hex': '#C62828'},
    {'nameAr': 'أزرق',    'hex': '#1565C0'},
    {'nameAr': 'وردي',    'hex': '#D81B60'},
    {'nameAr': 'أخضر',    'hex': '#2E7D32'},
  ];

  /// Standard clothing sizes.
  static const List<String> kAvailableSizes = [
    'XS', 'S', 'M', 'L', 'XL', 'XXL', '3XL',
  ];

  /// Maximum number of images allowed per product.
  static const int maxImages = 10;

  /// Localized display name for a predefined color (by hex). Falls back to
  /// [fallback] (the stored Arabic name) for custom colors. The value sent to
  /// the backend stays the canonical Arabic name — only the UI label changes.
  static String localizedColorName(String hexCode, {String fallback = ''}) {
    switch (hexCode.toUpperCase()) {
      case '#111111': return ManagerStrings.addProductColorBlack;
      case '#F5F5F5': return ManagerStrings.addProductColorWhite;
      case '#C8A97E': return ManagerStrings.addProductColorBeige;
      case '#8B5E3C': return ManagerStrings.addProductColorBrown;
      case '#1B2A4A': return ManagerStrings.addProductColorNavy;
      case '#9E9E9E': return ManagerStrings.addProductColorGrey;
      case '#C62828': return ManagerStrings.addProductColorRed;
      case '#1565C0': return ManagerStrings.addProductColorBlue;
      case '#D81B60': return ManagerStrings.addProductColorPink;
      case '#2E7D32': return ManagerStrings.addProductColorGreen;
      default: return fallback;
    }
  }

  // ─── Text controllers ────────────────────────────────────────────────────

  final nameArCtrl        = TextEditingController();
  final nameEnCtrl        = TextEditingController();
  final nameUrCtrl        = TextEditingController();
  final priceCtrl         = TextEditingController();
  final originalPriceCtrl = TextEditingController();
  final deliveryMinCtrl   = TextEditingController();
  final deliveryMaxCtrl   = TextEditingController();

  // ─── Reactive state ──────────────────────────────────────────────────────

  final isTranslating    = false.obs;
  final isLoadingDetails = false.obs;
  final isSaving         = false.obs;

  final careInstructions  = <String>[].obs;
  final features          = <String>[].obs;

  // key: "$hexCode|$size"  value: quantity
  final variantQuantities = <String, int>{}.obs;

  // Colors and sizes (create mode — seeds the matrix)
  final selectedColors    = <SelectedColorEntry>[].obs;
  final selectedSizes     = <String>[].obs;

  // Category
  final isLoadingCategories  = false.obs;
  final categories           = <ProductCategoryModel>[].obs;
  final selectedCategoryId   = ''.obs;
  final selectedCategoryName = ''.obs;

  // Edit mode — existing data from API
  final existingVariants  = <ProductVariantModel>[].obs;
  final existingImages    = <ProductImageModel>[].obs;
  final newImages         = <XFile>[].obs;
  final deletedImageIds   = <String>[];

  @override
  void onInit() {
    super.onInit();
    _fetchCategories();
    if (isEditMode) _loadProductDetails();
  }

  // ─── Categories ──────────────────────────────────────────────────────────

  Future<void> _fetchCategories() async {
    isLoadingCategories.value = true;
    try {
      final response = await instance<AppService>().getCategories();
      if (response.data?.items != null) {
        categories.assignAll(
          response.data!.items!
              .map((c) => ProductCategoryModel(id: c.id ?? '', name: c.name ?? ''))
              .toList(),
        );
        if (isEditMode) {
          final cat = categories.firstWhereOrNull(
            (c) => c.id == editProduct!.categoryId,
          );
          if (cat != null) {
            selectedCategoryId.value   = cat.id;
            selectedCategoryName.value = cat.name;
          }
        }
      }
    } catch (_) {
      // Fail silently — categories can be retried
    } finally {
      isLoadingCategories.value = false;
    }
  }

  void selectCategory(ProductCategoryModel cat) {
    selectedCategoryId.value   = cat.id;
    selectedCategoryName.value = cat.name;
  }

  // ─── Load product details (edit mode) ───────────────────────────────────

  Future<void> _loadProductDetails() async {
    isLoadingDetails.value = true;
    final result = await _getProductDetailsUseCase.execute(editProduct!.id);
    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (product) => _populateFromProduct(product),
    );
    isLoadingDetails.value = false;
  }

  void _populateFromProduct(ProductModel p) {
    nameArCtrl.text         = p.nameAr;
    nameEnCtrl.text         = p.nameEn;
    nameUrCtrl.text         = p.nameUr;
    priceCtrl.text          = p.price.toInt().toString();
    originalPriceCtrl.text  = p.priceBeforeDiscount?.toInt().toString() ?? '';
    deliveryMinCtrl.text    = p.deliveryTimeMin > 0 ? p.deliveryTimeMin.toString() : '';
    deliveryMaxCtrl.text    = p.deliveryTimeMax > 0 ? p.deliveryTimeMax.toString() : '';
    careInstructions.assignAll(p.careInstructions);
    features.assignAll(p.features);
    existingImages.assignAll(p.images);
    existingVariants.assignAll(p.variants);
  }

  // ─── Translation ─────────────────────────────────────────────────────────

  Future<void> translate() async {
    final arabic = nameArCtrl.text.trim();
    if (arabic.isEmpty || isTranslating.value) return;
    isTranslating.value = true;
    final result = await _translationService.translate(arabic);
    if (result.en.isNotEmpty) nameEnCtrl.text = result.en;
    if (result.ur.isNotEmpty) nameUrCtrl.text = result.ur;
    isTranslating.value = false;
  }

  // ─── Colors ───────────────────────────────────────────────────────────────

  bool isColorSelected(String hexCode) => selectedColors.any(
        (c) => c.hexCode.toUpperCase() == hexCode.toUpperCase(),
      );

  void toggleColor(SelectedColorEntry entry) {
    final idx = selectedColors.indexWhere(
      (c) => c.hexCode.toUpperCase() == entry.hexCode.toUpperCase(),
    );
    if (idx >= 0) {
      // Remove color and all its variant quantities
      final hex = entry.hexCode.toUpperCase();
      variantQuantities.removeWhere((key, _) => key.startsWith('$hex|'));
      selectedColors.removeAt(idx);
    } else {
      selectedColors.add(entry);
    }
  }

  void addCustomColor(String nameAr, Color color) {
    if (nameAr.trim().isEmpty) return;
    final hex =
        '#${color.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
    final entry = SelectedColorEntry(nameAr: nameAr.trim(), hexCode: hex);
    if (!isColorSelected(hex)) selectedColors.add(entry);
  }

  // ─── Sizes ────────────────────────────────────────────────────────────────

  bool isSizeSelected(String size) => selectedSizes.contains(size);

  void toggleSize(String size) {
    if (selectedSizes.contains(size)) {
      // Remove size and all its variant quantities
      variantQuantities.removeWhere((key, _) => key.endsWith('|$size'));
      selectedSizes.remove(size);
    } else {
      selectedSizes.add(size);
    }
  }

  // ─── Variant quantities (create mode) ────────────────────────────────────

  String _variantKey(String hexCode, String size) =>
      '${hexCode.toUpperCase()}|$size';

  int getVariantQty(String hexCode, String size) =>
      variantQuantities[_variantKey(hexCode, size)] ?? 0;

  void setVariantQty(String hexCode, String size, int qty) {
    final key = _variantKey(hexCode, size);
    if (qty <= 0) {
      variantQuantities.remove(key);
    } else {
      variantQuantities[key] = qty;
    }
  }

  // ─── Edit-mode variant actions ────────────────────────────────────────────

  Future<void> addVariant(AddVariantRequest request) async {
    isSaving.value = true;
    final result = await _addVariantUseCase.execute(editProduct!.id, request);
    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (_) {
        AppSnackbar.success(
          ManagerStrings.addProductVariantAdded,
          englishMessage: ManagerStrings.addProductVariantAddedEn,
        );
        _loadProductDetails();
      },
    );
    isSaving.value = false;
  }

  Future<void> updateVariant(String variantId, AddVariantRequest request) async {
    isSaving.value = true;
    final result = await _updateVariantUseCase.execute(
      editProduct!.id,
      variantId,
      request,
    );
    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (_) {
        AppSnackbar.success(
          ManagerStrings.addProductVariantUpdated,
          englishMessage: ManagerStrings.addProductVariantUpdatedEn,
        );
        _loadProductDetails();
      },
    );
    isSaving.value = false;
  }

  Future<void> deleteVariant(String variantId) async {
    isSaving.value = true;
    final result =
        await _deleteVariantUseCase.execute(editProduct!.id, variantId);
    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (_) {
        AppSnackbar.success(
          ManagerStrings.addProductVariantDeleted,
          englishMessage: ManagerStrings.addProductVariantDeletedEn,
        );
        _loadProductDetails();
      },
    );
    isSaving.value = false;
  }

  // ─── Images ───────────────────────────────────────────────────────────────

  int get _currentImageCount =>
      (isEditMode ? existingImages.length : 0) + newImages.length;

  /// Picks one or more images from the gallery.
  Future<void> pickImages() async {
    final remaining = maxImages - _currentImageCount;
    if (remaining <= 0) return;
    try {
      final picker = ImagePicker();
      final images = await picker.pickMultiImage(
        imageQuality: 85,
        limit: remaining,
      );
      if (images.isNotEmpty) {
        newImages.addAll(images.take(remaining));
      }
    } catch (e) {
      AppSnackbar.error(
        ManagerStrings.addProductValidationImages,
        englishMessage: ManagerStrings.addProductValidationImagesEn,
      );
    }
  }

  /// Captures a single image using the device camera.
  Future<void> captureImage() async {
    if (_currentImageCount >= maxImages) return;
    try {
      final picker = ImagePicker();
      final photo = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );
      if (photo != null) newImages.add(photo);
    } catch (e) {
      AppSnackbar.error(
        ManagerStrings.addProductValidationImages,
        englishMessage: ManagerStrings.addProductValidationImagesEn,
      );
    }
  }

  void removeNewImage(int index) => newImages.removeAt(index);

  void removeExistingImage(ProductImageModel image) {
    existingImages.remove(image);
    deletedImageIds.add(image.id);
  }

  // ─── Care instructions & features ────────────────────────────────────────

  void addCareInstruction(String text) {
    final val = text.trim();
    if (val.isEmpty || careInstructions.contains(val)) return;
    careInstructions.add(val);
  }

  void removeCareInstruction(int index) => careInstructions.removeAt(index);

  void addFeature(String text) {
    final val = text.trim();
    if (val.isEmpty || features.contains(val)) return;
    features.add(val);
  }

  void removeFeature(int index) => features.removeAt(index);

  // ─── Validation ──────────────────────────────────────────────────────────

  bool _validate() {
    if (newImages.isEmpty && existingImages.isEmpty) {
      AppSnackbar.warning(
        ManagerStrings.addProductValidationImages,
        englishMessage: ManagerStrings.addProductValidationImagesEn,
      );
      return false;
    }
    if (nameArCtrl.text.trim().isEmpty) {
      AppSnackbar.warning(
        ManagerStrings.addProductValidationNameAr,
        englishMessage: ManagerStrings.addProductValidationNameArEn,
      );
      return false;
    }
    if (selectedCategoryId.value.isEmpty) {
      AppSnackbar.warning(
        ManagerStrings.addProductValidationCategory,
        englishMessage: ManagerStrings.addProductValidationCategoryEn,
      );
      return false;
    }
    final parsedPrice = double.tryParse(priceCtrl.text.trim());
    if (priceCtrl.text.trim().isEmpty || parsedPrice == null || parsedPrice <= 0) {
      AppSnackbar.warning(
        ManagerStrings.addProductValidationPrice,
        englishMessage: ManagerStrings.addProductValidationPriceEn,
      );
      return false;
    }
    if (!isEditMode) {
      if (selectedColors.isEmpty) {
        AppSnackbar.warning(
          ManagerStrings.addProductValidationColors,
          englishMessage: ManagerStrings.addProductValidationColorsEn,
        );
        return false;
      }
      if (selectedSizes.isEmpty) {
        AppSnackbar.warning(
          ManagerStrings.addProductValidationSizes,
          englishMessage: ManagerStrings.addProductValidationSizesEn,
        );
        return false;
      }
      // Ensure at least one variant quantity is set
      final hasQty = selectedColors.any((color) =>
          selectedSizes.any((size) => getVariantQty(color.hexCode, size) > 0));
      if (!hasQty) {
        AppSnackbar.warning(
          ManagerStrings.addProductValidationVariantQty,
          englishMessage: ManagerStrings.addProductValidationVariantQtyEn,
        );
        return false;
      }
    }
    return true;
  }

  // ─── Build FormData ──────────────────────────────────────────────────────

  Future<FormData> _buildFormData() async {
    final fields = <MapEntry<String, String>>[];

    fields.add(MapEntry('nameAr', nameArCtrl.text.trim()));
    fields.add(MapEntry('nameEn', nameEnCtrl.text.trim()));
    fields.add(MapEntry('nameUr', nameUrCtrl.text.trim()));
    fields.add(MapEntry('categoryId', selectedCategoryId.value));
    fields.add(MapEntry('price', priceCtrl.text.trim()));

    final origPrice = originalPriceCtrl.text.trim();
    if (origPrice.isNotEmpty) {
      fields.add(MapEntry('priceBeforeDiscount', origPrice));
    }

    final dMin = deliveryMinCtrl.text.trim();
    if (dMin.isNotEmpty) fields.add(MapEntry('deliveryTimeMin', dMin));

    final dMax = deliveryMaxCtrl.text.trim();
    if (dMax.isNotEmpty) fields.add(MapEntry('deliveryTimeMax', dMax));

    for (int i = 0; i < careInstructions.length; i++) {
      fields.add(MapEntry('careInstructions[$i]', careInstructions[i]));
    }

    for (int i = 0; i < features.length; i++) {
      fields.add(MapEntry('features[$i]', features[i]));
    }

    // Build variants from color×size matrix (create mode only)
    if (!isEditMode) {
      int vi = 0;
      for (final color in selectedColors) {
        for (final size in selectedSizes) {
          final qty = getVariantQty(color.hexCode, size);
          if (qty > 0) {
            fields.add(MapEntry('variants[$vi][color]', color.nameAr));
            fields.add(MapEntry('variants[$vi][colorHexCode]', color.hexCode));
            fields.add(MapEntry('variants[$vi][size]', size));
            fields.add(MapEntry('variants[$vi][quantity]', qty.toString()));
            vi++;
          }
        }
      }
    }

    final files = <MapEntry<String, MultipartFile>>[];
    for (final image in newImages) {
      files.add(MapEntry('images', await _compressToMultipart(image)));
    }

    return FormData()
      ..fields.addAll(fields)
      ..files.addAll(files);
  }

  /// Compresses an [XFile] to ≤ 800 KB before upload.
  Future<MultipartFile> _compressToMultipart(XFile image) async {
    final ext = image.path.split('.').last.toLowerCase();
    final isPng = ext == 'png';
    final mime = isPng ? 'png' : ext == 'webp' ? 'webp' : 'jpeg';
    final format = isPng ? CompressFormat.png : CompressFormat.jpeg;

    Uint8List? compressed;
    try {
      compressed = await FlutterImageCompress.compressWithFile(
        image.path,
        quality: 75,
        minWidth: 1080,
        minHeight: 1080,
        format: format,
      );
    } catch (_) {
      compressed = null;
    }

    final bytes = compressed ?? await File(image.path).readAsBytes();
    return MultipartFile.fromBytes(
      bytes,
      filename: image.name,
      contentType: MediaType('image', mime),
    );
  }

  // ─── Submit ──────────────────────────────────────────────────────────────

  Future<void> submitForm() async {
    if (!_validate() || isSaving.value) return;
    isSaving.value = true;

    try {
      final formData = await _buildFormData();

      if (isEditMode) {
        await _handleUpdate(formData);
      } else {
        await _handleCreate(formData);
      }
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> _handleCreate(FormData formData) async {
    final result = await _createProductUseCase.execute(formData);
    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (_) {
        AppSnackbar.success(
          ManagerStrings.addProductCreatedSuccess,
          englishMessage: ManagerStrings.addProductCreatedSuccessEn,
        );
        Get.back(result: true);
      },
    );
  }

  Future<void> _handleUpdate(FormData formData) async {
    final result =
        await _updateProductUseCase.execute(editProduct!.id, formData);
    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (_) async {
        // Delete removed images in parallel
        if (deletedImageIds.isNotEmpty) {
          await _deleteRemovedImages();
        }
        AppSnackbar.success(
          ManagerStrings.addProductUpdatedSuccess,
          englishMessage: ManagerStrings.addProductUpdatedSuccessEn,
        );
        Get.back(result: true);
      },
    );
  }

  Future<void> _deleteRemovedImages() async {
    final futures = deletedImageIds
        .map((id) => instance<AppService>()
            .deleteShopOwnerProductImage(editProduct!.id, id))
        .toList();
    await Future.wait(futures, eagerError: false);
  }

  // ─── Lifecycle ───────────────────────────────────────────────────────────

  @override
  void onClose() {
    nameArCtrl.dispose();
    nameEnCtrl.dispose();
    nameUrCtrl.dispose();
    priceCtrl.dispose();
    originalPriceCtrl.dispose();
    deliveryMinCtrl.dispose();
    deliveryMaxCtrl.dispose();
    super.onClose();
  }
}

