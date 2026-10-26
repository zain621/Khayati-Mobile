import 'dart:convert';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import 'package:app_mobile/core/util/phone_validator.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/widgets/map_location_picker.dart';
import '../../data/request/provider_register_request.dart';
import '../../domain/model/category_model.dart';
import '../../domain/model/provider_register_model.dart';
import '../../domain/use_case/get_categories_use_case.dart';
import '../../domain/use_case/provider_register_use_case.dart';

class ProviderRegisterController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ProviderRegisterUseCase _providerRegisterUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;

  ProviderRegisterController(
    this._providerRegisterUseCase,
    this._getCategoriesUseCase,
  );

  // Steps — Independent + Comprehensive get a 4th agreement step
  final RxInt currentStep = 0.obs;

  bool get needsVendorAgreement {
    if (selectedRole.value < 0) return false;
    final role = roleValues[selectedRole.value];
    return role == 'independent_tailor' || role == 'comprehensive_tailor';
  }

  int get totalSteps => needsVendorAgreement ? 4 : 3;

  // Step 1 state
  final RxInt selectedRole = (-1).obs;

  // Step 2 state
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final Rx<String?> selectedCity = Rx<String?>(null);
  final RxString selectedCountryCode = '+971'.obs;
  final RxString latitude = '0'.obs;
  final RxString longitude = '0'.obs;

  // Step 3 state
  final Rx<String?> selectedYears = Rx<String?>(null);
  final TextEditingController bioController = TextEditingController();
  final RxSet<String> selectedCategoryIds = <String>{}.obs;

  // Step 4 — Vendor agreement
  final TextEditingController agreementFullNameController =
      TextEditingController();
  final TextEditingController agreementTitleController = TextEditingController();
  final TextEditingController agreementTradeNameController =
      TextEditingController();
  final TextEditingController agreementLicenceController =
      TextEditingController();
  final TextEditingController agreementEidController = TextEditingController();
  final TextEditingController agreementPhoneController = TextEditingController();
  final RxBool agreementAccepted = false.obs;
  final RxBool agreementHasSignature = false.obs;
  final Rxn<Uint8List> agreementSignatureBytes = Rxn<Uint8List>();

  static const String agreementVersion = 'v1-2026';

  String get agreementDocumentText => '''
KHAYATI | خيّاطي
ONLINE TAILORING MARKETPLACE
Platform: Khayati.ae

Vendor / Tailor Agreement | اتفاقية مورد / خياط المنصة

OPERATIVE PROVISIONS
This Marketplace Vendor / Tailor Agreement is made on the Effective Date between Khayati | خيّاطي and the Vendor named. Khayati operates an online marketplace connecting customers with participating tailors, vendors and businesses.
The Vendor agrees to offer its tailoring, clothing, customization and related products/services through the Khayati Platform and to fulfil accepted customer orders in accordance with the agreed specifications.

VENDOR RESPONSIBILITIES
Provide accurate business, product/service, pricing and contact information; keep availability and prices updated; fulfil accepted orders to approved specifications; maintain quality and workmanship; complete orders on time; inform Khayati of delays; cooperate on complaints; comply with UAE laws; do not offer illegal, counterfeit, misleading or prohibited products/services.
The Vendor is responsible for products and services supplied through the Platform.

VENDOR LISTING & MARKETING
The Vendor authorizes Khayati to display and promote business/shop name and logo, products and services, photographs, prices, offers, and other information provided by the Vendor.

ORDERS & CUSTOMER SERVICE
Process orders through Khayati; confirm and fulfil accepted orders; follow approved measurements; complete on time; correct Vendor-attributable issues; cooperate with Khayati on complaints. For made-to-measure orders, confirm requirements before production.

PLATFORM FEE & COMMISSION
Free platform services for the first three (3) months from activation. After that, any commission or platform fee will be communicated and agreed in advance.

PAYMENTS & PAYOUTS
Customer payments may be processed through Khayati payment methods. Payouts follow Khayati and payment-provider procedures, subject to completion, refunds, cancellations, disputes, chargebacks and fees. Khayati may hold or adjust payouts where reasonably required.

RETURNS, REFUNDS & ALTERATIONS
Comply with Khayati Return, Refund and Cancellation Policy. Cooperate on Vendor-attributable defects, incorrect specifications or failure to fulfil.

CUSTOMER INFORMATION
Use customer data only to fulfil orders. Do not sell, misuse, disclose, or bypass Khayati for platform-originated transactions.

COMPLIANCE & VENDOR DOCUMENTS
Provide accurate documents; maintain required licenses; comply with UAE laws. Khayati may request updated documentation.

SUSPENSION & TERMINATION
Khayati may suspend or restrict accounts for serious complaints, failures, fraud, quality issues, payment disputes, breach, invalid documentation or legal requirements. Either party may terminate by written notice.

KHAYATI'S ROLE
Khayati provides the technology marketplace. Unless agreed in writing, Khayati is not the manufacturer or tailor and does not control day-to-day Vendor operations.

GOVERNING LAW & DISPUTES
Attempt amicable resolution first; otherwise UAE law and jurisdiction.

AGREEMENT & ELECTRONIC SIGNATURE
Both parties confirm they have read and accepted these terms. Electronic signature or acceptance may be used as evidence of acceptance.

Party A: HAMAD ALADAWI SERVICES BROKERAGE — Khayati | خيّاطي — Licence No. CN-6580875 — Platform: Khayati.ae
''';

  // Categories from API
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxBool isCategoriesLoading = false.obs;

  // Loading state
  final RxBool isLoading = false.obs;

  // Animation
  late AnimationController animController;
  late Animation<double> fadeAnim;
  late Animation<Offset> slideAnim;

  // Role API values mapped by index
  static const List<String> roleValues = [
    'independent_tailor',
    'shop_owner',
    'comprehensive_tailor',
  ];

  // Years display-to-API mapping
  static const Map<String, String> yearsMapping = {
    'أقل من سنة': '1',
    '1 - 3 سنوات': '3',
    '3 - 5 سنوات': '5',
    '5 - 10 سنوات': '10',
    'أكثر من 10 سنوات': '15',
  };

  @override
  void onInit() {
    super.onInit();
    _initAnimation();
    fetchCategories();
  }

  void _initAnimation() {
    animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animController, curve: Curves.easeOut),
    );
    slideAnim =
        Tween<Offset>(begin: const Offset(0.06, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: animController, curve: Curves.easeOut),
    );
    animController.forward();
  }

  // ──────────────────────────────────────────────
  // Fetch Categories
  // ──────────────────────────────────────────────
  Future<void> fetchCategories() async {
    isCategoriesLoading.value = true;

    final Either<Failure, GetCategoriesModel> result =
        await _getCategoriesUseCase.execute();

    result.fold(
      (failure) {
        AppSnackbar.error(failure.message);
      },
      (data) {
        categories.assignAll(data.categories);
      },
    );

    isCategoriesLoading.value = false;
  }

  // ──────────────────────────────────────────────
  // Step Navigation
  // ──────────────────────────────────────────────
  bool get canProceed {
    switch (currentStep.value) {
      case 0:
        return selectedRole.value >= 0;
      case 1:
        final roleOk = selectedRole.value >= 0;
        final role = roleOk ? roleValues[selectedRole.value] : '';
        final needsEmail =
            role == 'independent_tailor' || role == 'comprehensive_tailor';
        final emailOk = !needsEmail ||
            RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$')
                .hasMatch(emailController.text.trim());
        return businessNameController.text.trim().isNotEmpty &&
            ownerNameController.text.trim().isNotEmpty &&
            phoneController.text.trim().isNotEmpty &&
            emailOk &&
            selectedCity.value != null;
      case 2:
        return selectedYears.value != null && selectedCategoryIds.isNotEmpty;
      case 3:
        return agreementAccepted.value &&
            agreementHasSignature.value &&
            agreementFullNameController.text.trim().length >= 2;
      default:
        return false;
    }
  }

  void showAgreementRequiredDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Vendor agreement required'),
        content: const Text(
          'Your tailor account will not be verified until the Vendor / Tailor Agreement is completed and signed. Please fill the agreement and add your signature.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void setAgreementSignatureBytes(Uint8List? bytes) {
    agreementSignatureBytes.value = bytes;
    agreementHasSignature.value = bytes != null && bytes.isNotEmpty;
  }

  void clearAgreementSignature() {
    agreementSignatureBytes.value = null;
    agreementHasSignature.value = false;
  }

  void nextStep() {
    if (currentStep.value < totalSteps - 1) {
      if (currentStep.value == 2 && needsVendorAgreement) {
        // Prefill agreement fields when entering step 4
        if (agreementFullNameController.text.isEmpty) {
          agreementFullNameController.text = ownerNameController.text;
        }
        if (agreementTradeNameController.text.isEmpty) {
          agreementTradeNameController.text = businessNameController.text;
        }
        if (agreementPhoneController.text.isEmpty) {
          agreementPhoneController.text = phoneController.text;
        }
      }
      animController.reset();
      currentStep.value++;
      animController.forward();
    } else {
      if (needsVendorAgreement && !canProceed) {
        showAgreementRequiredDialog();
        return;
      }
      submitProviderRegister();
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      animController.reset();
      currentStep.value--;
      animController.forward();
    }
  }

  void clampStepToRole() {
    if (currentStep.value >= totalSteps) {
      currentStep.value = totalSteps - 1;
    }
  }

  // ──────────────────────────────────────────────
  // Map Picker
  // ──────────────────────────────────────────────
  Future<void> openMapPicker(BuildContext context) async {
    // If a location was already selected, open the map at that position.
    LatLng? initial;
    if (latitude.value != '0' && longitude.value != '0') {
      initial = LatLng(
        double.tryParse(latitude.value) ?? 24.4539,
        double.tryParse(longitude.value) ?? 54.3773,
      );
    }

    final result = await MapLocationPicker.show(
      context,
      initialPosition: initial,
    );

    // Unfocus to avoid UI freeze after returning from the map screen.
    FocusManager.instance.primaryFocus?.unfocus();

    if (result != null) {
      latitude.value = result.latitude.toString();
      longitude.value = result.longitude.toString();
      locationController.text = ManagerStrings.mapPickerLocationSelected;
    }
  }

  // ──────────────────────────────────────────────
  // Toggle Category Selection
  // ──────────────────────────────────────────────
  void toggleCategory(String categoryId) {
    if (selectedCategoryIds.contains(categoryId)) {
      selectedCategoryIds.remove(categoryId);
    } else {
      selectedCategoryIds.add(categoryId);
    }
  }

  // ──────────────────────────────────────────────
  // Submit Provider Registration
  // ──────────────────────────────────────────────
  Future<void> submitProviderRegister() async {
    // Validate all steps
    if (selectedRole.value < 0) {
      AppSnackbar.warning(
        ManagerStrings.providerErrorSelectRole,
      );
      return;
    }
    if (businessNameController.text.trim().isEmpty) {
      AppSnackbar.warning(
        ManagerStrings.providerErrorBusinessName,
      );
      return;
    }
    if (ownerNameController.text.trim().isEmpty) {
      AppSnackbar.warning(
        ManagerStrings.providerErrorOwnerName,
      );
      return;
    }
    if (phoneController.text.trim().isEmpty) {
      AppSnackbar.warning(
        ManagerStrings.providerErrorPhone,
      );
      return;
    }
    final role = roleValues[selectedRole.value];
    final needsAgreement =
        role == 'independent_tailor' || role == 'comprehensive_tailor';
    if (needsAgreement) {
      final email = emailController.text.trim();
      if (email.isEmpty ||
          !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email)) {
        AppSnackbar.warning('Please enter a valid email address');
        return;
      }
    }
    if (selectedCity.value == null) {
      AppSnackbar.warning(
        ManagerStrings.providerErrorCity,
      );
      return;
    }
    if (selectedYears.value == null) {
      AppSnackbar.warning(
        ManagerStrings.providerErrorYears,
      );
      return;
    }
    if (selectedCategoryIds.isEmpty) {
      AppSnackbar.warning(
        ManagerStrings.providerErrorCategories,
      );
      return;
    }

    if (needsAgreement) {
      final phoneDigits =
          agreementPhoneController.text.replaceAll(RegExp(r'\D'), '');
      final missing =
          agreementFullNameController.text.trim().length < 2 ||
              agreementTitleController.text.trim().length < 2 ||
              agreementTradeNameController.text.trim().length < 2 ||
              agreementLicenceController.text.trim().length < 2 ||
              agreementEidController.text.trim().length < 5 ||
              phoneDigits.length < 8 ||
              phoneDigits.length > 15 ||
              !agreementAccepted.value ||
              !agreementHasSignature.value ||
              agreementSignatureBytes.value == null;
      if (missing) {
        showAgreementRequiredDialog();
        currentStep.value = 3;
        return;
      }
    }

    isLoading.value = true;

    String? signatureDataUrl;
    if (needsAgreement && agreementSignatureBytes.value != null) {
      final b64 = base64Encode(agreementSignatureBytes.value!);
      signatureDataUrl = 'data:image/png;base64,$b64';
    }

    final request = ProviderRegisterRequest(
      role: role,
      businessName: businessNameController.text.trim(),
      ownerName: ownerNameController.text.trim(),
      phone: PhoneValidator.toE164(
        phoneController.text,
        selectedCountryCode.value,
      ),
      email: needsAgreement ? emailController.text.trim().toLowerCase() : null,
      city: selectedCity.value!,
      latitude: latitude.value,
      longitude: longitude.value,
      detailedAddress: addressController.text.trim(),
      yearsOfExperience: yearsMapping[selectedYears.value] ?? '1',
      bio: bioController.text.trim().isEmpty
          ? 'Tailor applying via Khayati mobile app.'
          : bioController.text.trim(),
      categoryIds: selectedCategoryIds.toList(),
      agreementSignerName: needsAgreement
          ? agreementFullNameController.text.trim()
          : null,
      agreementSignatureDataUrl: signatureDataUrl,
      agreementVersion: needsAgreement ? agreementVersion : null,
      agreementPayload: needsAgreement
          ? {
              'fullName': agreementFullNameController.text.trim(),
              'title': agreementTitleController.text.trim(),
              'tradeName': agreementTradeNameController.text.trim(),
              'licenceNo': agreementLicenceController.text.trim(),
              'eidPassport': agreementEidController.text.trim(),
              'phone': agreementPhoneController.text.trim(),
              'accepted': true,
              'platform': 'Khayati.ae',
              'partyA': {
                'entity': 'HAMAD ALADAWI SERVICES BROKERAGE',
                'brand': 'Khayati | خيّاطي',
                'licenceNo': 'CN-6580875',
                'platform': 'Khayati.ae',
              },
            }
          : null,
    );

    final Either<Failure, ProviderRegisterModel> result =
        await _providerRegisterUseCase.execute(request);

    result.fold(
      (failure) {
        AppSnackbar.error(failure.message);
      },
      (data) {
        AppSnackbar.success(
          ManagerStrings.providerRegisterSuccess,
        );
        Get.offNamed(Routes.providerRegisterSuccess);
      },
    );

    isLoading.value = false;
  }

  @override
  void onClose() {
    animController.dispose();
    businessNameController.dispose();
    ownerNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    locationController.dispose();
    bioController.dispose();
    agreementFullNameController.dispose();
    agreementTitleController.dispose();
    agreementTradeNameController.dispose();
    agreementLicenceController.dispose();
    agreementEidController.dispose();
    agreementPhoneController.dispose();
    super.onClose();
  }
}
