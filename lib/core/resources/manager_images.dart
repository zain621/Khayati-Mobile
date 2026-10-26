const String imagesPath = 'assets/images';

/// A class defined for all images the app
class ManagerImages {
  static const String logo = "$imagesPath/logo.svg";

  /// Splash hero (Flutter splash + must match native launch background).
  /// Do NOT point this at splash_curtain_collage.jpg — that is the old grid.
  static const String splashBackground = "$imagesPath/splash-bg.jpg";

  /// @Deprecated('Use splashBackground') — kept so any leftover refs stay on the new image.
  static const String splashCurtainCollage = splashBackground;

  /// Tailor role preview photos (cropped from brand collage) — NOT used for splash.
  static const String roleCustomTailor = "$imagesPath/splash_curtain_collage.jpg";
  static const String roleClothingStore = "$imagesPath/splash_curtain_collage.jpg";
  static const String roleTailorStore = "$imagesPath/splash_curtain_collage.jpg";

  ///On Boarding Images
  static const String onBoarding1 = "$imagesPath/on_boarding_image1.png";
  static const String onBoarding2 = "$imagesPath/on_boarding_image2.png";
  static const String onBoarding3 = "$imagesPath/on_boarding_image3.png";

  ///Auth Images
  static const String backgroundAuth = "$imagesPath/background_auth.png";
  static const String passwordChangedSuccess =
      "$imagesPath/password_changed_success.png";
  static const String createAccountSuccess =
      "$imagesPath/create_account_success.png";

  ///Register Choose Account Type Images
  static const String continueUserCustomer =
      "$imagesPath/account-img-1.jpg";
  static const String continueUserProvider =
      "$imagesPath/account-img-2.jpg";
  static const String cardBackgroundChooseAccountType =
      "$imagesPath/card_background_choose_account_type.png";
  static const String card2BackgroundChooseAccountType =
      "$imagesPath/card2_background_choose_account_type.png";

  static const String homeBackgroundHeader =
      "$imagesPath/background_home_header.png";

  static const String homeBalanceBackground1 =
      "$imagesPath/home_balance_background1.png";
  static const String homeBalanceBackground2 =
      "$imagesPath/home_balance_background2.png";
  static const String backgroundHomeItems =
      "$imagesPath/background_home_items.png";

  ///Profile Images
  static const String backgroundProfileImage1 =
      "$imagesPath/background_profile1.png";
  static const String backgroundProfileImage2 =
      "$imagesPath/background_profile2.png";

  static const String locationAvatar="$imagesPath/loadtion_avatar.svg";    

 ///Home User Screen Images
 static const String backgroundCustomOffer =
      "$imagesPath/background_custom_offer.png";    
 static const String profileProvider="$imagesPath/background_profile_profile_screen.png";      
  static const String updateProfileBackground="$imagesPath/update_proflie_background.png";
  //About Us Screen
    static const String aboutUsImage="$imagesPath/card_about_us.png";

 //Default Image Profile 
 static const String defaultProfileImage="$imagesPath/default_image.png";   
 static const String storeImage="$imagesPath/store_remove.png";
 static const String loyaltyPointsImage="$imagesPath/loyalty_points_image.png";

 static const String forgroundShopsCard="$imagesPath/forground_shops_card.png";
 static const String backgroundShopImage="$imagesPath/background_shop_image.png";
}
