import 'package:flutter/painting.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/socket/chat_socket_service.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import 'package:app_mobile/features/user/home_user/presentation/controller/home_user_controller.dart';
import 'package:app_mobile/features/user/home_user/presentation/controller/main_navigation_controller.dart';
import 'package:app_mobile/features/user/home_user/presentation/controller/nearby_tailors_map_controller.dart';
import 'package:app_mobile/features/user/profile/presentation/controller/user_profile_controller.dart';
import 'package:app_mobile/features/user/profile/presentation/controller/update_user_profile_controller.dart';
import 'package:app_mobile/features/user/cart/presentation/controller/cart_controller.dart';
import 'package:app_mobile/features/user/loyalty/presentation/controller/loyalty_controller.dart';
import 'package:app_mobile/features/user/my_oredrs/presentation/controller/my_orders_controller.dart';
import 'package:app_mobile/features/user/my_oredrs/presentation/controller/order_details_controller.dart';
import 'package:app_mobile/features/user/chat/presentation/controller/user_conversations_controller.dart';
import 'package:app_mobile/features/user/chat/presentation/controller/user_chat_detail_controller.dart';
import 'package:app_mobile/features/user/search/presentation/controller/search_controller.dart'
    as user_search;
import 'package:app_mobile/features/user/all_shops/presentation/controller/all_shops_controller.dart';
import 'package:app_mobile/features/user/all_products/presentation/controller/all_products_controller.dart';
import 'package:app_mobile/features/user/shops/presentation/controller/shops_controller.dart';
import 'package:app_mobile/features/user/create_order/presentation/controller/create_order_controller.dart';
import 'package:app_mobile/features/user/product_details/presentation/controller/product_details_controller.dart';
import 'package:app_mobile/features/user/details_shop/presentation/controller/shop_details_controller.dart';
import 'package:app_mobile/features/user/tailor_details/presentation/controller/tailor_details_controller.dart';
import 'package:app_mobile/features/providers/common_features/profile/presentation/controller/provider_profile_controller.dart';
import 'package:app_mobile/features/providers/common_features/profile/presentation/controller/portfolio_controller.dart';
import 'package:app_mobile/features/providers/common_features/profile/presentation/controller/update_provider_profile_controller.dart';
import 'package:app_mobile/features/providers/common_features/chat/presentation/controller/conversations_controller.dart';
import 'package:app_mobile/features/providers/common_features/chat/presentation/controller/chat_detail_controller.dart';
import 'package:app_mobile/features/providers/common_features/wallet/persentation/controller/wallet_controller.dart';
import 'package:app_mobile/features/providers/common_features/addresses/presentation/controller/address_controller.dart';
import 'package:app_mobile/features/providers/common_features/customer_reviews/presentation/controller/customer_reviews_controller.dart';
import 'package:app_mobile/features/providers/independent_tailor/home_independents_tailor/presentation/controller/independent_tailor_home_controller.dart';
import 'package:app_mobile/features/providers/independent_tailor/my_offers/presentation/controller/my_offers_controller.dart';
import 'package:app_mobile/features/providers/independent_tailor/order_tracking/presentation/controller/order_tracking_controller.dart';
import 'package:app_mobile/features/providers/independent_tailor/suggested_requests/presentation/controller/suggested_requests_controller.dart';
import 'package:app_mobile/features/providers/store_user/store_home_user/presentation/controller/shop_owner_home_controller.dart';
import 'package:app_mobile/features/providers/store_user/store_order_tracking/presentation/controller/store_order_tracking_controller.dart';
import 'package:app_mobile/features/providers/comprehensive_tailor/home_comprehensive_tailor/presentation/controller/comprehensive_home_controller.dart';
import 'package:app_mobile/features/providers/comprehensive_tailor/manager_products/presentation/controller/manager_products_controller.dart';
import 'package:app_mobile/features/providers/comprehensive_tailor/manager_products/presentation/controller/add_edit_product_controller.dart';
import 'package:app_mobile/features/providers/comprehensive_tailor/order_traking_comprehensive/presentation/controller/comprehensive_order_tracking_controller.dart';
import 'package:app_mobile/features/common/notfication/presentation/controller/notification_controller.dart';

/// Clears in-memory GetX controllers that hold the previous logged-in user's
/// data. Safe to call from inside a LoginController method (does not delete auth
/// controllers). Call on logout AFTER navigating to login, and again right
/// before opening home after a successful login.
void resetSessionControllers() {
  void del<T>() {
    if (Get.isRegistered<T>()) {
      Get.delete<T>(force: true);
    }
  }

  // Customer / shared
  del<MainNavigationController>();
  del<HomeUserController>();
  del<NearbyTailorsMapController>();
  del<UserProfileController>();
  del<UpdateUserProfileController>();
  del<CartController>();
  del<LoyaltyController>();
  del<MyOrdersController>();
  del<OrderDetailsController>();
  del<UserConversationsController>();
  del<UserChatDetailController>();
  del<user_search.SearchController>();
  del<AllShopsController>();
  del<AllProductsController>();
  del<ShopsController>();
  del<CreateOrderController>();
  del<ProductDetailsController>();
  del<ShopDetailsController>();
  del<TailorDetailsController>();
  del<NotificationController>();

  // Provider shared
  del<ProviderProfileController>();
  del<PortfolioController>();
  del<UpdateProviderProfileController>();
  del<ConversationsController>();
  del<ChatDetailController>();
  del<WalletController>();
  del<AddressController>();
  del<CustomerReviewsController>();

  // Independent
  del<IndependentTailorHomeController>();
  del<MyOffersController>();
  del<OrderTrackingController>();
  del<SuggestedRequestsController>();

  // Shop owner
  del<ShopOwnerHomeController>();
  del<StoreOrderTrackingController>();

  // Comprehensive
  del<ComprehensiveHomeController>();
  del<ManagerProductsController>();
  del<AddEditProductController>();
  del<ComprehensiveOrderTrackingController>();
}

/// Wipes prefs auth keys, chat socket, and image/disk caches.
/// Does NOT delete GetX controllers — call [resetSessionControllers] after
/// navigation so we never delete the controller that is currently running.
Future<void> clearLocalAuthArtifacts() async {
  try {
    instance<ChatSocketService>().disconnect();
  } catch (_) {}

  await instance<AppSettingsPrefs>().clearAuthData();

  PaintingBinding.instance.imageCache.clear();
  PaintingBinding.instance.imageCache.clearLiveImages();
  try {
    await DefaultCacheManager().emptyCache();
  } catch (_) {}
}

/// Full logout cleanup helper (prefs + caches + controllers).
Future<void> clearLocalSession() async {
  await clearLocalAuthArtifacts();
  resetSessionControllers();
}
