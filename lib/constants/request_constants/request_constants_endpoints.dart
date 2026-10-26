class RequestConstantsEndpoints {
  static const String login = '/auth/login';
  static const String customerRegisterStep1 = '/auth/register';
  static const String customerRegisterVerify = '/auth/register/verify';
  static const String userProfile = '/user/profile';
  static const String zoqak = '/zoqak';
  static const String providerRegister = '/auth/register/service-provider';
  static const String getCategories = '/admin/categories';

  // Provider profile endpoints (role-based)
  static const String independentTailorProfile = '/independent-tailor/profile';
  static const String comprehensiveTailorProfile =
      '/comprehensive-tailor/profile';
  static const String shopOwnerShop = '/shop-owner/shop';

  // Suggested requests (orders) endpoints (role-based)
  static const String independentTailorOrders = '/independent-tailor/orders';
  static const String comprehensiveTailorOrders =
      '/comprehensive-tailor/orders/zoqak/available-for-offers';
  static const String shopOwnerOrders = '/shop-owner/orders';

  // Shop Owner Order Tracking
  static const String shopOwnerOrdersList = '/shop-owner/orders';
  static const String shopOwnerOrderStage =
      '/shop-owner/orders/{orderId}/stage';

  // Submit offer endpoints
  static const String submitOffer =
      '/independent-tailor/zoqak/{orderId}/offers';
  static const String comprehensiveTailorSubmitOffer =
      '/comprehensive-tailor/zoqak/{orderId}/offers';

  // My offers (independent tailor)
  static const String myOffers = '/independent-tailor/zoqak/my-offers';
  static const String myOffersById =
      '/independent-tailor/zoqak/my-offers/{offerId}';
  static const String orderDetail = '/independent-tailor/zoqak/{orderId}';

  // My offers (comprehensive tailor)
  static const String comprehensiveMyOffers =
      '/comprehensive-tailor/zoqak/my-offers';
  static const String comprehensiveMyOffersById =
      '/comprehensive-tailor/zoqak/my-offers/{offerId}';
  static const String comprehensiveOrderDetail =
      '/comprehensive-tailor/zoqak/{orderId}';

  // Independent tailor home
  static const String independentTailorHome = '/independent-tailor/home';
  static const String independentTailorAvailability =
      '/independent-tailor/home/availability';

  // Independent tailor accepted orders (order tracking)
  static const String myAcceptedOrders =
      '/independent-tailor/zoqak/my-accepted-orders';
  static const String myAcceptedOrderById =
      '/independent-tailor/zoqak/my-accepted-orders/{orderId}';
  static const String updateOrderStatus =
      '/independent-tailor/zoqak/my-accepted-orders/{orderId}/status';

  // Comprehensive tailor home
  static const String comprehensiveTailorHome = '/comprehensive-tailor/home';
  static const String comprehensiveTailorAvailability =
      '/comprehensive-tailor/home/availability';

  // Comprehensive tailor order tracking
  static const String comprehensiveTailorMyOrders =
      '/comprehensive-tailor/orders/my-orders';
  static const String comprehensiveTailorOrderDetail =
      '/comprehensive-tailor/orders/{orderId}';
  static const String comprehensiveTailorOrderStage =
      '/comprehensive-tailor/orders/shop/{orderId}/stage';
  static const String comprehensiveTailorZoqakOrderStatus =
      '/comprehensive-tailor/orders/zoqak/{orderId}/status';
  static const String comprehensiveTailorZoqakMyOfferByOrder =
      '/comprehensive-tailor/zoqak/my-offers/by-order/{orderId}';

  // Forgot / Reset Password
  static const String userHome = '/home';

  static const String forgotPassword = '/auth/forgot-password';
  static const String verifyCode = '/auth/verify-code';
  static const String resendCode = '/auth/resend-code';
  static const String resetPassword = '/auth/reset-password';

  // Shops
  static const String getShops = '/shops';
  static const String getTopShops = '/shops/top';

  // Chat
  static const String chatConversations = '/chat/conversations';
  static const String chatMessages = '/chat/messages';
  static const String chatOffers =
      '/chat/conversations/{conversationId}/offers';
  static const String chatOfferById =
      '/chat/conversations/{conversationId}/offers/{offerId}';
  static const String acceptChatOffer =
      '/chat/conversations/{conversationId}/offers/{offerId}/accept';
  static const String rejectChatOffer =
      '/chat/conversations/{conversationId}/offers/{offerId}/reject';
  static const String userAddress = '/user/address';
  static const String changePassword = '/user/change-password';

  // Provider login OTP
  static const String completeLoginWithCode = '/auth/login/verify';

  // Shop Owner Products
  // All Products (user-facing)
  static const String getAllProducts = '/products';

  static const String shopOwnerProducts = '/shop-owner/products';
  static const String shopOwnerProductById = '/shop-owner/products/{productId}';
  static const String shopOwnerDeleteProduct =
      '/shop-owner/products/{productId}';
  static const String shopOwnerActivateProduct =
      '/shop-owner/products/{productId}/activate';
  static const String shopOwnerCancelProduct =
      '/shop-owner/products/{productId}/cancel';
  static const String shopOwnerProductVariants =
      '/shop-owner/products/{productId}/variants';
  static const String shopOwnerProductVariantById =
      '/shop-owner/products/{productId}/variants/{variantId}';
  static const String shopOwnerProductImageById =
      '/shop-owner/products/{productId}/images/{imageId}';

  // Comprehensive Tailor Products
  static const String comprehensiveTailorProductsAll =
      '/comprehensive-tailor/products';
  static const String comprehensiveTailorProductById =
      '/comprehensive-tailor/products/{productId}';
  static const String comprehensiveTailorDeleteProduct =
      '/comprehensive-tailor/products/{productId}';
  static const String comprehensiveTailorActivateProduct =
      '/comprehensive-tailor/products/{productId}/activate';
  static const String comprehensiveTailorCancelProduct =
      '/comprehensive-tailor/products/{productId}/cancel';
  static const String comprehensiveTailorProductVariants =
      '/comprehensive-tailor/products/{productId}/variants';
  static const String comprehensiveTailorProductVariantById =
      '/comprehensive-tailor/products/{productId}/variants/{variantId}';
  static const String comprehensiveTailorProductImageById =
      '/comprehensive-tailor/products/{productId}/images/{imageId}';

  // Loyalty
  static const String loyaltyPoints = '/user/loyalty/points';
  static const String loyaltyRewards = '/user/loyalty/rewards';
  static const String loyaltyRedeem = '/user/loyalty/redeem';
  static const String loyaltyUnusedCodes = '/user/loyalty/unused-codes';

  static const String shopDetails = '/shops/{shopId}';

  // Cart
  static const String getCart = '/user/cart';
  static const String cartItems = '/user/cart/items';
  static const String cartItem = '/user/cart/items/{cartItemId}';
  static const String cartCoupon = '/user/cart/coupon';
  static const String checkout = '/user/orders/checkout';

  // Product Details
  static const String productDetails = '/products/{productId}';

  // Tailor Details
  /// Full public tailor profile (independent + comprehensive).
  static const String tailorDetails = '/user/tailors/{tailorId}';
  static const String nearbyTailors = '/user/tailors/nearby';

  // Customer Reviews (role-based)
  static const String independentTailorReviews =
      '/independent-tailor/zoqak/my-reviews';
  static const String comprehensiveTailorReviews =
      '/comprehensive-tailor/orders/reviews';
  static const String shopOwnerReviews = '/shop-owner/orders/reviews';

  // My Orders (user)
  static const String userOrders = '/user/orders';
  static const String userOrderDetail = '/user/orders/{orderId}';
  static const String zoqakOrderDetail = '/zoqak/{orderId}';
  static const String zoqakOffers = '/zoqak/{orderId}/offers';
  static const String acceptZoqakOffer =
      '/zoqak/{orderId}/offers/{offerId}/accept';
  static const String paymentSessionStatus =
      '/user/orders/payments/{paymentSessionId}/status';

  // Contact Us
  static const String contactUs = '/user/contact-us';

  static const String shopOwnerHome = '/shop-owner/home';
  static const String shopOwnerAvailability = '/shop-owner/shop';

  // Auth
  static const String logout = '/auth/logout';
  static const String deleteAccountRequest = '/user/delete-account-request';

  // Wallet & Bank Accounts
  static const String traderWallet = '/trader/wallet';
  static const String traderWalletTransactions = '/trader/wallet/transactions';
  static const String traderWalletWithdrawals = '/trader/wallet/withdrawals';
  static const String traderBankAccounts = '/trader/wallet/bank-accounts';
  static const String traderBankAccountById =
      '/trader/wallet/bank-accounts/{bankAccountId}';

  // Portfolio (independent tailor)
  static const String independentTailorPortfolio =
      '/independent-tailor/portfolio';
  static const String independentTailorPortfolioImages =
      '/independent-tailor/portfolio/images';
  static const String independentTailorPortfolioImageById =
      '/independent-tailor/portfolio/{imageId}';
  static const String independentTailorPortfolioSpecializations =
      '/independent-tailor/portfolio/specializations';
  static const String independentTailorPortfolioSpecializationById =
      '/independent-tailor/portfolio/specializations/{specializationId}';

  // Portfolio (comprehensive tailor)
  static const String comprehensiveTailorPortfolio =
      '/comprehensive-tailor/portfolio';
  static const String comprehensiveTailorPortfolioImages =
      '/comprehensive-tailor/portfolio/images';
  static const String comprehensiveTailorPortfolioImageById =
      '/comprehensive-tailor/portfolio/{imageId}';
  static const String comprehensiveTailorPortfolioSpecializations =
      '/comprehensive-tailor/portfolio/specializations';
  static const String comprehensiveTailorPortfolioSpecializationById =
      '/comprehensive-tailor/portfolio/specializations/{specializationId}';

  // Search
  static const String search = '/search';
  static const String searchHistory = '/search/history';
  static const String searchHistoryById = '/search/history/{historyId}';

  // Notifications
  static const String myNotifications = '/notifications/my';
  static const String markNotificationRead =
      '/notifications/{notificationId}/read';
}
