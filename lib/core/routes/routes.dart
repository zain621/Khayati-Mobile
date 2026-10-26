import 'package:app_mobile/features/auth/presentation/pages/login_screen.dart';
import 'package:app_mobile/features/auth/presentation/pages/logged_out_screen.dart';
import 'package:app_mobile/features/auth/presentation/pages/reset_password_screen.dart';
import 'package:app_mobile/features/auth/presentation/pages/verification_code_screen.dart';
import 'package:app_mobile/features/auth/presentation/pages/provider_verification_screen.dart';
import 'package:app_mobile/features/auth/presentation/pages/new_password_screen.dart';
import 'package:app_mobile/features/auth/presentation/pages/password_changed_success_screen.dart';
import 'package:app_mobile/features/auth/presentation/pages/users_register/auth_role_selection_screen.dart';
import 'package:app_mobile/features/auth/presentation/pages/users_register/choose_type_account/pages/choose_type_account_screen.dart';
import 'package:app_mobile/features/auth/presentation/pages/users_register/language_selection_screen.dart';
import 'package:app_mobile/features/auth/presentation/pages/users_register/user_customer/pages/customer_register_screen.dart';
import 'package:app_mobile/features/auth/presentation/pages/users_register/user_customer/pages/customer_register_verification_screen.dart';
import 'package:app_mobile/features/auth/presentation/pages/users_register/user_customer/pages/customer_register_success_screen.dart';
import 'package:app_mobile/features/auth/presentation/pages/users_register/provider_register/pages/provider_register_screen.dart';
import 'package:app_mobile/features/auth/presentation/pages/users_register/provider_register/pages/provider_register_success_screen.dart';
import 'package:app_mobile/features/providers/independent_tailor/home_independents_tailor/presentation/home_independts_tailor_screen.dart';
import 'package:app_mobile/features/providers/store_user/store_home_user/presentation/pages/home_store_tailor_screen.dart';
import 'package:app_mobile/features/providers/comprehensive_tailor/home_comprehensive_tailor/home_comprehensive_tailor_screen.dart';
import 'package:app_mobile/features/providers/comprehensive_tailor/manager_products/presentation/pages/manager_products_screen.dart';
import 'package:app_mobile/features/providers/comprehensive_tailor/manager_products/presentation/pages/add_edit_product_screen.dart';
import 'package:app_mobile/features/providers/common_features/customer_reviews/presentation/customer_reviews_screen.dart';
import 'package:app_mobile/features/providers/independent_tailor/my_offers/presentation/my_offers_screen.dart';
import 'package:app_mobile/features/providers/independent_tailor/my_offers/presentation/order_detail_screen.dart';
import 'package:app_mobile/features/providers/independent_tailor/order_tracking/presentation/order_tracking_screen.dart';
import 'package:app_mobile/features/providers/independent_tailor/suggested_requests/presentation/pages/suggested_requests_screen.dart';
import 'package:app_mobile/features/providers/common_features/wallet/persentation/pages/wallet_screen.dart';
import 'package:app_mobile/features/providers/common_features/wallet/persentation/pages/withdraw_request_screen.dart';
import 'package:app_mobile/features/providers/common_features/add_account_bank/presentation/add_bank_account_screen.dart';
import 'package:app_mobile/features/providers/common_features/chat/presentation/pages/conversations_screen.dart';
import 'package:app_mobile/features/providers/common_features/chat/presentation/pages/chat_detail_screen.dart';
import 'package:app_mobile/features/providers/common_features/chat/presentation/pages/add_custom_offer_screen.dart';
import 'package:app_mobile/features/providers/common_features/chat/domain/di/di.dart'
    as chat_di;
import 'package:app_mobile/features/providers/common_features/wallet/domain/di/di.dart'
    as wallet_di;
import 'package:app_mobile/features/providers/common_features/addresses/domain/di/di.dart'
    as address_di;
import 'package:app_mobile/features/common/change_password/domain/di/di.dart'
    as change_password_di;
import 'package:app_mobile/features/auth/domain/di/di.dart' as auth_di;
import 'package:app_mobile/features/user/cart/presentation/pages/cart_screen.dart';
import 'package:app_mobile/features/user/cart/presentation/pages/checkout_webview_screen.dart';
import 'package:app_mobile/features/user/cart/domain/di/di.dart' as cart_di;
import 'package:app_mobile/features/user/create_order/presentation/pages/create_order_screen.dart';
import 'package:app_mobile/features/user/create_order/domain/di/di.dart'
    as create_order_di;
import 'package:app_mobile/features/user/product_details/presentation/pages/product_details_screen.dart';
import 'package:app_mobile/features/user/tailor_details/presentation/pages/tailor_details_screen.dart';
import 'package:app_mobile/features/user/chat/presentation/pages/user_conversations_screen.dart';
import 'package:app_mobile/features/user/chat/presentation/pages/user_chat_detail_screen.dart';
import 'package:app_mobile/features/splash_and_boarding/presentation/pages/on_boarding_screen.dart';
import 'package:app_mobile/features/splash_and_boarding/presentation/pages/splash_screen.dart';
import 'package:app_mobile/features/user/home_user/domain/di/di.dart';
import 'package:app_mobile/features/user/home_user/presentation/controller/main_navigation_controller.dart';
import 'package:app_mobile/features/user/home_user/presentation/pages/home_user_screen.dart';
import 'package:app_mobile/features/user/home_user/presentation/pages/nearby_tailors_map_screen.dart';
import 'package:app_mobile/features/user/home_user/presentation/pages/main_navigation_page.dart';
import 'package:app_mobile/features/user/my_oredrs/presentation/pages/order_details_screen.dart';
import 'package:app_mobile/features/user/my_oredrs/presentation/pages/submitted_offers_screen.dart';
import 'package:app_mobile/features/user/my_oredrs/domain/di/di.dart'
    as my_orders_di;
import 'package:app_mobile/features/providers/common_features/profile/presentation/pages/profile_provider_screen.dart';
import 'package:app_mobile/features/providers/common_features/profile/presentation/pages/update_profile_provider_screen.dart';
import 'package:app_mobile/features/common/change_password/presentation/pages/change_password_screen.dart';
import 'package:app_mobile/features/providers/common_features/addresses/presentation/pages/tailor_address_screen.dart';
import 'package:app_mobile/features/user/details_shop/presentation/pages/details_shop_screen.dart';
import 'package:app_mobile/features/user/loyalty/presentation/pages/loyalty_points_screen.dart';
import 'package:app_mobile/features/user/profile/presentation/pages/profile_user_screen.dart';
import 'package:app_mobile/features/user/search/presentation/pages/search_screen.dart';
import 'package:app_mobile/features/user/all_shops/presentation/pages/all_shops_screen.dart';
import 'package:app_mobile/features/user/all_shops/domain/di/di.dart'
    as all_shops_di;
import 'package:app_mobile/features/user/all_products/presentation/pages/all_products_screen.dart';
import 'package:app_mobile/features/user/all_products/domain/di/di.dart'
    as all_products_di;
import 'package:app_mobile/features/common/about_app/presentation/pages/about_app_screen.dart';
import 'package:app_mobile/features/common/faq/presentation/pages/faq_screen.dart';
import 'package:app_mobile/features/common/contact_us/presentation/pages/contact_us_screen.dart';
import 'package:app_mobile/features/common/privacy_policy/presentation/pages/privacy_policy_screen.dart';
import 'package:app_mobile/features/common/notfication/presentation/pages/notification_screen.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../resources/manager_strings.dart';

/// A class defined for all routes constants
class Routes {
  static const String splash = '/splash';
  static const String onBoarding = '/onBoarding';
  static const String authRoleSelection = '/authRoleSelection';
  static const String loginScreen = '/loginScreen';
  static const String loggedOutScreen = '/loggedOutScreen';
  static const String resetPassword = '/resetPassword';
  static const String verificationCode = '/verificationCode';
  static const String newPassword = '/newPassword';
  static const String passwordChangedSuccess = '/passwordChangedSuccess';
  static const String chooseTypeAccount = '/chooseTypeAccount';
  static const String languageSelection = '/languageSelection';
  static const String customerRegister = '/customerRegister';
  static const String customerRegisterVerification =
      '/customerRegisterVerification';
  static const String customerRegisterSuccess = '/customerRegisterSuccess';
  static const String providerRegister = '/providerRegister';
  static const String providerRegisterSuccess = '/providerRegisterSuccess';
  static const String providerLoginVerification = '/providerLoginVerification';
  static const String independentTailorHome = '/independentTailorHome';
  static const String storeTailorHome = '/storeTailorHome';
  static const String comprehensiveTailorHome = '/comprehensiveTailorHome';
  static const String suggestedRequests = '/suggestedRequests';
  static const String orderTracking = '/orderTracking';
  static const String myOffers = '/myOffers';
  static const String orderDetailForTailor = '/orderDetailForTailor';
  static const String customerReviews = '/customerReviews';
  static const String managerProducts = '/managerProducts';
  static const String addEditProductScreen = '/addEditProductScreen';

  // Wallet & Bank Account Routes
  static const String walletScreen = '/walletScreen';
  static const String withdrawRequestScreen = '/withdrawRequestScreen';
  static const String addBankAccountScreen = '/addBankAccountScreen';

  // Chat Routes
  static const String conversationsScreen = '/conversationsScreen';
  static const String chatDetailScreen = '/chatDetailScreen';
  static const String addCustomOfferScreen = '/addCustomOfferScreen';

  // User Chat Routes
  static const String userConversationsScreen = '/userConversationsScreen';
  static const String userChatDetailScreen = '/userChatDetailScreen';

  // User Screens
  static const String userHome = '/userHome';
  static const String mainNavigation = '/mainNavigation';
  static const String nearbyTailorsMapScreen = '/nearbyTailorsMapScreen';
  static const String profileUserScreen = '/profileUserScreen';
  static const String profileProviderScreen = '/profileProviderScreen';
  static const String updateProfileProviderScreen =
      '/updateProfileProviderScreen';
  static const String changePasswordScreen = '/changePasswordScreen';
  static const String tailorAddressScreen = '/tailorAddressScreen';
  static const String submittedOffers = '/submittedOffers';
  static const String orderDetails = '/orderDetails';
  static const String notificationScreen = '/notificationScreen';
  static const String aboutAppScreen = '/aboutAppScreen';
  static const String faqScreen = '/faqScreen';
  static const String contactUsScreen = '/contactUsScreen';
  static const String privacyPolicyScreen = '/privacyPolicyScreen';
  static const String cartScreen = '/cartScreen';
  static const String checkoutWebViewScreen = '/checkoutWebViewScreen';
  static const String loyaltyPointsScreen = "/loyaltyPointsScreen";
  static const String detailsShop = '/detailsShop';
  static const String productDetailsScreen = '/productDetailsScreen';
  static const String tailorDetailsScreen = '/tailorDetailsScreen';
  static const String searchScreen = '/searchScreen';
  static const String createOrderScreen = '/createOrderScreen';
  static const String allShopsScreen = '/allShopsScreen';
  static const String allProductsScreen = '/allProductsScreen';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return _buildRoute(const SplashScreen(), settings);
      case Routes.onBoarding:
        return _buildRoute(const OnBoardingScreen(), settings);
      case Routes.authRoleSelection:
        return _buildRoute(const AuthRoleSelectionScreen(), settings);
      case Routes.loginScreen:
        return _buildRoute(const LoginScreen(), settings);
      case Routes.loggedOutScreen:
        return _buildRoute(const LoggedOutScreen(), settings);
      case Routes.resetPassword:
        return _buildRoute(const ResetPasswordScreen(), settings);
      case Routes.verificationCode:
        final args = settings.arguments as Map<String, dynamic>?;
        return _buildRoute(
          VerificationCodeScreen(phoneNumber: args?['phoneNumber']),
          settings,
        );
      case Routes.newPassword:
        return _buildRoute(const NewPasswordScreen(), settings);
      case Routes.passwordChangedSuccess:
        return _buildRoute(const PasswordChangedSuccessScreen(), settings);
      case Routes.chooseTypeAccount:
        return _buildRoute(const ChooseTypeAccountScreen(), settings);
      case Routes.languageSelection:
        final langArgs = settings.arguments as Map<String, dynamic>?;
        final audienceName =
            langArgs?['audience'] as String? ?? LanguageAudience.visitor.name;
        final audience = LanguageAudience.values.firstWhere(
          (e) => e.name == audienceName,
          orElse: () => LanguageAudience.visitor,
        );
        return _buildRoute(
          LanguageSelectionScreen(audience: audience),
          settings,
        );
      case Routes.customerRegister:
        return _buildRoute(const CustomerRegisterScreen(), settings);
      case Routes.customerRegisterVerification:
        final args = settings.arguments as Map<String, dynamic>?;
        return _buildRoute(
          CustomerRegisterVerificationScreen(
            phoneNumber: args?['phoneNumber'],
          ),
          settings,
        );
      case Routes.customerRegisterSuccess:
        return _buildRoute(const CustomerRegisterSuccessScreen(), settings);
      case Routes.providerRegister:
        return _buildRoute(const ProviderRegisterScreen(), settings);
      case Routes.providerRegisterSuccess:
        return _buildRoute(const ProviderRegisterSuccessScreen(), settings);
      case Routes.providerLoginVerification:
        final args = settings.arguments as Map<String, dynamic>?;
        final phoneNumber = args?['phoneNumber'] as String? ?? '';
        final otpCode = args?['otpCode'] as String?;
        auth_di.initProviderVerification(phoneNumber: phoneNumber);
        return _buildRoute(
          ProviderVerificationScreen(
            phoneNumber: phoneNumber,
            initialOtpCode: otpCode,
          ),
          settings,
        );
      case Routes.independentTailorHome:
        final userId = instance<AppSettingsPrefs>().getUserId();
        return _buildRoute(
          HomeIndependentTailorScreen(key: ValueKey('ind_home_$userId')),
          settings,
        );
      case Routes.storeTailorHome:
        final storeUserId = instance<AppSettingsPrefs>().getUserId();
        return _buildRoute(
          HomeStoreTailorScreen(key: ValueKey('store_home_$storeUserId')),
          settings,
        );
      case Routes.comprehensiveTailorHome:
        final compUserId = instance<AppSettingsPrefs>().getUserId();
        return _buildRoute(
          HomeComprehensiveTailorScreen(
            key: ValueKey('comp_home_$compUserId'),
          ),
          settings,
        );
      case Routes.suggestedRequests:
        return _buildRoute(const SuggestedRequestsScreen(), settings);
      case Routes.orderTracking:
        return _buildRoute(const OrderTrackingScreen(), settings);
      case Routes.myOffers:
        return _buildRoute(const MyOffersScreen(), settings);
      case Routes.customerReviews:
        return _buildRoute(const CustomerReviewsScreen(), settings);
      case Routes.managerProducts:
        return _buildRoute(const ManagerProductsScreen(), settings);
      case Routes.addEditProductScreen:
        return _buildRoute(const AddEditProductScreen(), settings);
      case Routes.walletScreen:
        wallet_di.initWallet();
        return _buildRoute(const WalletScreen(), settings);
      case Routes.withdrawRequestScreen:
        wallet_di.initWallet();
        return _buildRoute(const WithdrawRequestScreen(), settings);
      case Routes.addBankAccountScreen:
        wallet_di.initWallet();
        final args = settings.arguments as Map<String, dynamic>?;
        return _buildRoute(
          AddBankAccountScreen(
            isEditMode: args?['isEditMode'] ?? false,
            existingBankName: args?['existingBankName'],
            existingAccountHolder: args?['existingAccountHolder'],
            existingBankAccount: args?['existingBankAccount'],
            existingBankIban: args?['existingBankIban'],
            bankAccountId: args?['bankAccountId'],
          ),
          settings,
        );
      case Routes.conversationsScreen:
        chat_di.initProviderChat();
        return _buildRoute(const ConversationsScreen(), settings);
      case Routes.chatDetailScreen:
        final args = settings.arguments as Map<String, dynamic>?;
        chat_di.initProviderChatDetail(
          conversationId: args?['conversationId'] ?? '',
          userName: args?['userName'] ?? '',
          avatarUrl: args?['avatarUrl'],
          isOnline: args?['isOnline'] ?? false,
        );
        return _buildRoute(
          ChatDetailScreen(
            conversationId: args?['conversationId'] ?? '',
            userName: args?['userName'] ?? '',
            avatarUrl: args?['avatarUrl'],
            isOnline: args?['isOnline'] ?? false,
          ),
          settings,
        );
      case Routes.addCustomOfferScreen:
        final args = settings.arguments as Map<String, dynamic>?;
        return _buildRoute(
          AddCustomOfferScreen(
            conversationId: args?['conversationId'] ?? '',
            userName: args?['userName'] ?? '',
            isEdit: args?['isEdit'] ?? false,
            offerId: args?['offerId'],
            existingTitle: args?['existingTitle'],
            existingDescription: args?['existingDescription'],
            existingPrice: args?['existingPrice'] as double?,
            existingAdditions: args?['existingAdditions'] as List<String>?,
          ),
          settings,
        );
      case Routes.userConversationsScreen:
        chat_di.initUserChat();
        return _buildRoute(const UserConversationsScreen(), settings);
      case Routes.userChatDetailScreen:
        final args = settings.arguments as Map<String, dynamic>?;
        chat_di.initUserChatDetail(
          conversationId: args?['conversationId'] ?? '',
          userName: args?['userName'] ?? '',
          avatarUrl: args?['avatarUrl'],
          isOnline: args?['isOnline'] ?? false,
        );
        return _buildRoute(
          UserChatDetailScreen(
            conversationId: args?['conversationId'] ?? '',
            userName: args?['userName'] ?? '',
            avatarUrl: args?['avatarUrl'],
            isOnline: args?['isOnline'] ?? false,
          ),
          settings,
        );
      case Routes.userHome:
        return _buildRoute(const HomeUserScreen(), settings);
      case Routes.nearbyTailorsMapScreen:
        initHomeUser();
        return _buildRoute(const NearbyTailorsMapScreen(), settings);
      case Routes.mainNavigation:
        if (Get.isRegistered<MainNavigationController>()) {
          Get.delete<MainNavigationController>(force: true);
        }
        Get.put(MainNavigationController());
        // Key by user id so IndexedStack tabs never reuse the previous
        // account's widget/state after logout → login.
        final userId = instance<AppSettingsPrefs>().getUserId();
        return _buildRoute(
          MainNavigationPage(key: ValueKey('main_nav_$userId')),
          settings,
        );
      case Routes.cartScreen:
        cart_di.initCart();
        return _buildRoute(const CartScreen(), settings);
      case Routes.checkoutWebViewScreen:
        final args = settings.arguments as Map<String, dynamic>?;
        final checkoutUrl = args?['url'] as String? ?? '';
        final sourceName = (args?['source'] as String? ?? 'cart').toLowerCase();
        final source = sourceName == 'zoqak'
            ? CheckoutPaymentSource.zoqak
            : sourceName == 'chat'
                ? CheckoutPaymentSource.chat
                : CheckoutPaymentSource.cart;
        return _buildRoute(
          CheckoutWebViewScreen(
            checkoutUrl: checkoutUrl,
            paymentSessionId: args?['sessionId'] as String?,
            provider: args?['provider'] as String?,
            source: source,
          ),
          settings,
        );
      case Routes.profileUserScreen:
        return _buildRoute(const ProfileUserScreen(), settings);
      case Routes.profileProviderScreen:
        return _buildRoute(const ProfileProviderScreen(), settings);
      case Routes.updateProfileProviderScreen:
        return _buildRoute(
            UpdateProfileProviderScreen(
              isUser: false,
            ),
            settings);
      case Routes.changePasswordScreen:
        change_password_di.initChangePassword();
        return _buildRoute(const ChangePasswordScreen(), settings);
      case Routes.tailorAddressScreen:
        final args = settings.arguments as Map<String, dynamic>?;
        address_di.initAddress();
        return _buildRoute(
          TailorAddressScreen(isProvider: args?['isProvider'] ?? false),
          settings,
        );
      case Routes.submittedOffers:
        my_orders_di.initMyOrders();
        final orderId = settings.arguments as String? ?? '';
        return _buildRoute(SubmittedOffersScreen(orderId: orderId), settings);
      case Routes.orderDetails:
        my_orders_di.initMyOrders();
        final detailOrderId = settings.arguments as String? ?? '';
        return _buildRoute(
          OrderDetailsScreen(orderId: detailOrderId),
          settings,
        );
      case Routes.notificationScreen:
        return _buildRoute(const NotificationScreen(), settings);
      case Routes.aboutAppScreen:
        return _buildRoute(const AboutAppScreen(), settings);
      case Routes.faqScreen:
        return _buildRoute(const FaqScreen(), settings);
      case Routes.contactUsScreen:
        return _buildRoute(const ContactUsScreen(), settings);
      case Routes.privacyPolicyScreen:
        return _buildRoute(const PrivacyPolicyScreen(), settings);
      case Routes.loyaltyPointsScreen:
        return _buildRoute(const LoyaltyPointsScreen(), settings);
      case Routes.detailsShop:
        final shopId = settings.arguments as String;
        return _buildRoute(DetailsShopScreen(shopId: shopId), settings);
      case Routes.productDetailsScreen:
        final productId = settings.arguments as String;
        return _buildRoute(
            ProductDetailsScreen(productId: productId), settings);
      case Routes.tailorDetailsScreen:
        final tailorId = settings.arguments as String;
        return _buildRoute(TailorDetailsScreen(tailorId: tailorId), settings);
      case Routes.searchScreen:
        return _buildRoute(const SearchScreen(), settings);
      case Routes.allShopsScreen:
        all_shops_di.initAllShops();
        return _buildRoute(const AllShopsScreen(), settings);
      case Routes.allProductsScreen:
        all_products_di.initAllProducts();
        return _buildRoute(const AllProductsScreen(), settings);
      case Routes.createOrderScreen:
        create_order_di.initCreateOrderRequest();
        return _buildRoute(const CreateOrderScreen(), settings);
      case Routes.orderDetailForTailor:
        final args = settings.arguments as Map<String, dynamic>?;
        return _buildRoute(
          OrderDetailScreen(orderId: args?['orderId'] ?? ''),
          settings,
        );

      default:
        return unDefinedRoute();
    }
  }

  /// Animated page route with fade + slide transition
  static Route<dynamic> _buildRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );

        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.05, 0),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
    );
  }

  /// If PushNamed Failed Return This Page With No Actions
  /// This Screen Will Tell The User This Page Is Not Exist
  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(
            ManagerStrings.noRouteFound,
          ),
        ),
        body: Center(
          child: Text(
            ManagerStrings.noRouteFound,
          ),
        ),
      ),
    );
  }
}
