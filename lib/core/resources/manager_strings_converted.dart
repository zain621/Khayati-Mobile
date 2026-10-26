import 'package:easy_localization/easy_localization.dart';

/// A class defined for strings the app
class ManagerStrings {
  //Splash Screen
    static String get splashScreenHint=> tr('splashScreenHint');

  // OnBoarding Screen
  static String get onBoardingTitle1 => tr('onBoardingTitle1');
  static String get onBoardingSubtitle1 =>
      tr('onBoardingSubtitle1');
  static String get onBoardingTitle2 => tr('onBoardingTitle2');
  static String get onBoardingSubtitle2 =>
      tr('onBoardingSubtitle2');
  static String get onBoardingTitle3 => tr('onBoardingTitle3');
  static String get onBoardingSubtitle3 =>
      tr('onBoardingSubtitle3');
  static String get onBoardingNext => tr('onBoardingNext');
  static String get onBoardingStart => tr('onBoardingStart');
  static String get onBoardingLogin => tr('onBoardingLogin');

  // Login Screen
  static String get loginScreenTitle => tr('loginScreenTitle');
  static String get loginScreenSubTitle => tr('loginScreenSubTitle');
  static String get loginScreenPhoneLabel => tr('loginScreenPhoneLabel');
  static String get loginScreenPhoneHint => tr('loginScreenPhoneHint');
  static String get loginScreenPasswordLabel => tr('loginScreenPasswordLabel');
  static String get loginScreenPasswordHint => tr('loginScreenPasswordHint');
  static String get loginScreenForgotPassword => tr('loginScreenForgotPassword');
  static String get loginScreenButton => tr('loginScreenButton');
  static String get loginScreenNoAccount => tr('loginScreenNoAccount');
  static String get loginScreenRegister => tr('loginScreenRegister');

  // Login Snackbar & Validation Messages
  static String get loginSuccess => tr('loginSuccess');
  static String get loginSuccessEn => tr('loginSuccessEn');
  static String get loginErrorPhoneEmpty => tr('loginErrorPhoneEmpty');
  static String get loginErrorPhoneEmptyEn => tr('loginErrorPhoneEmptyEn');
  static String get loginErrorPasswordEmpty => tr('loginErrorPasswordEmpty');
  static String get loginErrorPasswordEmptyEn => tr('loginErrorPasswordEmptyEn');

  // Reset Password Screen
  static String get resetPasswordTitle => tr('resetPasswordTitle');
  static String get resetPasswordSubTitle =>
      tr('resetPasswordSubTitle');
  static String get resetPasswordPhoneLabel => tr('resetPasswordPhoneLabel');
  static String get resetPasswordPhoneHint => tr('resetPasswordPhoneHint');
  static String get resetPasswordSendCode => tr('resetPasswordSendCode');

  // Reset Password Validation & Snackbar
  static String get resetPasswordErrorPhoneEmpty => tr('resetPasswordErrorPhoneEmpty');
  static String get resetPasswordErrorPhoneEmptyEn => tr('resetPasswordErrorPhoneEmptyEn');
  static String get forgotPasswordSuccess => tr('forgotPasswordSuccess');
  static String get forgotPasswordSuccessEn => tr('forgotPasswordSuccessEn');

  // Verification Code Screen
  static String get verificationTitle => tr('verificationTitle');
  static String get verificationSubTitle1 =>
      tr('verificationSubTitle1');
  static String get verificationSubTitle2 => tr('verificationSubTitle2');
  static String get verificationCodeLabel => tr('verificationCodeLabel');
  static String get verificationResend => tr('verificationResend');
  static String get verificationResendAfter => tr('verificationResendAfter');
  static String get verificationVerifyButton => tr('verificationVerifyButton');

  // Verification Code Validation & Snackbar
  static String get verifyCodeErrorEmpty => tr('verifyCodeErrorEmpty');
  static String get verifyCodeErrorEmptyEn => tr('verifyCodeErrorEmptyEn');
  static String get verifyCodeSuccess => tr('verifyCodeSuccess');
  static String get verifyCodeSuccessEn => tr('verifyCodeSuccessEn');
  static String get resendCodeSuccess => tr('resendCodeSuccess');
  static String get resendCodeSuccessEn => tr('resendCodeSuccessEn');

  // Provider Login OTP Screen
  static String get providerLoginOtpSuccess => tr('providerLoginOtpSuccess');
  static String get providerLoginOtpSuccessEn => tr('providerLoginOtpSuccessEn');

  // New Password Screen
  static String get newPasswordTitle => tr('newPasswordTitle');
  static String get newPasswordSubTitle =>
      tr('newPasswordSubTitle');
  static String get newPasswordLabel => tr('newPasswordLabel');
  static String get newPasswordHint =>
      tr('newPasswordHint');
  static String get newPasswordConfirmLabel => tr('newPasswordConfirmLabel');
  static String get newPasswordUpdateButton => tr('newPasswordUpdateButton');

  // New Password Validation & Snackbar
  static String get newPasswordErrorEmpty => tr('newPasswordErrorEmpty');
  static String get newPasswordErrorEmptyEn => tr('newPasswordErrorEmptyEn');
  static String get newPasswordErrorConfirmEmpty => tr('newPasswordErrorConfirmEmpty');
  static String get newPasswordErrorConfirmEmptyEn => tr('newPasswordErrorConfirmEmptyEn');
  static String get newPasswordErrorMismatch => tr('newPasswordErrorMismatch');
  static String get newPasswordErrorMismatchEn => tr('newPasswordErrorMismatchEn');
  static String get newPasswordErrorTooShort => tr('newPasswordErrorTooShort');
  static String get newPasswordErrorTooShortEn => tr('newPasswordErrorTooShortEn');
  static String get resetPasswordFlowSuccess => tr('resetPasswordFlowSuccess');
  static String get resetPasswordFlowSuccessEn => tr('resetPasswordFlowSuccessEn');

  // Password Changed Success Screen
  static String get successPasswordTitle => tr('successPasswordTitle');
  static String get successPasswordSubTitle =>
      tr('successPasswordSubTitle');
  static String get successPasswordButton => tr('successPasswordButton');
  static String get passwordChangedTitle => tr('passwordChangedTitle');
  static String get passwordChangedSubTitle1 =>
      tr('passwordChangedSubTitle1');
  static String get passwordChangedSubTitle2 => tr('passwordChangedSubTitle2');
  static String get passwordChangedButton => tr('passwordChangedButton');
  static String get passwordChangedPrivacy => tr('passwordChangedPrivacy');

  // Customer Register Screen
  static String get registerTitle => tr('registerTitle');
  static String get registerSubTitle =>
      tr('registerSubTitle');
  static String get registerFullNameLabel => tr('registerFullNameLabel');
  static String get registerFullNameHint => tr('registerFullNameHint');
  static String get registerPhoneLabel => tr('registerPhoneLabel');
  static String get registerPhoneHint => tr('registerPhoneHint');
  static String get registerPasswordLabel => tr('registerPasswordLabel');
  static String get registerPasswordHint => tr('registerPasswordHint');
  static String get registerButton => tr('registerButton');
  static String get registerHaveAccount => tr('registerHaveAccount');
  static String get registerLogin => tr('registerLogin');

  // Register validation & snackbar messages
  static String get registerErrorNameEmpty => tr('registerErrorNameEmpty');
  static String get registerErrorNameEmptyEn => tr('registerErrorNameEmptyEn');
  static String get registerErrorPhoneEmpty => tr('registerErrorPhoneEmpty');
  static String get registerErrorPhoneEmptyEn => tr('registerErrorPhoneEmptyEn');
  static String get registerErrorPasswordEmpty => tr('registerErrorPasswordEmpty');
  static String get registerErrorPasswordEmptyEn => tr('registerErrorPasswordEmptyEn');
  static String get registerCodeSent => tr('registerCodeSent');
  static String get registerCodeSentEn => tr('registerCodeSentEn');
  static String get registerErrorCodeEmpty => tr('registerErrorCodeEmpty');
  static String get registerErrorCodeEmptyEn => tr('registerErrorCodeEmptyEn');
  static String get registerVerifySuccess => tr('registerVerifySuccess');
  static String get registerVerifySuccessEn => tr('registerVerifySuccessEn');

  // Register Success Screen
  static String get registerSuccessTitle => tr('registerSuccessTitle');
  static String get registerSuccessSubTitle1 =>
      tr('registerSuccessSubTitle1');
  static String get registerSuccessSubTitle2 => tr('registerSuccessSubTitle2');
  static String get registerSuccessButton => tr('registerSuccessButton');
  static String get registerSuccessPrivacy => tr('registerSuccessPrivacy');

  // Profile User Screen
  static String get profileScreenTitle => tr('profileScreenTitle');
  static String get profileScreenSubtitle => tr('profileScreenSubtitle');
  static String get profileCompletedOrders => tr('profileCompletedOrders');
  static String get profileInProgress => tr('profileInProgress');
  static String get profileLoyaltyPoints => tr('profileLoyaltyPoints');
  static String get profileSectionAccount => tr('profileSectionAccount');
  static String get profileEditTitle => tr('profileEditTitle');
  static String get profileEditSubtitle => tr('profileEditSubtitle');
  static String get profileChangePasswordTitle => tr('profileChangePasswordTitle');
  static String get profileChangePasswordSubtitle => tr('profileChangePasswordSubtitle');
  static String get profileManageAddressesTitle => tr('profileManageAddressesTitle');
  static String get profileManageAddressesSubtitle => tr('profileManageAddressesSubtitle');
  static String get profileSectionAppInfo => tr('profileSectionAppInfo');
  static String get profileAboutTitle => tr('profileAboutTitle');
  static String get profileAboutSubtitle => tr('profileAboutSubtitle');
  static String get profileFaqTitle => tr('profileFaqTitle');
  static String get profileFaqSubtitle => tr('profileFaqSubtitle');
  static String get profileSupportTitle => tr('profileSupportTitle');
  static String get profilePrivacyTitle => tr('profilePrivacyTitle');
  static String get profilePrivacySubtitle => tr('profilePrivacySubtitle');
  static String get profileLogout => tr('profileLogout');
  static String get logoutConfirmTitle => tr('logoutConfirmTitle');
  static String get logoutConfirmSubtitle => tr('logoutConfirmSubtitle');
  static String get logoutConfirmButton => tr('logoutConfirmButton');
  static String get logoutCancelButton => tr('logoutCancelButton');

  // Provider Profile Screen
  static String get providerProfileTitle => tr('providerProfileTitle');
  static String get providerProfileSubtitle => tr('providerProfileSubtitle');
  static String get providerProfileSectionAccount => tr('providerProfileSectionAccount');
  static String get providerProfileEditTitle => tr('providerProfileEditTitle');
  static String get providerProfileEditSubtitle => tr('providerProfileEditSubtitle');
  static String get providerProfileChangePasswordTitle => tr('providerProfileChangePasswordTitle');
  static String get providerProfileChangePasswordSubtitle => tr('providerProfileChangePasswordSubtitle');
  static String get providerProfileManageAddressesTitle => tr('providerProfileManageAddressesTitle');
  static String get providerProfileManageAddressesSubtitle => tr('providerProfileManageAddressesSubtitle');
  static String get providerProfileSectionWork => tr('providerProfileSectionWork');
  static String get providerProfilePortfolioTitle => tr('providerProfilePortfolioTitle');
  static String get providerProfilePortfolioSubtitle => tr('providerProfilePortfolioSubtitle');
  static String get providerProfileSpecializationsTitle => tr('providerProfileSpecializationsTitle');
  static String get providerProfileSpecializationsSubtitle => tr('providerProfileSpecializationsSubtitle');
  static String get providerProfileSectionAppInfo => tr('providerProfileSectionAppInfo');
  static String get providerProfileAboutTitle => tr('providerProfileAboutTitle');
  static String get providerProfileAboutSubtitle => tr('providerProfileAboutSubtitle');
  static String get providerProfileFaqTitle => tr('providerProfileFaqTitle');
  static String get providerProfileFaqSubtitle => tr('providerProfileFaqSubtitle');
  static String get providerProfileSupportTitle => tr('providerProfileSupportTitle');
  static String get providerProfileSupportSubtitle => tr('providerProfileSupportSubtitle');
  static String get providerProfilePrivacyTitle => tr('providerProfilePrivacyTitle');
  static String get providerProfilePrivacySubtitle => tr('providerProfilePrivacySubtitle');
  static String get providerProfileLogout => tr('providerProfileLogout');
  static String get providerProfileRankLabel => tr('providerProfileRankLabel');
  static String get providerProfileFetchError => tr('providerProfileFetchError');

  // Update User Profile Screen
  static String get updateUserProfileTitle => tr('updateUserProfileTitle');
  static String get updateUserProfileSubtitle => tr('updateUserProfileSubtitle');
  static String get updateUserProfileSectionPersonal => tr('updateUserProfileSectionPersonal');
  static String get updateUserProfileNameLabel => tr('updateUserProfileNameLabel');
  static String get updateUserProfileNameHint => tr('updateUserProfileNameHint');
  static String get updateUserProfilePhoneLabel => tr('updateUserProfilePhoneLabel');
  static String get updateUserProfilePhoneDisabledNote => tr('updateUserProfilePhoneDisabledNote');
  static String get updateUserProfileSaveButton => tr('updateUserProfileSaveButton');
  static String get updateUserProfileConfirmTitle => tr('updateUserProfileConfirmTitle');
  static String get updateUserProfileConfirmSubtitle => tr('updateUserProfileConfirmSubtitle');
  static String get updateUserProfileConfirmYes => tr('updateUserProfileConfirmYes');
  static String get updateUserProfileConfirmNo => tr('updateUserProfileConfirmNo');
  static String get updateUserProfileSuccess => tr('updateUserProfileSuccess');
  static String get updateUserProfileSuccessEn => tr('updateUserProfileSuccessEn');
  static String get updateUserProfileErrorNameEmpty => tr('updateUserProfileErrorNameEmpty');
  static String get updateUserProfileErrorNameEmptyEn => tr('updateUserProfileErrorNameEmptyEn');
  static String get updateUserProfileImagePickerTitle => tr('updateUserProfileImagePickerTitle');
  static String get updateUserProfileImageCamera => tr('updateUserProfileImageCamera');
  static String get updateUserProfileImageGallery => tr('updateUserProfileImageGallery');
  static String get updateUserProfileImageCancel => tr('updateUserProfileImageCancel');

  // Auth Footer
  static String get authFooterRememberPassword => tr('authFooterRememberPassword');
  static String get authFooterLogin => tr('authFooterLogin');

  // Choose Account Type Screen
  static String get chooseAccountTitle => tr('chooseAccountTitle');
  static String get chooseAccountSubTitle1 => tr('chooseAccountSubTitle1');
  static String get chooseAccountSubTitleTailor => tr('chooseAccountSubTitleTailor');
  static String get chooseAccountSubTitle2 =>
      tr('chooseAccountSubTitle2');
  static String get chooseAccountSubTitleBuyer => tr('chooseAccountSubTitleBuyer');
  static String get chooseAccountSubTitle3 =>
      tr('chooseAccountSubTitle3');
  static String get chooseAccountCustomerTitle => tr('chooseAccountCustomerTitle');
  static String get chooseAccountCustomerSubTitle =>
      tr('chooseAccountCustomerSubTitle');
  static String get chooseAccountCustomerButton => tr('chooseAccountCustomerButton');
  static String get chooseAccountProviderTitle => tr('chooseAccountProviderTitle');
  static String get chooseAccountProviderSubTitle =>
      tr('chooseAccountProviderSubTitle');
  static String get chooseAccountProviderButton => tr('chooseAccountProviderButton');

  // Provider Register Screen
  static String get providerRegisterTitle => tr('providerRegisterTitle');
  static String get providerRegisterSubTitle => tr('providerRegisterSubTitle');
  static String get providerRegisterKeyword => tr('providerRegisterKeyword');

  // Provider Step 1 - Role Selection
  static String get providerRoleIndependentTitle => tr('providerRoleIndependentTitle');
  static String get providerRoleIndependentSubTitle =>
      tr('providerRoleIndependentSubTitle');
  static String get providerRoleIndependentTag1 => tr('providerRoleIndependentTag1');
  static String get providerRoleIndependentTag2 => tr('providerRoleIndependentTag2');

  static String get providerRoleShopTitle => tr('providerRoleShopTitle');
  static String get providerRoleShopSubTitle =>
      tr('providerRoleShopSubTitle');
  static String get providerRoleShopTag1 => tr('providerRoleShopTag1');
  static String get providerRoleShopTag2 => tr('providerRoleShopTag2');

  static String get providerRoleComprehensiveTitle => tr('providerRoleComprehensiveTitle');
  static String get providerRoleComprehensiveSubTitle =>
      tr('providerRoleComprehensiveSubTitle');
  static String get providerRoleComprehensiveTag1 => tr('providerRoleComprehensiveTag1');
  static String get providerRoleComprehensiveTag2 => tr('providerRoleComprehensiveTag2');

  // Provider Step 2 - Business Details
  static String get providerBusinessDetailsTitle => tr('providerBusinessDetailsTitle');
  static String get providerBusinessDetailsSubTitle =>
      tr('providerBusinessDetailsSubTitle');
  static String get providerBusinessNameLabel => tr('providerBusinessNameLabel');
  static String get providerBusinessNameHint => tr('providerBusinessNameHint');
  static String get providerOwnerNameLabel => tr('providerOwnerNameLabel');
  static String get providerOwnerNameHint => tr('providerOwnerNameHint');
  static String get providerPhoneLabel => tr('providerPhoneLabel');
  static String get providerPhoneHint => tr('providerPhoneHint');
  static String get providerCityLabel => tr('providerCityLabel');
  static String get providerCityHint => tr('providerCityHint');
  static String get providerLocationLabel => tr('providerLocationLabel');
  static String get providerLocationHint => tr('providerLocationHint');
  static String get providerOpenMapButton => tr('providerOpenMapButton');
  static String get providerAddressLabel => tr('providerAddressLabel');
  static String get providerAddressHint => tr('providerAddressHint');

  // Provider Step 3 - Experience & Specializations
  static String get providerExperienceTitle => tr('providerExperienceTitle');
  static String get providerExperienceSubTitle => tr('providerExperienceSubTitle');
  static String get providerYearsLabel => tr('providerYearsLabel');
  static String get providerYearsHint => tr('providerYearsHint');
  static String get providerBioLabel => tr('providerBioLabel');
  static String get providerBioHint => tr('providerBioHint');
  static String get providerSpecializationsLabel => tr('providerSpecializationsLabel');
  static String get providerSpecTagMen => tr('providerSpecTagMen');
  static String get providerSpecTagWomen => tr('providerSpecTagWomen');
  static String get providerSpecTagKids => tr('providerSpecTagKids');
  static String get providerSpecTagWedding => tr('providerSpecTagWedding');
  static String get providerSpecTagTraditional => tr('providerSpecTagTraditional');
  static String get providerSpecTagModern => tr('providerSpecTagModern');

  // Provider Step - Next Step Info
  static String get providerNextStepTitle => tr('providerNextStepTitle');
  static String get providerNextStepDescription =>
      tr('providerNextStepDescription');

  // Provider Buttons
  static String get providerNextButton => tr('providerNextButton');
  static String get providerPreviousButton => tr('providerPreviousButton');
  static String get providerSubmitButton => tr('providerSubmitButton');

  // Provider Success Screen
  static String get providerSuccessTitle => tr('providerSuccessTitle');
  static String get providerSuccessSubTitle =>
      tr('providerSuccessSubTitle');
  static String get providerSuccessButton => tr('providerSuccessButton');

  // Provider Register Validation & Snackbar
  static String get providerRegisterSuccess => tr('providerRegisterSuccess');
  static String get providerErrorSelectRole => tr('providerErrorSelectRole');
  static String get providerErrorBusinessName => tr('providerErrorBusinessName');
  static String get providerErrorOwnerName => tr('providerErrorOwnerName');
  static String get providerErrorPhone => tr('providerErrorPhone');
  static String get providerErrorCity => tr('providerErrorCity');
  static String get providerErrorYears => tr('providerErrorYears');
  static String get providerErrorCategories => tr('providerErrorCategories');
  static String get providerLoadingCategories => tr('providerLoadingCategories');

  // Map Picker
  static String get mapPickerTitle => tr('mapPickerTitle');
  static String get mapPickerConfirm => tr('mapPickerConfirm');
  static String get mapPickerLocationSelected => tr('mapPickerLocationSelected');

  /// Config Strings
  static String get noRouteFound => tr('noRouteFound');

  static String get success => tr('success');

  static String get noContent => tr('noContent');

  static String get badRequest => tr('badRequest');

  static String get forbidden => tr('forbidden');

  static String get unAuthorized => tr('unAuthorized');

  static String get notFound => tr('notFound');

  static String get internalServerError => tr('internalServerError');

  static String get connectTimeOut => tr('connectTimeOut');

  static String get cancel => tr('cancel');

  static String get receiveTimeOut => tr('receiveTimeOut');

  static String get sendTimeOut => tr('sendTimeOut');

  static String get cacheError => tr('cacheError');

  static String get noInternetConnection => tr('noInternetConnection');

  static String get unKnown => tr('unKnown');

  static String get sessionFinished => tr('sessionFinished');

  static String get invalidEmptyEmail => tr('invalidEmptyEmail');

  static String get invalidEmail => tr('invalidEmail');

  static String get doYouWantToChangeIt => tr('doYouWantToChangeIt');

  static String get invalidPasswordLength => tr('invalidEmptyPassword');

  static String get invalidPasswordUpper => tr('invalidPasswordUpper');

  static String get invalidPasswordLower => tr('invalidPasswordLower');

  static String get invalidPasswordDigit => tr('invalidPasswordDigit');

  static String get passwordNotMatch => tr('passwordNotMatch');

  static String get invalidEmptyPhoneNumber => tr('invalidEmptyPhoneNumber');

  static String get invalidEmptyCode => tr('invalidEmptyCode');

  static String get invalidPhoneNumber => tr('invalidPhoneNumber');

  static String get notVerifiedEmail => tr('notVerifiedEmail');

  static String get invalidFullName => tr('invalidFullName');

  static String get sorryFailed => tr('sorryFailed');

  static String get invalidEmptyDateOfBirth => tr('invalidEmptyDateOfBirth');

  static String get invalidEmptyFullName => tr('invalidEmptyFullName');

  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  // Independent Tailor Home Screen
  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get homeGreeting => tr('homeGreeting');
  static String get homeShopName => tr('homeShopName');
  static String get homeTailorRank => tr('homeTailorRank');
  static String get homeTailorRankNew => tr('homeTailorRankNew');

  static String roleLabel(String? role) {
    return switch (role) {
      'comprehensive_tailor' => 'Ø®ÙŠØ§Ø· Ø´Ø§Ù…Ù„',
      'independent_tailor' => 'Ø®ÙŠØ§Ø· Ù…Ø³ØªÙ‚Ù„',
      'shop_owner' => 'ØµØ§Ø­Ø¨ Ù…Ø­Ù„',
      _ => homeTailorRankNew,
    };
  }
  static String get homeVisibilityStatus => tr('homeVisibilityStatus');
  static String get homeVisibilityUnavailable => tr('homeVisibilityUnavailable');
  static String get homeVisibilityAvailable => tr('homeVisibilityAvailable');
  static String get homeVisibilityAvailableSwitch => tr('homeVisibilityAvailableSwitch');
  static String get homeVisibilityUnavailableSwitch => tr('homeVisibilityUnavailableSwitch');
  static String get homeVisibilityNote => tr('homeVisibilityNote');
  static String get homeBalanceTitle => tr('homeBalanceTitle');
  static String get homeBalanceAmount => tr('homeBalanceAmount');
  static String get homeBalanceCurrency => tr('homeBalanceCurrency');
  static String get homeLastLogin => tr('homeLastLogin');
  static String get homeOrdersTitle => tr('homeOrdersTitle');
  static String get homeOrdersSubtitle => tr('homeOrdersSubtitle');
  static String get homeOrdersBadge => tr('homeOrdersBadge');
  static String get homeOffersTitle => tr('homeOffersTitle');
  static String get homeOffersSubtitle => tr('homeOffersSubtitle');
  static String get homeReviewsTitle => tr('homeReviewsTitle');
  static String get homeReviewsSubtitle => tr('homeReviewsSubtitle');

  // Store Tailor Home
  static String get homeStoreProductsTitle    => tr('homeStoreProductsTitle');
  static String get homeStoreProductsSubtitle => tr('homeStoreProductsSubtitle');

  // Manager Products Screen
  static String get managerProductsTitle => tr('managerProductsTitle');
  static String get managerProductsSubtitle => tr('managerProductsSubtitle');
  static String get managerProductsAddButton => tr('managerProductsAddButton');
  static String get managerProductsSearchHint => tr('managerProductsSearchHint');
  static String get managerProductsFilterAll => tr('managerProductsFilterAll');
  static String get managerProductsFilterActive => tr('managerProductsFilterActive');
  static String get managerProductsFilterInactive => tr('managerProductsFilterInactive');
  static String get managerProductsFilterOutOfStock => tr('managerProductsFilterOutOfStock');
  static String get managerProductsStatusActive => tr('managerProductsStatusActive');
  static String get managerProductsStatusInactive => tr('managerProductsStatusInactive');
  static String get managerProductsStatusOutOfStock => tr('managerProductsStatusOutOfStock');
  static String get managerProductsColors => tr('managerProductsColors');
  static String get managerProductsSizes => tr('managerProductsSizes');
  static String get managerProductsStock => tr('managerProductsStock');
  static String get managerProductsOrders => tr('managerProductsOrders');
  static String get managerProductsDelivery => tr('managerProductsDelivery');
  static String get managerProductsEdit => tr('managerProductsEdit');
  static String get managerProductsPause => tr('managerProductsPause');
  static String get managerProductsResume => tr('managerProductsResume');
  static String get managerProductsDelete => tr('managerProductsDelete');
  static String get managerProductsNoProducts => tr('managerProductsNoProducts');
  static String get managerProductsCurrency => tr('managerProductsCurrency');

  // Manager Products â€” Action loading overlay
  static String get managerProductsActionLoading => tr('managerProductsActionLoading');

  // Manager Products â€” Delete dialog
  static String get managerProductsDeleteDialogTitle    => tr('managerProductsDeleteDialogTitle');
  static String get managerProductsDeleteDialogSubtitle => tr('managerProductsDeleteDialogSubtitle');
  static String get managerProductsDeleteDialogConfirm  => tr('managerProductsDeleteDialogConfirm');
  static String get managerProductsDeleteDialogCancel   => tr('managerProductsDeleteDialogCancel');
  static String get managerProductsDeleteSuccess        => tr('managerProductsDeleteSuccess');
  static String get managerProductsDeleteSuccessEn      => tr('managerProductsDeleteSuccessEn');

  // Manager Products â€” Activate dialog
  static String get managerProductsActivateDialogTitle    => tr('managerProductsActivateDialogTitle');
  static String get managerProductsActivateDialogSubtitle => tr('managerProductsActivateDialogSubtitle');
  static String get managerProductsActivateDialogConfirm  => tr('managerProductsActivateDialogConfirm');
  static String get managerProductsActivateDialogCancel   => tr('managerProductsActivateDialogCancel');
  static String get managerProductsActivateSuccess        => tr('managerProductsActivateSuccess');
  static String get managerProductsActivateSuccessEn      => tr('managerProductsActivateSuccessEn');

  // Manager Products â€” Cancel/Pause dialog
  static String get managerProductsCancelDialogTitle    => tr('managerProductsCancelDialogTitle');
  static String get managerProductsCancelDialogSubtitle => tr('managerProductsCancelDialogSubtitle');
  static String get managerProductsCancelDialogConfirm  => tr('managerProductsCancelDialogConfirm');
  static String get managerProductsCancelDialogCancel   => tr('managerProductsCancelDialogCancel');
  static String get managerProductsCancelSuccess        => tr('managerProductsCancelSuccess');
  static String get managerProductsCancelSuccessEn      => tr('managerProductsCancelSuccessEn');

  // â”€â”€ Add/Edit Product Form â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get addProductTitle => tr('addProductTitle');
  static String get addProductSubtitle => tr('addProductSubtitle');
  static String get editProductTitle => tr('editProductTitle');
  static String get editProductSubtitle => tr('editProductSubtitle');
  // Section titles
  static String get addProductSecImages => tr('addProductSecImages');
  static String get addProductSecBasicInfo => tr('addProductSecBasicInfo');
  static String get addProductSecName => tr('addProductSecName');
  static String get addProductSecCategory => tr('addProductSecCategory');
  static String get addProductSecPrice => tr('addProductSecPrice');
  static String get addProductSecColors => tr('addProductSecColors');
  static String get addProductSecSizes => tr('addProductSecSizes');
  static String get addProductSecStock => tr('addProductSecStock');
  static String get addProductSecDescription => tr('addProductSecDescription');
  // Images
  static String get addProductImagesTip => tr('addProductImagesTip');
  static String get addProductAddImage => tr('addProductAddImage');
  // Name
  static String get addProductNameHint => tr('addProductNameHint');
  // Category
  static String get addProductCategoryHint => tr('addProductCategoryHint');
  static String get addProductNoCategoriesYet => tr('addProductNoCategoriesYet');
  // Price
  static String get addProductPriceLabel => tr('addProductPriceLabel');
  static String get addProductPriceHint => tr('addProductPriceHint');
  static String get addProductOriginalPrice => tr('addProductOriginalPrice');
  static String get addProductOriginalPriceHint => tr('addProductOriginalPriceHint');
  // Colors
  static String get addProductColorsLabel => tr('addProductColorsLabel');
  static String get addProductAddCustomColor => tr('addProductAddCustomColor');
  static String get addProductColorPickerTitle => tr('addProductColorPickerTitle');
  static String get addProductColorNameHint => tr('addProductColorNameHint');
  static String get addProductColorAdd => tr('addProductColorAdd');
  static String get addProductColorWheelTab => tr('addProductColorWheelTab');
  static String get addProductColorCameraTab => tr('addProductColorCameraTab');
  static String get addProductTakePhoto => tr('addProductTakePhoto');
  static String get addProductPickFromGallery => tr('addProductPickFromGallery');
  static String get addProductTapToPickColor => tr('addProductTapToPickColor');
  static String get addProductColorNameRequired => tr('addProductColorNameRequired');
  static String get addProductColorNameRequiredEn => tr('addProductColorNameRequiredEn');
  // Sizes
  static String get addProductSizesLabel => tr('addProductSizesLabel');
  // Stock
  static String get addProductStockLabel => tr('addProductStockLabel');
  static String get addProductPieces => tr('addProductPieces');
  // Description & features
  static String get addProductDescLabel => tr('addProductDescLabel');
  static String get addProductDescHint => tr('addProductDescHint');
  static String get addProductFeaturesLabel => tr('addProductFeaturesLabel');
  static String get addProductFeaturesHint => tr('addProductFeaturesHint');
  static String get addProductCareLabel => tr('addProductCareLabel');
  static String get addProductCareHint => tr('addProductCareHint');
  static String get addProductDeliveryMin => tr('addProductDeliveryMin');
  static String get addProductDeliveryMax => tr('addProductDeliveryMax');
  static String get addProductAddItem => tr('addProductAddItem');
  // Submit
  static String get addProductSubmitAdd => tr('addProductSubmitAdd');
  static String get addProductSubmitEdit => tr('addProductSubmitEdit');
  // Validation
  static String get addProductValidationImages => tr('addProductValidationImages');
  static String get addProductValidationImagesEn => tr('addProductValidationImagesEn');
  static String get addProductValidationName => tr('addProductValidationName');
  static String get addProductValidationNameEn => tr('addProductValidationNameEn');
  static String get addProductValidationCategory => tr('addProductValidationCategory');
  static String get addProductValidationCategoryEn => tr('addProductValidationCategoryEn');
  static String get addProductValidationPrice => tr('addProductValidationPrice');
  static String get addProductValidationPriceEn => tr('addProductValidationPriceEn');
  static String get addProductValidationColors => tr('addProductValidationColors');
  static String get addProductValidationColorsEn => tr('addProductValidationColorsEn');
  static String get addProductValidationSizes => tr('addProductValidationSizes');
  static String get addProductValidationSizesEn => tr('addProductValidationSizesEn');
  static String get addProductValidationNameAr => tr('addProductValidationNameAr');
  static String get addProductValidationNameArEn => tr('addProductValidationNameArEn');
  static String get addProductValidationVariantQty => tr('addProductValidationVariantQty');
  static String get addProductValidationVariantQtyEn => tr('addProductValidationVariantQtyEn');
  // Name fields
  static String get addProductNameAr => tr('addProductNameAr');
  static String get addProductNameArHint => tr('addProductNameArHint');
  static String get addProductNameEn => tr('addProductNameEn');
  static String get addProductNameEnHint => tr('addProductNameEnHint');
  static String get addProductNameUr => tr('addProductNameUr');
  static String get addProductNameUrHint => tr('addProductNameUrHint');
  static String get addProductTranslate => tr('addProductTranslate');
  static String get addProductTranslating => tr('addProductTranslating');
  // Section titles
  static String get addProductSecDelivery => tr('addProductSecDelivery');
  static String get addProductSecCareInstructions => tr('addProductSecCareInstructions');
  static String get addProductSecFeatures => tr('addProductSecFeatures');
  static String get addProductSecVariants => tr('addProductSecVariants');
  static String get addProductSecExistingVariants => tr('addProductSecExistingVariants');
  // Variant
  static String get addProductVariantColor => tr('addProductVariantColor');
  static String get addProductVariantSize => tr('addProductVariantSize');
  static String get addProductVariantQty => tr('addProductVariantQty');
  static String get addProductAddVariant => tr('addProductAddVariant');
  static String get addProductEditVariant => tr('addProductEditVariant');
  static String get addProductDeleteVariant => tr('addProductDeleteVariant');
  static String get addProductVariantAdded => tr('addProductVariantAdded');
  static String get addProductVariantAddedEn => tr('addProductVariantAddedEn');
  static String get addProductVariantUpdated => tr('addProductVariantUpdated');
  static String get addProductVariantUpdatedEn => tr('addProductVariantUpdatedEn');
  static String get addProductVariantDeleted => tr('addProductVariantDeleted');
  static String get addProductVariantDeletedEn => tr('addProductVariantDeletedEn');
  // Success
  static String get addProductCreatedSuccess => tr('addProductCreatedSuccess');
  static String get addProductCreatedSuccessEn => tr('addProductCreatedSuccessEn');
  static String get addProductUpdatedSuccess => tr('addProductUpdatedSuccess');
  static String get addProductUpdatedSuccessEn => tr('addProductUpdatedSuccessEn');
  // Delivery
  static String get addProductDeliveryDay => tr('addProductDeliveryDay');

  // Common
  static String get retry => tr('retry');

  // Notification Screen
  static String get notificationScreenTitle                  => tr('notificationScreenTitle');
  static String get notificationScreenSubtitle               => tr('notificationScreenSubtitle');
  static String get notificationNoNotifications              => tr('notificationNoNotifications');
  static String get notificationNoNotificationsDescription   => tr('notificationNoNotificationsDescription');
  static String get homeNavHome => tr('homeNavHome');
  static String get homeNavOrders => tr('homeNavOrders');
  static String get homeNavMessages => tr('homeNavMessages');
  static String get homeNavProfile => tr('homeNavProfile');

  /// Suggested Requests Screen
  static String get suggestedRequestsTitle => tr('suggestedRequestsTitle');
  static String get suggestedRequestsSubtitle => tr('suggestedRequestsSubtitle');
  static String get suggestedRequestsOffers => tr('suggestedRequestsOffers');
  static String get suggestedRequestsBudget => tr('suggestedRequestsBudget');
  static String get suggestedRequestsDuration => tr('suggestedRequestsDuration');
  static String get suggestedRequestsDays => tr('suggestedRequestsDays');
  static String get suggestedRequestsSubmitOffer => tr('suggestedRequestsSubmitOffer');
  static String get suggestedRequestsCurrency => tr('suggestedRequestsCurrency');

  /// Submit Offer Bottom Sheet
  static String get submitOfferTitle => tr('submitOfferTitle');
  static String get submitOfferPriceLabel => tr('submitOfferPriceLabel');
  static String get submitOfferPriceHint => tr('submitOfferPriceHint');
  static String get submitOfferBudgetRange => tr('submitOfferBudgetRange');
  static String get submitOfferDurationLabel => tr('submitOfferDurationLabel');
  static String get submitOfferDurationHint => tr('submitOfferDurationHint');
  static String get submitOfferDeliveryNote => tr('submitOfferDeliveryNote');
  static String get submitOfferDetailsLabel => tr('submitOfferDetailsLabel');
  static String get submitOfferDetailsHint => tr('submitOfferDetailsHint');
  static String get submitOfferButton => tr('submitOfferButton');
  static String get submitOfferSuccess => tr('submitOfferSuccess');
  static String get submitOfferErrorPrice => tr('submitOfferErrorPrice');
  static String get submitOfferErrorDuration => tr('submitOfferErrorDuration');

  /// Order Tracking Screen
  static String get orderTrackingTitle => tr('orderTrackingTitle');
  static String get orderTrackingFilterAll => tr('orderTrackingFilterAll');
  static String get orderTrackingFilterReady => tr('orderTrackingFilterReady');
  static String get orderTrackingFilterInProgress => tr('orderTrackingFilterInProgress');
  static String get orderTrackingFilterReadyForDelivery => tr('orderTrackingFilterReadyForDelivery');
  static String get orderTrackingStatusInProgress => tr('orderTrackingStatusInProgress');
  static String get orderTrackingStatusReady => tr('orderTrackingStatusReady');
  static String get orderTrackingStatusReadyForDelivery => tr('orderTrackingStatusReadyForDelivery');
  static String get orderTrackingPaid => tr('orderTrackingPaid');
  static String get orderTrackingDetails => tr('orderTrackingDetails');
  static String get orderTrackingOrderDate => tr('orderTrackingOrderDate');
  static String get orderTrackingDeadline => tr('orderTrackingDeadline');
  static String get orderTrackingChat => tr('orderTrackingChat');
  static String get orderTrackingUpdateReadyForDelivery => tr('orderTrackingUpdateReadyForDelivery');
  static String get orderTrackingStartExecution => tr('orderTrackingStartExecution');
  static String get orderTrackingUpdateInDelivery => tr('orderTrackingUpdateInDelivery');
  static String get orderTrackingDeadlineWarning => tr('orderTrackingDeadlineWarning');
  static String get orderTrackingDaysRemaining => tr('orderTrackingDaysRemaining');
  static String get orderTrackingDaysOnly => tr('orderTrackingDaysOnly');
  static String get orderTrackingCurrency => tr('orderTrackingCurrency');

  // â”€â”€ Store Order Tracking â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get storeOrderTitle => tr('storeOrderTitle');
  static String get storeOrderFilterNew => tr('storeOrderFilterNew');
  static String get storeOrderFilterInPrep => tr('storeOrderFilterInPrep');
  static String get storeOrderFilterReady => tr('storeOrderFilterReady');
  static String get storeOrderStatusNew => tr('storeOrderStatusNew');
  static String get storeOrderStatusInPrep => tr('storeOrderStatusInPrep');
  static String get storeOrderStatusReady => tr('storeOrderStatusReady');
  static String get storeOrderActionStartPrep => tr('storeOrderActionStartPrep');
  static String get storeOrderActionMarkReady => tr('storeOrderActionMarkReady');
  static String get storeOrderViewDetails => tr('storeOrderViewDetails');
  static String get storeOrderDetailTitle => tr('storeOrderDetailTitle');
  static String get storeOrderCustomerSection => tr('storeOrderCustomerSection');
  static String get storeOrderProductsSection => tr('storeOrderProductsSection');
  static String get storeOrderTotalLabel => tr('storeOrderTotalLabel');
  static String get storeOrderDeliveryAddress => tr('storeOrderDeliveryAddress');
  static String get storeOrderUpdateStatusTo => tr('storeOrderUpdateStatusTo');
  static String get storeOrderChat => tr('storeOrderChat');
  static String get storeOrderDate => tr('storeOrderDate');
  static String get storeOrderNoOrders => tr('storeOrderNoOrders');
  static String get storeOrderQuantity => tr('storeOrderQuantity');

  /// My Offers Screen
  static String get myOffersTitle => tr('myOffersTitle');
  static String get myOffersFilterAll => tr('myOffersFilterAll');
  static String get myOffersFilterUnderReview => tr('myOffersFilterUnderReview');
  static String get myOffersFilterAccepted => tr('myOffersFilterAccepted');
  static String get myOffersFilterRejected => tr('myOffersFilterRejected');
  static String get myOffersStatusAccepted => tr('myOffersStatusAccepted');
  static String get myOffersStatusUnderReview => tr('myOffersStatusUnderReview');
  static String get myOffersStatusRejected => tr('myOffersStatusRejected');
  static String get myOffersOrderRef => tr('myOffersOrderRef');
  static String get myOffersOfferPrice => tr('myOffersOfferPrice');
  static String get myOffersExecutionDuration => tr('myOffersExecutionDuration');
  static String get myOffersDetails => tr('myOffersDetails');
  static String get myOffersBudget => tr('myOffersBudget');
  static String get myOffersCompetingOffers => tr('myOffersCompetingOffers');
  static String get myOffersDays => tr('myOffersDays');
  static String get myOffersCurrency => tr('myOffersCurrency');
  static String get myOffersTrackOrders => tr('myOffersTrackOrders');
  static String get myOffersEditOffer => tr('myOffersEditOffer');
  static String get myOffersWithdrawOffer => tr('myOffersWithdrawOffer');
  static String get myOffersDelete => tr('myOffersDelete');
  static String get myOffersNoOffers => tr('myOffersNoOffers');
  static String get myOffersConfirmWithdrawTitle => tr('myOffersConfirmWithdrawTitle');
  static String get myOffersConfirmWithdrawBody => tr('myOffersConfirmWithdrawBody');
  static String get myOffersConfirmDeleteTitle => tr('myOffersConfirmDeleteTitle');
  static String get myOffersConfirmDeleteBody => tr('myOffersConfirmDeleteBody');
  static String get myOffersConfirmYes => tr('myOffersConfirmYes');
  static String get myOffersConfirmNo => tr('myOffersConfirmNo');
  // Edit offer bottom sheet
  static String get editOfferTitle => tr('editOfferTitle');
  static String get editOfferSubmit => tr('editOfferSubmit');
  // Order detail screen
  static String get orderDetailTitle => tr('orderDetailTitle');
  static String get orderDetailProductName => tr('orderDetailProductName');
  static String get orderDetailDescription => tr('orderDetailDescription');
  static String get orderDetailSpecialRequests => tr('orderDetailSpecialRequests');
  static String get orderDetailFabricType => tr('orderDetailFabricType');
  static String get orderDetailBudget => tr('orderDetailBudget');
  static String get orderDetailDeliveryDate => tr('orderDetailDeliveryDate');
  static String get orderDetailImages => tr('orderDetailImages');
  static String get orderDetailOffersCount => tr('orderDetailOffersCount');

  /// Customer Reviews Screen
  static String get reviewsScreenTitle => tr('reviewsScreenTitle');
  static String get reviewsScreenSubtitle => tr('reviewsScreenSubtitle');

  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  // Wallet Screen
  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get walletScreenTitle => tr('walletScreenTitle');
  static String get walletScreenSubTitle => tr('walletScreenSubTitle');
  static String get walletCurrentBalance => tr('walletCurrentBalance');
  static String get walletPendingBalance => tr('walletPendingBalance');
  static String get walletWithdrawableBalance => tr('walletWithdrawableBalance');
  static String get walletWithdrawButton => tr('walletWithdrawButton');
  static String get walletTransactionsTitle => tr('walletTransactionsTitle');
  static String get walletNoTransactions => tr('walletNoTransactions');
  static String get walletNoTransactionsDescription => tr('walletNoTransactionsDescription');
  static String get walletTransactionCompleted => tr('walletTransactionCompleted');
  static String get walletTransactionPending => tr('walletTransactionPending');
  static String get walletTransactionCancelled => tr('walletTransactionCancelled');
  static String get walletTransactionApproved => tr('walletTransactionApproved');
  static String get walletBankAccountButton => tr('walletBankAccountButton');
  static String get walletWithdrawSuccess => tr('walletWithdrawSuccess');
  static String get walletWithdrawSuccessEn => tr('walletWithdrawSuccessEn');
  static String get walletBankAccountAddSuccess => tr('walletBankAccountAddSuccess');
  static String get walletBankAccountAddSuccessEn => tr('walletBankAccountAddSuccessEn');
  static String get walletBankAccountUpdateSuccess => tr('walletBankAccountUpdateSuccess');
  static String get walletBankAccountUpdateSuccessEn => tr('walletBankAccountUpdateSuccessEn');

  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  // Withdraw Request Screen
  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get withdrawRequestTitle => tr('withdrawRequestTitle');
  static String get withdrawRequestSubtitle => tr('withdrawRequestSubtitle');
  static String get withdrawRequestCardTitle => tr('withdrawRequestCardTitle');
  static String get withdrawRequestCardSubtitle => tr('withdrawRequestCardSubtitle');
  static String get withdrawRequestAmountLabel => tr('withdrawRequestAmountLabel');
  static String get withdrawRequestMaxLimit => tr('withdrawRequestMaxLimit');
  static String get withdrawRequestNotesLabel => tr('withdrawRequestNotesLabel');
  static String get withdrawRequestNotesHint => tr('withdrawRequestNotesHint');
  static String get withdrawRequestBankAccountLabel => tr('withdrawRequestBankAccountLabel');
  static String get withdrawRequestChangeAccount => tr('withdrawRequestChangeAccount');
  static String get withdrawRequestConfirmButton => tr('withdrawRequestConfirmButton');
  static String get withdrawRequestProcessingTime => tr('withdrawRequestProcessingTime');
  static String get withdrawRequestConfirmDialogTitle => tr('withdrawRequestConfirmDialogTitle');
  static String get withdrawRequestConfirmDialogSubtitle => tr('withdrawRequestConfirmDialogSubtitle');
  static String get withdrawRequestConfirmDialogConfirm => tr('withdrawRequestConfirmDialogConfirm');
  static String get withdrawRequestConfirmDialogCancel => tr('withdrawRequestConfirmDialogCancel');
  static String get withdrawRequestNoBankAccount => tr('withdrawRequestNoBankAccount');
  static String get withdrawRequestInvalidAmount => tr('withdrawRequestInvalidAmount');
  static String get withdrawRequestAmountExceedsLimit => tr('withdrawRequestAmountExceedsLimit');
  static String get currencySymbol => tr('currencySymbol');

  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  // Add Bank Account Screen
  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get addBankAccountFormTitle => tr('addBankAccountFormTitle');
  static String get addBankAccountFormSubTitle => tr('addBankAccountFormSubTitle');
  static String get addBankAccountFormSub1 => tr('addBankAccountFormSub1');
  static String get addBankAccountFormHint1 => tr('addBankAccountFormHint1');
  static String get addBankAccountFormSub2 => tr('addBankAccountFormSub2');
  static String get addBankAccountFormHint2 => tr('addBankAccountFormHint2');
  static String get addBankAccountFormSub3 => tr('addBankAccountFormSub3');
  static String get addBankAccountFormHint3 => tr('addBankAccountFormHint3');
  static String get addBankAccountFormSub4 => tr('addBankAccountFormSub4');
  static String get addBankAccountFormHint4 => tr('addBankAccountFormHint4');
  static String get addBankAccountFormButton => tr('addBankAccountFormButton');
  static String get addBankAccountConfirmTitle => tr('addBankAccountConfirmTitle');
  static String get addBankAccountConfirmSubtitle => tr('addBankAccountConfirmSubtitle');
  static String get addBankAccountConfirmButton => tr('addBankAccountConfirmButton');
  static String get addBankAccountCancelButton => tr('addBankAccountCancelButton');

  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  // Chat / Conversations Screen
  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get chatConversationsTitle => tr('chatConversationsTitle');
  static String get chatConversationsCount => tr('chatConversationsCount');
  static String get chatSearchHint => tr('chatSearchHint');
  static String get chatActiveNow => tr('chatActiveNow');
  static String get chatOfflineNow => tr('chatOfflineNow');
  static String get chatWriteMessage => tr('chatWriteMessage');
  static String get chatCustomOffer => tr('chatCustomOffer');
  static String get chatNoConversations => tr('chatNoConversations');
  static String get chatNoConversationsDesc => tr('chatNoConversationsDesc');

  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  // Chat Detail Screen
  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get chatDetailTitle => tr('chatDetailTitle');

  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  // Custom Offer in Chat
  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get chatOfferPrice => tr('chatOfferPrice');
  static String get chatOfferDuration => tr('chatOfferDuration');
  static String get chatOfferDays => tr('chatOfferDays');
  static String get chatOfferCurrency => tr('chatOfferCurrency');
  static String get chatOfferAdditions => tr('chatOfferAdditions');
  static String get chatOfferEdit => tr('chatOfferEdit');
  static String get chatOfferCancel => tr('chatOfferCancel');

  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  // User Chat â€” Offer Actions
  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get chatUserOfferAccept => tr('chatUserOfferAccept');
  static String get chatUserOfferDecline => tr('chatUserOfferDecline');
  static String get chatUserOfferAccepted => tr('chatUserOfferAccepted');
  static String get chatUserOfferDeclined => tr('chatUserOfferDeclined');
  static String get chatUserAcceptDialogTitle => tr('chatUserAcceptDialogTitle');
  static String get chatUserAcceptDialogSubtitle => tr('chatUserAcceptDialogSubtitle');
  static String get chatUserAcceptDialogConfirm => tr('chatUserAcceptDialogConfirm');
  static String get chatUserAcceptDialogCancel => tr('chatUserAcceptDialogCancel');
  static String get chatUserDeclineDialogTitle => tr('chatUserDeclineDialogTitle');
  static String get chatUserDeclineDialogSubtitle => tr('chatUserDeclineDialogSubtitle');
  static String get chatUserDeclineDialogConfirm => tr('chatUserDeclineDialogConfirm');
  static String get chatUserDeclineDialogCancel => tr('chatUserDeclineDialogCancel');

  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  // Add Custom Offer Screen
  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get addCustomOfferAppBarTitle => tr('addCustomOfferAppBarTitle');
  static String get addCustomOfferAppBarSubtitle => tr('addCustomOfferAppBarSubtitle');
  static String get addCustomOfferCardTitle => tr('addCustomOfferCardTitle');
  static String get addCustomOfferCardSubtitle => tr('addCustomOfferCardSubtitle');
  static String get addCustomOfferTitleLabel => tr('addCustomOfferTitleLabel');
  static String get addCustomOfferTitleHint => tr('addCustomOfferTitleHint');
  static String get addCustomOfferDescLabel => tr('addCustomOfferDescLabel');
  static String get addCustomOfferDescHint => tr('addCustomOfferDescHint');
  static String get addCustomOfferAmountLabel => tr('addCustomOfferAmountLabel');
  static String get addCustomOfferAmountHint => tr('addCustomOfferAmountHint');
  static String get addCustomOfferAdditionsLabel => tr('addCustomOfferAdditionsLabel');
  static String get addCustomOfferAdditionsNote => tr('addCustomOfferAdditionsNote');
  static String get addCustomOfferSendButton => tr('addCustomOfferSendButton');
  static String get addCustomOfferConfirmTitle => tr('addCustomOfferConfirmTitle');
  static String get addCustomOfferConfirmSubtitle => tr('addCustomOfferConfirmSubtitle');
  static String get addCustomOfferConfirmButton => tr('addCustomOfferConfirmButton');
  static String get addCustomOfferCancelButton => tr('addCustomOfferCancelButton');

  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  // My Orders â€” User Screen
  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get myOrdersTitle              => tr('myOrdersTitle');
  static String get myOrdersFilterAll          => tr('myOrdersFilterAll');
  static String get myOrdersFilterWaiting      => tr('myOrdersFilterWaiting');
  static String get myOrdersFilterInProgress   => tr('myOrdersFilterInProgress');
  static String get myOrdersFilterReady        => tr('myOrdersFilterReady');
  static String get myOrdersFilterCompleted    => tr('myOrdersFilterCompleted');

  // Order type badges
  static String get myOrdersTypeCustom         => tr('myOrdersTypeCustom');
  static String get myOrdersTypeDirect         => tr('myOrdersTypeDirect');
  static String get myOrdersTypeReady          => tr('myOrdersTypeReady');

  // Status labels
  static String get myOrdersStatusWaiting      => tr('myOrdersStatusWaiting');
  static String get myOrdersStatusHasOffers    => tr('myOrdersStatusHasOffers');
  static String get myOrdersStatusInProgress   => tr('myOrdersStatusInProgress');
  static String get myOrdersStatusReady        => tr('myOrdersStatusReady');
  static String get myOrdersStatusCompleted    => tr('myOrdersStatusCompleted');

  // Card meta
  static String get myOrdersCurrency           => tr('myOrdersCurrency');
  static String get myOrdersPiecesLabel        => tr('myOrdersPiecesLabel');
  static String get myOrdersDateLabel          => tr('myOrdersDateLabel');
  static String get myOrdersDeadlineLabel      => tr('myOrdersDeadlineLabel');
  static String get myOrdersDetailsBtn         => tr('myOrdersDetailsBtn');
  static String get myOrdersChatBtn            => tr('myOrdersChatBtn');
  static String get myOrdersEmpty              => tr('myOrdersEmpty');
  static String get myOrdersOffersCount        => tr('myOrdersOffersCount');

  // â”€â”€ Submitted Offers Screen â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get submittedOffersTitle          => tr('submittedOffersTitle');
  static String get submittedOffersSubtitle       => tr('submittedOffersSubtitle');
  static String get submittedOffersBannerCount    => tr('submittedOffersBannerCount');
  static String get submittedOffersBannerHint     => tr('submittedOffersBannerHint');
  static String get submittedOffersAvailable      => tr('submittedOffersAvailable');
  static String get submittedOffersBusy           => tr('submittedOffersBusy');
  static String get submittedOffersDuration       => tr('submittedOffersDuration');
  static String get submittedOffersDays           => tr('submittedOffersDays');
  static String get submittedOffersPrice          => tr('submittedOffersPrice');
  static String get submittedOffersCurrency       => tr('submittedOffersCurrency');
  static String get submittedOffersSamples        => tr('submittedOffersSamples');
  static String get submittedOffersRepliedAgo     => tr('submittedOffersRepliedAgo');
  static String get submittedOffersViewProfile    => tr('submittedOffersViewProfile');
  static String get submittedOffersAccept         => tr('submittedOffersAccept');
  static String get submittedOffersUnavailable    => tr('submittedOffersUnavailable');
  static String get submittedOffersEmpty          => tr('submittedOffersEmpty');
  static String get submittedOffersOrders         => tr('submittedOffersOrders');
  static String get submittedOffersBusyWarning    => tr('submittedOffersBusyWarning');
  static String get submittedOffersConfirm        => tr('submittedOffersConfirm');

  // â”€â”€ Order Details Screen â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get orderDetailsTitle             => tr('orderDetailsTitle');
  static String get orderDetailsOrderNumberPrefix => tr('orderDetailsOrderNumberPrefix');
  static String get orderDetailsOrderIdLabel      => tr('orderDetailsOrderIdLabel');
  static String get orderDetailsDirectBadge       => tr('orderDetailsDirectBadge');
  static String get orderDetailsCustomBadge       => tr('orderDetailsCustomBadge');
  static String get orderDetailsReadyBadge        => tr('orderDetailsReadyBadge');
  static String get orderDetailsCurrentStatus     => tr('orderDetailsCurrentStatus');
  static String get orderDetailsTrackingNo        => tr('orderDetailsTrackingNo');
  static String get orderDetailsOrderDate         => tr('orderDetailsOrderDate');
  static String get orderDetailsDeliveryDate      => tr('orderDetailsDeliveryDate');
  static String get orderDetailsTabDetails        => tr('orderDetailsTabDetails');
  static String get orderDetailsTabTracking       => tr('orderDetailsTabTracking');
  // â€” Product section
  static String get orderDetailsProductSection    => tr('orderDetailsProductSection');
  static String get orderDetailsFabricLabel       => tr('orderDetailsFabricLabel');
  static String get orderDetailsMeasurementsLabel => tr('orderDetailsMeasurementsLabel');
  static String get orderDetailsTotalPriceLabel   => tr('orderDetailsTotalPriceLabel');
  static String get orderDetailsCurrency          => tr('orderDetailsCurrency');
  static String get orderDetailsPaid              => tr('orderDetailsPaid');
  static String get orderDetailsDescriptionLabel  => tr('orderDetailsDescriptionLabel');
  // â€” Tailor section
  static String get orderDetailsTailorSection     => tr('orderDetailsTailorSection');
  static String get orderDetailsChat              => tr('orderDetailsChat');
  static String get orderDetailsCall              => tr('orderDetailsCall');
  // â€” Tracking section
  static String get orderDetailsTrackingSection   => tr('orderDetailsTrackingSection');
  static String get orderDetailsStepCompleted     => tr('orderDetailsStepCompleted');
  static String get orderDetailsStepCurrent       => tr('orderDetailsStepCurrent');
  static String get orderDetailsStepPending       => tr('orderDetailsStepPending');
  static String get orderDetailsStepsOf           => tr('orderDetailsStepsOf');
  static String get orderDetailsProgressLabel     => tr('orderDetailsProgressLabel');
  // â€” Status labels
  static String get orderDetailsStatusWaiting     => tr('orderDetailsStatusWaiting');
  static String get orderDetailsStatusHasOffers   => tr('orderDetailsStatusHasOffers');
  static String get orderDetailsStatusInProgress  => tr('orderDetailsStatusInProgress');
  static String get orderDetailsStatusReady       => tr('orderDetailsStatusReady');
  static String get orderDetailsStatusShipped     => tr('orderDetailsStatusShipped');
  static String get orderDetailsStatusDelivering  => tr('orderDetailsStatusDelivering');
  static String get orderDetailsStatusCompleted   => tr('orderDetailsStatusCompleted');

  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  // User Home Screen
  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get userHomeWelcomeBack => tr('userHomeWelcomeBack');
  static String get userHomeDefaultUser => tr('userHomeDefaultUser');
  static String get userHomeSearchHint => tr('userHomeSearchHint');
  static String get userHomeLoyaltyLabel => tr('userHomeLoyaltyLabel');
  static String get userHomeLoyaltyPointUnit => tr('userHomeLoyaltyPointUnit');
  static String get userHomeBannerTitle => tr('userHomeBannerTitle');
  static String get userHomeBannerCount => tr('userHomeBannerCount');
  static String get userHomeBannerSubtitle => tr('userHomeBannerSubtitle');
  static String get userHomeCategoryAll => tr('userHomeCategoryAll');
  static String get userHomeCategoryFirst => tr('userHomeCategoryFirst');
  static String get userHomeCategoryFabric => tr('userHomeCategoryFabric');
  static String get userHomeCategoryKandora => tr('userHomeCategoryKandora');
  static String get userHomeCategoryAtelier => tr('userHomeCategoryAtelier');
  static String get userHomeStoresTitle => tr('userHomeStoresTitle');
  static String get userHomeShopsListTitle => tr('userHomeShopsListTitle');
  static String get userHomeRecommendTitle => tr('userHomeRecommendTitle');
  static String get userHomeRecommendSubtitle => tr('userHomeRecommendSubtitle');
  static String get userHomeLatestTitle => tr('userHomeLatestTitle');
  static String get userHomeBestTailorsTitle => tr('userHomeBestTailorsTitle');
  static String get userHomeViewAll => tr('userHomeViewAll');
  static String get userHomeViewDetails => tr('userHomeViewDetails');
  static String get userHomeCurrency => tr('userHomeCurrency');
  static String get userHomeNavHome     => tr('navHome');
  static String get userHomeNavOrders   => tr('navOrders');
  static String get userHomeNavStore    => tr('navShops');
  static String get userHomeNavMessages => tr('navMessages');

  static String get homeCustomOfferTitle => tr('homeCustomOfferTitle');
  static String get homeCustomOfferSubtitle =>
      tr('homeCustomOfferSubtitle');

  // -- Home Map Card --
  static String get homeMapAvailableTailorsTitle => tr('homeMapAvailableTailorsTitle');
  static String get homeMapTailorCountSuffix => tr('homeMapTailorCountSuffix');

  // -- Products Grid --
  static String get userHomeLatestProductsTitle => tr('userHomeLatestProductsTitle');
  static String get productBestSellerLabel => tr('productBestSellerLabel');

  // -- Store Page --
  static String get storeTitle => tr('storeTitle');
  static String get storeSearchHint => tr('storeSearchHint');
  static String get storeCategoryAll => tr('storeCategoryAll');
  static String get storeCategoryAbaya => tr('storeCategoryAbaya');
  static String get storeCategoryKandora => tr('storeCategoryKandora');
  static String get storeCategoryFabric => tr('storeCategoryFabric');
  static String get storeCategoryAccessories => tr('storeCategoryAccessories');
  static String get storeResultsCount => tr('storeResultsCount');
  static String get storeSortLabel => tr('storeSortLabel');
  static String get storeSortPopular => tr('storeSortPopular');
  static String get storeSortNewest => tr('storeSortNewest');
  static String get storeSortPriceLow => tr('storeSortPriceLow');
  static String get storeSortPriceHigh => tr('storeSortPriceHigh');
  static String get storeEmptyTitle => tr('storeEmptyTitle');
  static String get storeEmptySubtitle => tr('storeEmptySubtitle');

  // -- Best Selling Stores Section --
  static String get bestSellingStoresTitle => tr('bestSellingStoresTitle');
  static String get bestSellingStoreProducts => tr('bestSellingStoreProducts');
  static String get bestSellingStoreProductCount => tr('bestSellingStoreProductCount');
  static String get bestSellingStoreBrowseAll => tr('bestSellingStoreBrowseAll');

  // â”€â”€ Details Shop Screen â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get detailsShopTitle => tr('detailsShopTitle');
  static String get detailsShopOpen => tr('detailsShopOpen');
  static String get detailsShopClosed => tr('detailsShopClosed');
  static String get detailsShopProductsStat => tr('detailsShopProductsStat');
  static String get detailsShopOrdersStat => tr('detailsShopOrdersStat');
  static String get detailsShopRatingStat => tr('detailsShopRatingStat');
  static String get detailsShopSpecializations => tr('detailsShopSpecializations');
  static String get detailsShopMemberSince => tr('detailsShopMemberSince');
  static String get detailsShopContact => tr('detailsShopContact');
  static String get detailsShopProductsTitle => tr('detailsShopProductsTitle');
  static String get detailsShopAbout => tr('detailsShopAbout');
  static String get detailsShopAllProducts => tr('detailsShopAllProducts');
  static String get detailsShopNoProducts => tr('detailsShopNoProducts');
  static String get detailsShopContactSubtitle => tr('detailsShopContactSubtitle');
  static String get detailsShopIdLabel => tr('detailsShopIdLabel');
  static String get detailsShopIdCopied => tr('detailsShopIdCopied');

  // â”€â”€ Cart / Shopping Basket Screen â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get cartTitle => tr('cartTitle');
  static String get cartItemCount => tr('cartItemCount');
  static String get cartStoreProducts => tr('cartStoreProducts');
  static String get cartStoreSubtotal => tr('cartStoreSubtotal');
  static String get cartQuantity => tr('cartQuantity');
  static String get cartColor => tr('cartColor');
  static String get cartSize => tr('cartSize');
  static String get cartDiscountCode => tr('cartDiscountCode');
  static String get cartDiscountHint => tr('cartDiscountHint');
  static String get cartDiscountApply => tr('cartDiscountApply');
  static String get cartOrderSummary => tr('cartOrderSummary');
  static String get cartSubtotal => tr('cartSubtotal');
  static String get cartShippingFees => tr('cartShippingFees');
  static String get cartStoresShipping => tr('cartStoresShipping');
  static String get cartSeparateOrderNote => tr('cartSeparateOrderNote');
  static String get cartOrdersCount => tr('cartOrdersCount');
  static String get cartTotal => tr('cartTotal');
  static String get cartContinueShopping => tr('cartContinueShopping');
  static String get cartCheckout => tr('cartCheckout');
  static String get cartCurrency => tr('cartCurrency');
  static String get cartEmpty => tr('cartEmpty');
  static String get cartEmptyDesc => tr('cartEmptyDesc');
  static String get cartShowDetails => tr('cartShowDetails');
  static String get cartHideDetails => tr('cartHideDetails');
  static String get cartProductCount => tr('cartProductCount');
  static String get cartTotalAmount => tr('cartTotalAmount');

  // -- Best Tailors Section --
  static String get tailorAvailableNow    => tr('tailorAvailableNow');
  static String get tailorUnavailableNow  => tr('tailorUnavailableNow');
  static String get tailorCompletedOrders => tr('tailorCompletedOrders');
  static String get tailorOffersCount     => tr('tailorOffersCount');

  // â”€â”€ Tailor Address Screen â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get tailorAddressTitle          => tr('tailorAddressTitle');
  static String get tailorAddressSubtitle       => tr('tailorAddressSubtitle');
  static String get tailorAddressCardTitle      => tr('tailorAddressCardTitle');
  static String get tailorAddressEditButton     => tr('tailorAddressEditButton');
  static String get tailorAddressAddButton      => tr('tailorAddressAddButton');
  static String get tailorAddressEmptyTitle     => tr('tailorAddressEmptyTitle');
  static String get tailorAddressEmptySubtitle  => tr('tailorAddressEmptySubtitle');
  // â”€â”€ Add Address Dialog â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get tailorAddressDialogTitle    => tr('tailorAddressDialogTitle');
  static String get tailorAddressDialogSubtitle => tr('tailorAddressDialogSubtitle');
  static String get tailorAddressDialogSavedTitle  => tr('tailorAddressDialogSavedTitle');
  static String get tailorAddressDialogSavedSub    => tr('tailorAddressDialogSavedSub');
  static String get tailorAddressNameLabel      => tr('tailorAddressNameLabel');
  static String get tailorAddressNameHint       => tr('tailorAddressNameHint');
  static String get tailorAddressLocationLabel  => tr('tailorAddressLocationLabel');
  static String get tailorAddressLocationHint   => tr('tailorAddressLocationHint');
  static String get tailorAddressOpenMapButton  => tr('tailorAddressOpenMapButton');
  static String get tailorAddressDetailLabel    => tr('tailorAddressDetailLabel');
  static String get tailorAddressDetailHint     => tr('tailorAddressDetailHint');
  static String get tailorAddressSubmitButton   => tr('tailorAddressSubmitButton');

  // â”€â”€ Update Profile Screen â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get updateProfileTitle        => tr('updateProfileTitle');
  static String get updateProfileSubtitle     => tr('updateProfileSubtitle');
  static String get updateProfileAvatarHint   => tr('updateProfileAvatarHint');
  static String get updateProfileSectionLabel => tr('updateProfileSectionLabel');
  static String get updateProfileNameLabel    => tr('updateProfileNameLabel');
  static String get updateProfileNameHint     => tr('updateProfileNameHint');
  static String get updateProfilePhoneLabel   => tr('updateProfilePhoneLabel');
  static String get updateProfilePhoneHint    => tr('updateProfilePhoneHint');
  static String get updateProfileBioLabel     => tr('updateProfileBioLabel');
  static String get updateProfileBioHint      => tr('updateProfileBioHint');
  static String get updateProfileSaveButton   => tr('updateProfileSaveButton');
  static String get updateProfileSuccess      => tr('updateProfileSuccess');
  static String get updateProfileNameEmpty    => tr('updateProfileNameEmpty');
  static String get updateProfileNameArLabel  => tr('updateProfileNameArLabel');
  static String get updateProfileNameArHint   => tr('updateProfileNameArHint');
  static String get updateProfileNameEnLabel  => tr('updateProfileNameEnLabel');
  static String get updateProfileNameEnHint   => tr('updateProfileNameEnHint');
  static String get updateProfileShopBioLabel => tr('updateProfileShopBioLabel');
  static String get updateProfileShopBioHint  => tr('updateProfileShopBioHint');
  static String get updateProfileCoverHint         => tr('updateProfileCoverHint');
  static String get updateProfileLogoHint          => tr('updateProfileLogoHint');
  static String get updateProfileShopSectionLabel  => tr('updateProfileShopSectionLabel');
  static String get updateProfileConfirmTitle      => tr('updateProfileConfirmTitle');
  static String get updateProfileConfirmSubtitle   => tr('updateProfileConfirmSubtitle');
  static String get updateProfileConfirmYes        => tr('updateProfileConfirmYes');
  static String get updateProfileConfirmNo         => tr('updateProfileConfirmNo');

  // â”€â”€ Change Password Screen â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get changePasswordTitle         => tr('changePasswordTitle');
  static String get changePasswordSubtitle      => tr('changePasswordSubtitle');
  static String get changePasswordBannerTitle   => tr('changePasswordBannerTitle');
  static String get changePasswordBannerSubtitle=> tr('changePasswordBannerSubtitle');
  static String get changePasswordSectionLabel  => tr('changePasswordSectionLabel');
  static String get changePasswordCurrentLabel  => tr('changePasswordCurrentLabel');
  static String get changePasswordNewLabel      => tr('changePasswordNewLabel');
  static String get changePasswordConfirmLabel  => tr('changePasswordConfirmLabel');
  static String get changePasswordButton                  => tr('changePasswordButton');
  static String get changePasswordConfirmDialogTitle      => tr('changePasswordConfirmDialogTitle');
  static String get changePasswordConfirmDialogSubtitle   => tr('changePasswordConfirmDialogSubtitle');
  static String get changePasswordConfirmDialogConfirm    => tr('changePasswordConfirmDialogConfirm');
  static String get changePasswordConfirmDialogCancel     => tr('changePasswordConfirmDialogCancel');

  // â”€â”€ About App Screen â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get aboutAppTitle               => tr('aboutAppTitle');
  static String get aboutAppSubtitle            => tr('aboutAppSubtitle');
  static String get aboutAppStatOrders          => tr('aboutAppStatOrders');
  static String get aboutAppStatTailors         => tr('aboutAppStatTailors');
  static String get aboutAppStatUsers           => tr('aboutAppStatUsers');
  static String get aboutAppSectionAbout        => tr('aboutAppSectionAbout');
  static String get aboutAppDescription         => tr('aboutAppDescription');
  static String get aboutAppSectionFeatures     => tr('aboutAppSectionFeatures');
  static String get aboutAppFeature1Title       => tr('aboutAppFeature1Title');
  static String get aboutAppFeature1Sub         => tr('aboutAppFeature1Sub');
  static String get aboutAppFeature2Title       => tr('aboutAppFeature2Title');
  static String get aboutAppFeature2Sub         => tr('aboutAppFeature2Sub');
  static String get aboutAppFeature3Title       => tr('aboutAppFeature3Title');
  static String get aboutAppFeature3Sub         => tr('aboutAppFeature3Sub');
  static String get aboutAppFeature4Title       => tr('aboutAppFeature4Title');
  static String get aboutAppFeature4Sub         => tr('aboutAppFeature4Sub');
  static String get aboutAppBrandingName        => tr('aboutAppBrandingName');
  static String get aboutAppBrandingTagline     => tr('aboutAppBrandingTagline');
  static String get aboutAppVersion             => tr('aboutAppVersion');

  // â”€â”€ Specializations Bottom Sheet â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get specialTitle              => tr('specialTitle');
  static String get specialSubtitle          => tr('specialSubtitle');
  static String get specialInfoBanner        => tr('specialInfoBanner');
  static String get specialAddLabel          => tr('specialAddLabel');
  static String get specialAddHint           => tr('specialAddHint');
  static String get specialCurrentLabel      => tr('specialCurrentLabel');
  static String get specialNoun              => tr('specialNoun');
  static String get specialSuggestionsLabel  => tr('specialSuggestionsLabel');
  static String get specialSaveButton        => tr('specialSaveButton');

  // â”€â”€ Portfolio Bottom Sheet â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get portfolioTitle           => tr('portfolioTitle');
  static String get portfolioSubtitle        => tr('portfolioSubtitle');
  static String get portfolioHint            => tr('portfolioHint');
  static String get portfolioAddLabel        => tr('portfolioAddLabel');
  static String get portfolioDoneButton      => tr('portfolioDoneButton');
  static String get portfolioAddImageSuccess   => tr('portfolioAddImageSuccess');
  static String get portfolioDeleteImageSuccess => tr('portfolioDeleteImageSuccess');
  static String get addSpecializationSuccess   => tr('addSpecializationSuccess');
  static String get deleteSpecializationSuccess => tr('deleteSpecializationSuccess');

  // â”€â”€ FAQ Screen â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get faqTitle           => tr('faqTitle');
  static String get faqSubtitle        => tr('faqSubtitle');
  static String get faqQ1              => tr('faqQ1');
  static String get faqQ1Sub          => tr('faqQ1Sub');
  static String get faqQ1Answer       => tr('faqQ1Answer');
  static String get faqQ2              => tr('faqQ2');
  static String get faqQ2Sub          => tr('faqQ2Sub');
  static String get faqQ2Answer       => tr('faqQ2Answer');
  static String get faqQ3              => tr('faqQ3');
  static String get faqQ3Sub          => tr('faqQ3Sub');
  static String get faqQ3Answer       => tr('faqQ3Answer');
  static String get faqQ4              => tr('faqQ4');
  static String get faqQ4Sub          => tr('faqQ4Sub');
  static String get faqQ4Answer       => tr('faqQ4Answer');
  static String get faqQ5              => tr('faqQ5');
  static String get faqQ5Sub          => tr('faqQ5Sub');
  static String get faqQ5Answer       => tr('faqQ5Answer');
  static String get faqQ6              => tr('faqQ6');
  static String get faqQ6Sub          => tr('faqQ6Sub');
  static String get faqQ6Answer       => tr('faqQ6Answer');

  // â”€â”€ Contact Us Screen â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get contactUsTitle          => tr('contactUsTitle');
  static String get contactUsSubtitle       => tr('contactUsSubtitle');
  static String get contactUsEmail          => tr('contactUsEmail');
  static String get contactUsEmailLabel     => tr('contactUsEmailLabel');
  static String get contactUsPhone          => tr('contactUsPhone');
  static String get contactUsPhoneLabel     => tr('contactUsPhoneLabel');
  static String get contactUsSendSection    => tr('contactUsSendSection');
  static String get contactUsNameLabel      => tr('contactUsNameLabel');
  static String get contactUsNameHint       => tr('contactUsNameHint');
  static String get contactUsEmailFieldLabel => tr('contactUsEmailFieldLabel');
  static String get contactUsEmailFieldHint  => tr('contactUsEmailFieldHint');
  static String get contactUsSubjectLabel   => tr('contactUsSubjectLabel');
  static String get contactUsSubjectHint    => tr('contactUsSubjectHint');
  static String get contactUsMessageLabel   => tr('contactUsMessageLabel');
  static String get contactUsMessageHint    => tr('contactUsMessageHint');
  static String get contactUsSendButton     => tr('contactUsSendButton');
  static String get contactUsSendSuccess    => tr('contactUsSendSuccess');
  static String get contactUsSendSuccessEn  => tr('contactUsSendSuccessEn');
  static String get contactUsFillAllFields  => tr('contactUsFillAllFields');
  static String get contactUsFillAllFieldsEn => tr('contactUsFillAllFieldsEn');

  // â”€â”€ Privacy Policy Screen â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get privacyTitle        => tr('privacyTitle');
  static String get privacySubtitle     => tr('privacySubtitle');
  static String get privacyIntroTitle   => tr('privacyIntroTitle');
  static String get privacyIntroBody    => tr('privacyIntroBody');
  static String get privacy1Title       => tr('privacy1Title');
  static String get privacy1Body        => tr('privacy1Body');
  static String get privacy2Title       => tr('privacy2Title');
  static String get privacy2Body        => tr('privacy2Body');
  static String get privacy3Title       => tr('privacy3Title');
  static String get privacy3Body        => tr('privacy3Body');
  static String get privacy4Title       => tr('privacy4Title');
  static String get privacy4Body        => tr('privacy4Body');
  static String get privacyLastUpdated  => tr('privacyLastUpdated');

  // â”€â”€ Create Order Screen (Ø¹Ù„Ù‰ Ø°ÙˆÙ‚Ùƒ) â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get createOrderTitle            => tr('createOrderTitle');
  static String get createOrderSubtitlePage1    => tr('createOrderSubtitlePage1');
  static String get createOrderSubtitlePage2    => tr('createOrderSubtitlePage2');
  static String get createOrderPage1Heading     => tr('createOrderPage1Heading');
  static String get createOrderPage1SubHeading  => tr('createOrderPage1SubHeading');
  static String get createOrderPage2Heading     => tr('createOrderPage2Heading');
  static String get createOrderPage2SubHeading  => tr('createOrderPage2SubHeading');
  static String get createOrderNameLabel        => tr('createOrderNameLabel');
  static String get createOrderNameHint         => tr('createOrderNameHint');
  static String get createOrderDescLabel        => tr('createOrderDescLabel');
  static String get createOrderDescHint         => tr('createOrderDescHint');
  static String get createOrderSpecialLabel     => tr('createOrderSpecialLabel');
  static String get createOrderSpecialHint      => tr('createOrderSpecialHint');
  static String get createOrderFabricLabel      => tr('createOrderFabricLabel');
  static String get createOrderFabricChiffon    => tr('createOrderFabricChiffon');
  static String get createOrderFabricCrepe      => tr('createOrderFabricCrepe');
  static String get createOrderFabricCotton     => tr('createOrderFabricCotton');
  static String get createOrderFabricSilk       => tr('createOrderFabricSilk');
  static String get createOrderFabricVelvet     => tr('createOrderFabricVelvet');
  static String get createOrderFabricOther      => tr('createOrderFabricOther');
  static String get createOrderBudgetLabel      => tr('createOrderBudgetLabel');
  static String get createOrderBudgetHint       => tr('createOrderBudgetHint');
  static String get createOrderBudgetNote       => tr('createOrderBudgetNote');
  static String get createOrderCurrency         => tr('createOrderCurrency');
  static String get createOrderDeadlineLabel    => tr('createOrderDeadlineLabel');
  static String get createOrderDeadlineHint     => tr('createOrderDeadlineHint');
  static String get createOrderImagesLabel      => tr('createOrderImagesLabel');
  static String get createOrderImagesSubtitle   => tr('createOrderImagesSubtitle');
  static String get createOrderImagesUpload     => tr('createOrderImagesUpload');
  static String get createOrderImagesFormats    => tr('createOrderImagesFormats');
  static String get createOrderNextButton       => tr('createOrderNextButton');
  static String get createOrderSubmitButton     => tr('createOrderSubmitButton');
  static String get createOrderValidateName     => tr('createOrderValidateName');
  static String get createOrderValidateDesc     => tr('createOrderValidateDesc');
  static String get createOrderValidateFabric   => tr('createOrderValidateFabric');
  static String get createOrderValidateBudget   => tr('createOrderValidateBudget');
  static String get createOrderValidateDeadline => tr('createOrderValidateDeadline');

  // Create Order â€” Confirm & Feedback
  static String get createOrderConfirmTitle        => tr('createOrderConfirmTitle');
  static String get createOrderConfirmSubtitle     => tr('createOrderConfirmSubtitle');
  static String get createOrderConfirmYes          => tr('createOrderConfirmYes');
  static String get createOrderConfirmNo           => tr('createOrderConfirmNo');
  static String get createOrderSuccess             => tr('createOrderSuccess');
  static String get createOrderSuccessEn           => tr('createOrderSuccessEn');
  static String get createOrderErrorServer         => tr('createOrderErrorServer');
  static String get createOrderErrorServerEn       => tr('createOrderErrorServerEn');
  static String get createOrderValidateMinBudget   => tr('createOrderValidateMinBudget');
  static String get createOrderValidateMaxBudget   => tr('createOrderValidateMaxBudget');
  static String get createOrderMinBudgetLabel      => tr('createOrderMinBudgetLabel');
  static String get createOrderMinBudgetHint       => tr('createOrderMinBudgetHint');
  static String get createOrderMaxBudgetLabel      => tr('createOrderMaxBudgetLabel');
  static String get createOrderMaxBudgetHint       => tr('createOrderMaxBudgetHint');

  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  // Chat â€” Socket / Connection States
  // â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get chatConnecting => tr('chatConnecting');
  static String get chatConnectingEn => tr('chatConnectingEn');
  static String get chatConnectionError => tr('chatConnectionError');
  static String get chatConnectionErrorEn => tr('chatConnectionErrorEn');
  static String get chatMessageSendFailed => tr('chatMessageSendFailed');
  static String get chatMessageSendFailedEn => tr('chatMessageSendFailedEn');
  static String get chatLoadingConversations => tr('chatLoadingConversations');
  static String get chatLoadingMessages => tr('chatLoadingMessages');
  static String get chatNoMessages => tr('chatNoMessages');
  static String get chatNoMessagesDesc => tr('chatNoMessagesDesc');

  // â”€â”€ Loyalty Points Screen â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get loyaltyScreenTitle          => tr('loyaltyScreenTitle');
  static String get loyaltyScreenSubtitle       => tr('loyaltyScreenSubtitle');
  static String get loyaltyBalanceLabel         => tr('loyaltyBalanceLabel');
  static String get loyaltyTodayDate            => tr('loyaltyTodayDate');
  static String get loyaltyPointUnit            => tr('loyaltyPointUnit');
  static String get loyaltyAvailableRewards     => tr('loyaltyAvailableRewards');
  static String get loyaltyAvailableRewardsSub  => tr('loyaltyAvailableRewardsSub');
  static String get loyaltyRedeemButton         => tr('loyaltyRedeemButton');
  static String get loyaltyRedeemSuccess        => tr('loyaltyRedeemSuccess');
  static String get loyaltyRedeemSuccessEn      => tr('loyaltyRedeemSuccessEn');
  static String get loyaltyNotEnoughPoints      => tr('loyaltyNotEnoughPoints');
  static String get loyaltyNotEnoughPointsEn    => tr('loyaltyNotEnoughPointsEn');
  static String get loyaltyPointsRequired       => tr('loyaltyPointsRequired');
  static String get loyaltyDiscountFixed        => tr('loyaltyDiscountFixed');
  static String get loyaltyDiscountPercent      => tr('loyaltyDiscountPercent');
  static String get loyaltyEmptyRewards          => tr('loyaltyEmptyRewards');
  static String get loyaltyEmptyRewardsSub       => tr('loyaltyEmptyRewardsSub');
  static String get loyaltyLoadingError          => tr('loyaltyLoadingError');
  static String get loyaltyLoadingErrorEn        => tr('loyaltyLoadingErrorEn');
  static String get loyaltyRedeemDialogSubtitle  => tr('loyaltyRedeemDialogSubtitle');
  static String get loyaltyCodeCopied            => tr('loyaltyCodeCopied');
  static String get loyaltyCodeTapToCopy         => tr('loyaltyCodeTapToCopy');

  // â”€â”€ Loyalty â€“ Unused Codes â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get loyaltyUnusedCodesTitle      => tr('loyaltyUnusedCodesTitle');
  static String get loyaltyUnusedCodesSubtitle   => tr('loyaltyUnusedCodesSubtitle');
  static String get loyaltyUnusedCodesEmpty      => tr('loyaltyUnusedCodesEmpty');
  static String get loyaltyUnusedCodesEmptySub   => tr('loyaltyUnusedCodesEmptySub');
  static String get loyaltyUnusedCodeCopied      => tr('loyaltyUnusedCodeCopied');
  static String get loyaltyUnusedCodeCopiedEn    => tr('loyaltyUnusedCodeCopiedEn');
  static String get loyaltyUnusedCodesCurrency   => tr('loyaltyUnusedCodesCurrency');

  // â”€â”€ Common â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get close => tr('close');

  // â”€â”€ Cart â€” API Feedback â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get cartAddedToCart         => tr('cartAddedToCart');
  static String get cartRemovedFromCart     => tr('cartRemovedFromCart');
  static String get cartUpdatedQty          => tr('cartUpdatedQty');
  static String get cartCouponApplied       => tr('cartCouponApplied');
  static String get cartCouponRemoved       => tr('cartCouponRemoved');
  static String get cartCouponInvalid       => tr('cartCouponInvalid');
  static String get cartCheckoutSuccess     => tr('cartCheckoutSuccess');
  static String get cartRemoveCoupon        => tr('cartRemoveCoupon');
  static String get cartDiscount            => tr('cartDiscount');
  static String get cartCouponLabel         => tr('cartCouponLabel');
  static String get cartSavings             => tr('cartSavings');
  static String get cartTotalAfterDiscount  => tr('cartTotalAfterDiscount');

  // â”€â”€ Product Details Screen â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get productDetailsTitle         => tr('productDetailsTitle');
  static String get productDetailsColor         => tr('productDetailsColor');
  static String get productDetailsSize          => tr('productDetailsSize');
  static String get productDetailsQty           => tr('productDetailsQty');
  static String get productDetailsAddToCart     => tr('productDetailsAddToCart');
  static String get productDetailsFeatures      => tr('productDetailsFeatures');
  static String get productDetailsCare          => tr('productDetailsCare');
  static String get productDetailsDelivery      => tr('productDetailsDelivery');
  static String get productDetailsDeliveryDays  => tr('productDetailsDeliveryDays');
  static String get productDetailsRating        => tr('productDetailsRating');
  static String get productDetailsReviews       => tr('productDetailsReviews');
  static String get productDetailsShop          => tr('productDetailsShop');
  static String get productDetailsCategory      => tr('productDetailsCategory');
  static String get productDetailsOutOfStock    => tr('productDetailsOutOfStock');
  static String get productDetailsSelectVariant => tr('productDetailsSelectVariant');
  static String get productDetailsCurrency      => tr('productDetailsCurrency');
  static String get productDetailsLoading       => tr('productDetailsLoading');
  static String get productDetailsError         => tr('productDetailsError');

  // â”€â”€ Tailor Details Screen â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get tailorDetailsTitle          => tr('tailorDetailsTitle');
  static String get tailorDetailsAvailable      => tr('tailorDetailsAvailable');
  static String get tailorDetailsUnavailable    => tr('tailorDetailsUnavailable');
  static String get tailorDetailsBio            => tr('tailorDetailsBio');
  static String get tailorDetailsSpecializations => tr('tailorDetailsSpecializations');
  static String get tailorDetailsPortfolio      => tr('tailorDetailsPortfolio');
  static String get tailorDetailsStats          => tr('tailorDetailsStats');
  static String get tailorDetailsRating         => tr('tailorDetailsRating');
  static String get tailorDetailsReviews        => tr('tailorDetailsReviews');
  static String get tailorDetailsOffers         => tr('tailorDetailsOffers');
  static String get tailorDetailsCompletedOrders => tr('tailorDetailsCompletedOrders');
  static String get tailorDetailsRequestOrder   => tr('tailorDetailsRequestOrder');
  static String get tailorDetailsContactChat    => tr('tailorDetailsContactChat');
  static String get tailorDetailsNoPortfolio    => tr('tailorDetailsNoPortfolio');
  static String get tailorDetailsNoBio          => tr('tailorDetailsNoBio');
  static String get tailorDetailsNoSpecializations => tr('tailorDetailsNoSpecializations');
  static String get tailorDetailsLoading        => tr('tailorDetailsLoading');
  static String get tailorDetailsError          => tr('tailorDetailsError');

  // â”€â”€ Shop Owner Home Screen â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  static String get shopHomeShopOpen            => tr('shopHomeShopOpen');
  static String get shopHomeShopClosed          => tr('shopHomeShopClosed');
  static String get shopHomeBalanceTitle        => tr('shopHomeBalanceTitle');
  static String get shopHomeBalanceCurrency     => tr('shopHomeBalanceCurrency');
  static String get shopHomeLastLogin           => tr('shopHomeLastLogin');
  static String get shopHomeAverageRating       => tr('shopHomeAverageRating');
  static String get shopHomeReviewsCount        => tr('shopHomeReviewsCount');
  static String get shopHomeGreeting            => tr('shopHomeGreeting');
  static String get shopHomeReviewsTitle        => tr('shopHomeReviewsTitle');
  static String get shopHomeReviewsSubtitle     => tr('shopHomeReviewsSubtitle');
  static String get shopHomeProductsTitle       => tr('shopHomeProductsTitle');
  static String get shopHomeProductsSubtitle    => tr('shopHomeProductsSubtitle');
}

