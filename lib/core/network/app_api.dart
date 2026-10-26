import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../constants/env/env_constants.dart';
import '../../constants/request_constants/request_constants.dart';
import '../../constants/request_constants/request_constants_endpoints.dart';
import '../../features/auth/data/response/customer_register_response.dart';
import '../../features/auth/data/response/get_categories_response.dart';
import '../../features/auth/data/response/login_response.dart';
import '../../features/auth/data/response/provider_register_response.dart';
import '../../features/user/create_order/data/response/create_order_response.dart';
import '../../features/user/profile/data/response/update_user_profile_response.dart';
import '../../features/user/profile/data/response/user_profile_response.dart';
import '../../features/providers/common_features/profile/data/response/provider_profile_response.dart';
import '../../features/providers/common_features/profile/data/response/shop_owner_profile_response.dart';
import '../../features/providers/independent_tailor/suggested_requests/data/response/get_orders_response.dart';
import '../../features/providers/independent_tailor/suggested_requests/data/response/get_ct_orders_response.dart';
import '../../features/providers/independent_tailor/suggested_requests/data/response/submit_offer_response.dart';
import '../../features/providers/independent_tailor/my_offers/data/response/get_my_offers_response.dart';
import '../../features/providers/independent_tailor/my_offers/data/response/update_my_offer_response.dart';
import '../../features/providers/independent_tailor/my_offers/data/response/order_detail_response.dart';
import '../../features/auth/data/response/forgot_password_response.dart';
import '../../features/auth/data/response/verify_code_response.dart';
import '../../features/auth/data/response/reset_password_response.dart';
import '../../features/user/home_user/data/response/home_response.dart';
import '../../features/user/home_user/data/response/nearby_tailors_response.dart';
import '../../features/user/shops/data/response/get_shops_response.dart';
import '../../features/user/shops/data/response/get_top_shops_response.dart';
import '../../features/providers/common_features/chat/data/response/chat_offer_response.dart';
import '../../features/providers/common_features/chat/data/response/conversations_response.dart';
import '../../features/providers/common_features/chat/data/response/create_conversation_response.dart';
import '../../features/providers/common_features/chat/data/response/messages_response.dart';
import '../../features/providers/common_features/addresses/data/response/address_response.dart';
import '../../features/common/change_password/data/response/change_password_response.dart';
import '../../features/providers/comprehensive_tailor/manager_products/data/response/get_products_response.dart';
import '../../features/providers/comprehensive_tailor/manager_products/data/response/product_action_response.dart';
import '../../features/user/loyalty/data/response/loyalty_points_response.dart';
import '../../features/user/loyalty/data/response/loyalty_rewards_response.dart';
import '../../features/user/loyalty/data/response/redeem_loyalty_response.dart';
import '../../features/user/loyalty/data/response/unused_loyalty_codes_response.dart';
import '../../features/user/details_shop/data/response/shop_details_response.dart';
import '../../features/user/cart/data/response/cart_response.dart';
import '../../features/user/cart/data/response/checkout_response.dart';
import '../../features/user/product_details/data/response/product_details_response.dart';
import '../../features/user/tailor_details/data/response/tailor_details_response.dart';
import '../../features/user/my_oredrs/data/response/order_detail_response.dart';
import '../../features/user/my_oredrs/data/response/user_orders_response.dart';
import '../../features/user/my_oredrs/data/response/zoqak_offers_response.dart';
import '../../features/user/my_oredrs/data/response/accept_zoqak_offer_response.dart';
import '../../features/user/chat/data/response/accept_chat_offer_response.dart';
import '../../features/common/contact_us/data/response/contact_us_response.dart';
import '../../features/providers/store_user/store_home_user/data/response/shop_owner_home_response.dart';
import '../../features/providers/store_user/store_home_user/data/response/update_shop_owner_availability_response.dart';
import '../../features/providers/store_user/store_order_tracking/data/response/get_shop_owner_orders_response.dart';
import '../../features/providers/store_user/store_order_tracking/data/response/update_order_stage_response.dart';
import '../../features/providers/common_features/wallet/data/response/wallet_response.dart';
import '../../features/providers/common_features/wallet/data/response/transactions_response.dart';
import '../../features/providers/common_features/wallet/data/response/bank_account_response.dart';
import '../../features/providers/common_features/wallet/data/response/wallet_action_response.dart';
import '../../features/providers/common_features/profile/data/response/portfolio_response.dart';
import '../../features/providers/common_features/profile/data/response/update_provider_profile_response.dart';
import '../../features/providers/comprehensive_tailor/home_comprehensive_tailor/data/response/comprehensive_home_response.dart';
import '../../features/common/notfication/data/response/notification_response.dart';
import '../../features/providers/comprehensive_tailor/order_traking_comprehensive/data/response/comprehensive_orders_response.dart';
import '../../features/providers/comprehensive_tailor/order_traking_comprehensive/data/response/comprehensive_order_detail_response.dart';
import '../../features/providers/independent_tailor/home_independents_tailor/data/response/independent_tailor_home_response.dart';
import '../../features/user/search/data/response/search_response.dart';
import '../../features/user/search/data/response/search_history_response.dart';
import '../../features/providers/independent_tailor/order_tracking/data/response/order_tracking_response.dart';
import '../../features/providers/common_features/customer_reviews/data/response/get_independent_reviews_response.dart';
import '../../features/providers/common_features/customer_reviews/data/response/get_comprehensive_reviews_response.dart';
import '../../features/providers/common_features/customer_reviews/data/response/get_shop_owner_reviews_response.dart';
import '../../features/user/all_products/data/response/all_products_response.dart';
import '../service/env_service.dart';

part 'app_api.g.dart';

@RestApi()
abstract class AppService {
  factory AppService(Dio dio) {
    return _AppService(
      dio,
      baseUrl: EnvService.getString(
        key: EnvConstants.apiUrl,
      ),
    );
  }

  @POST(RequestConstantsEndpoints.login)
  Future<LoginResponse> login(
    @Field(RequestConstants.phoneNumber) String phoneNumber,
  );

  @GET(RequestConstantsEndpoints.userHome)
  Future<HomeResponse> getHome();

  @GET(RequestConstantsEndpoints.shopOwnerHome)
  Future<ShopOwnerHomeResponse> getShopOwnerHome();

  @PATCH(RequestConstantsEndpoints.shopOwnerAvailability)
  Future<UpdateShopOwnerAvailabilityResponse> updateShopOwnerAvailability(
    @Body() Map<String, dynamic> body,
  );

  @GET(RequestConstantsEndpoints.getShops)
  Future<GetShopsResponse> getShops();

  @GET(RequestConstantsEndpoints.getShops)
  Future<GetShopsResponse> getShopsPaginated(
    @Query('page') int page,
    @Query('per_page') int perPage,
    @Query('search') String? search,
    @Query('orderBy') String? orderBy,
  );

  @GET(RequestConstantsEndpoints.getAllProducts)
  Future<AllProductsResponse> getAllProducts(
    @Query('page') int page,
    @Query('per_page') int perPage,
    @Query('shopSearch') String? shopSearch,
  );

  @GET(RequestConstantsEndpoints.getTopShops)
  Future<GetTopShopsResponse> getTopShops(
    @Query('categoryIds') List<String>? categoryIds,
    @Query('page') int? page,
    @Query('limit') int? limit,
  );

  @POST(RequestConstantsEndpoints.customerRegisterStep1)
  Future<CustomerRegisterResponse> customerRegisterStep1(
    @Field(RequestConstants.fullName) String fullName,
    @Field(RequestConstants.phoneNumber) String phoneNumber,
  );

  @POST(RequestConstantsEndpoints.customerRegisterVerify)
  Future<LoginResponse> customerRegisterVerify(
    @Field(RequestConstants.phoneNumber) String phoneNumber,
    @Field(RequestConstants.code) String code,
  );

  @GET(RequestConstantsEndpoints.userProfile)
  Future<UserProfileResponse> getUserProfile();

  @PATCH(RequestConstantsEndpoints.userProfile)
  @MultiPart()
  Future<UpdateUserProfileResponse> updateUserProfile(
    @Part(name: RequestConstants.fullName) String fullName,
    @Part(name: RequestConstants.image) File? image,
  );

  @POST(RequestConstantsEndpoints.zoqak)
  @MultiPart()
  Future<CreateOrderResponse> createOrder(
    @Part(name: RequestConstants.productName) String productName,
    @Part(name: RequestConstants.description) String description,
    @Part(name: RequestConstants.specialRequests) String specialRequests,
    @Part(name: RequestConstants.fabricType) String fabricType,
    @Part(name: RequestConstants.deliveryDate) String deliveryDate,
    @Part(name: RequestConstants.minExpectedBudget) double minExpectedBudget,
    @Part(name: RequestConstants.maxExpectedBudget) double maxExpectedBudget,
    @Part(name: RequestConstants.similarImages)
    List<MultipartFile>? similarImages,
  );

  @POST(RequestConstantsEndpoints.providerRegister)
  Future<ProviderRegisterResponse> providerRegister(
    @Field(RequestConstants.role) String role,
    @Field(RequestConstants.businessName) String businessName,
    @Field(RequestConstants.ownerName) String ownerName,
    @Field(RequestConstants.phone) String phone,
    @Field(RequestConstants.city) String city,
    @Field(RequestConstants.latitude) String latitude,
    @Field(RequestConstants.longitude) String longitude,
    @Field(RequestConstants.detailedAddress) String detailedAddress,
    @Field(RequestConstants.yearsOfExperience) String yearsOfExperience,
    @Field(RequestConstants.bio) String bio,
    @Field('categoryIds') List<String> categoryIds, {
    @Field('agreementSignerName') String? agreementSignerName,
    @Field('agreementSignatureDataUrl') String? agreementSignatureDataUrl,
    @Field('agreementVersion') String? agreementVersion,
    @Field('agreementPayload') String? agreementPayload,
    @Field('email') String? email,
  });


  @GET(RequestConstantsEndpoints.getCategories)
  Future<GetCategoriesResponse> getCategories();

  // Provider profile endpoints (role-based)
  @GET(RequestConstantsEndpoints.independentTailorProfile)
  Future<ProviderProfileResponse> getIndependentTailorProfile();

  @GET(RequestConstantsEndpoints.comprehensiveTailorProfile)
  Future<ProviderProfileResponse> getComprehensiveTailorProfile();

  @GET(RequestConstantsEndpoints.shopOwnerShop)
  Future<ShopOwnerProfileResponse> getShopOwnerShop();

  // Suggested requests (orders) endpoints (role-based)
  @GET(RequestConstantsEndpoints.independentTailorOrders)
  Future<GetOrdersResponse> getIndependentTailorOrders();

  @GET(RequestConstantsEndpoints.comprehensiveTailorOrders)
  Future<GetCTOrdersResponse> getComprehensiveTailorOrders();

  @GET(RequestConstantsEndpoints.shopOwnerOrders)
  Future<GetOrdersResponse> getShopOwnerOrders();

  // Shop Owner Order Tracking
  @GET(RequestConstantsEndpoints.shopOwnerOrdersList)
  Future<GetShopOwnerOrdersResponse> getShopOwnerOrdersList();

  @PATCH(RequestConstantsEndpoints.shopOwnerOrderStage)
  Future<UpdateOrderStageResponse> updateShopOwnerOrderStage(
    @Path('orderId') String orderId,
    @Field(RequestConstants.stageKey) String stageKey,
  );

  // Comprehensive Tailor Order Tracking
  @GET(RequestConstantsEndpoints.comprehensiveTailorMyOrders)
  Future<ComprehensiveOrdersResponse> getComprehensiveTailorMyOrders();

  @GET(RequestConstantsEndpoints.comprehensiveTailorOrderDetail)
  Future<ComprehensiveOrderDetailResponse> getComprehensiveTailorOrderDetail(
    @Path('orderId') String orderId,
  );

  @PATCH(RequestConstantsEndpoints.comprehensiveTailorOrderStage)
  Future<UpdateOrderStageResponse> updateComprehensiveTailorOrderStage(
    @Path('orderId') String orderId,
    @Field(RequestConstants.stageKey) String stageKey,
  );

  @PATCH(RequestConstantsEndpoints.comprehensiveTailorZoqakOrderStatus)
  Future<UpdateOrderStatusResponse> updateComprehensiveTailorZoqakOrderStatus(
    @Path('orderId') String orderId,
    @Body() Map<String, dynamic> body,
  );

  @GET(RequestConstantsEndpoints.comprehensiveTailorZoqakMyOfferByOrder)
  Future<ZoqakMyOfferByOrderResponse> getComprehensiveTailorZoqakMyOfferByOrder(
    @Path('orderId') String orderId,
  );

  // Customer Reviews (role-based)
  @GET(RequestConstantsEndpoints.independentTailorReviews)
  Future<GetIndependentReviewsResponse> getIndependentTailorReviews();

  @GET(RequestConstantsEndpoints.comprehensiveTailorReviews)
  Future<GetComprehensiveReviewsResponse> getComprehensiveTailorReviews();

  @GET(RequestConstantsEndpoints.shopOwnerReviews)
  Future<GetShopOwnerReviewsResponse> getShopOwnerReviews();

  // Submit offer (independent tailor)
  @POST(RequestConstantsEndpoints.submitOffer)
  Future<SubmitOfferResponse> submitOffer(
    @Path('orderId') String orderId,
    @Field(RequestConstants.proposedPrice) double proposedPrice,
    @Field(RequestConstants.executionDays) int executionDays,
    @Field(RequestConstants.details) String details,
  );

  // Submit offer (comprehensive tailor)
  @POST(RequestConstantsEndpoints.comprehensiveTailorSubmitOffer)
  Future<SubmitOfferResponse> submitComprehensiveTailorOffer(
    @Path('orderId') String orderId,
    @Field(RequestConstants.proposedPrice) double proposedPrice,
    @Field(RequestConstants.executionDays) int executionDays,
    @Field(RequestConstants.details) String details,
  );

  // My offers (independent tailor)
  @GET(RequestConstantsEndpoints.myOffers)
  Future<GetMyOffersResponse> getIndependentMyOffers();

  @GET(RequestConstantsEndpoints.comprehensiveMyOffers)
  Future<GetMyOffersResponse> getComprehensiveMyOffers();

  @PATCH(RequestConstantsEndpoints.myOffersById)
  Future<UpdateMyOfferResponse> patchIndependentMyOffer(
    @Path(RequestConstants.offerId) String offerId,
    @Field(RequestConstants.proposedPrice) double proposedPrice,
    @Field(RequestConstants.executionDays) int executionDays,
    @Field(RequestConstants.details) String details,
  );

  @PATCH(RequestConstantsEndpoints.comprehensiveMyOffersById)
  Future<UpdateMyOfferResponse> patchComprehensiveMyOffer(
    @Path(RequestConstants.offerId) String offerId,
    @Field(RequestConstants.proposedPrice) double proposedPrice,
    @Field(RequestConstants.executionDays) int executionDays,
    @Field(RequestConstants.details) String details,
  );

  @DELETE(RequestConstantsEndpoints.myOffersById)
  Future<UpdateMyOfferResponse> deleteIndependentMyOffer(
    @Path(RequestConstants.offerId) String offerId,
  );

  @DELETE(RequestConstantsEndpoints.comprehensiveMyOffersById)
  Future<UpdateMyOfferResponse> deleteComprehensiveMyOffer(
    @Path(RequestConstants.offerId) String offerId,
  );

  @GET(RequestConstantsEndpoints.orderDetail)
  Future<OrderDetailResponse> getIndependentOrderDetail(
    @Path('orderId') String orderId,
  );

  @GET(RequestConstantsEndpoints.comprehensiveOrderDetail)
  Future<OrderDetailResponse> getComprehensiveOrderDetail(
    @Path('orderId') String orderId,
  );

  // Forgot / Reset Password
  @POST(RequestConstantsEndpoints.forgotPassword)
  Future<ForgotPasswordResponse> forgotPassword(
    @Field(RequestConstants.phoneNumber) String phoneNumber,
  );

  @POST(RequestConstantsEndpoints.verifyCode)
  Future<VerifyCodeResponse> verifyCode(
    @Field(RequestConstants.userId) String userId,
    @Field(RequestConstants.code) String code,
  );

  @POST(RequestConstantsEndpoints.resendCode)
  Future<ForgotPasswordResponse> resendCode(
    @Field(RequestConstants.phoneNumber) String phoneNumber,
  );

  @POST(RequestConstantsEndpoints.resetPassword)
  Future<ResetPasswordResponse> resetPassword(
    @Field(RequestConstants.userId) String userId,
    @Field(RequestConstants.newPassword) String newPassword,
  );

  // Chat
  @GET(RequestConstantsEndpoints.chatConversations)
  Future<ConversationsResponse> getConversations();

  @POST(RequestConstantsEndpoints.chatConversations)
  Future<CreateConversationResponse> createOrGetConversation(
    @Field(RequestConstants.tailorId) String tailorId,
    @Field(RequestConstants.userId) String userId,
  );

  @GET(RequestConstantsEndpoints.chatMessages)
  Future<MessagesResponse> getMessages(
    @Query(RequestConstants.conversationId) String conversationId,
  );

  @POST(RequestConstantsEndpoints.chatOffers)
  Future<ChatOfferResponse> createChatOffer(
    @Path('conversationId') String conversationId,
    @Body() Map<String, dynamic> body,
  );

  @PATCH(RequestConstantsEndpoints.chatOfferById)
  Future<ChatOfferResponse> updateChatOffer(
    @Path('conversationId') String conversationId,
    @Path('offerId') String offerId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE(RequestConstantsEndpoints.chatOfferById)
  Future<ChatOfferResponse> cancelChatOffer(
    @Path('conversationId') String conversationId,
    @Path('offerId') String offerId,
  );

  @POST(RequestConstantsEndpoints.acceptChatOffer)
  Future<AcceptChatOfferResponse> acceptChatOffer(
    @Path('conversationId') String conversationId,
    @Path('offerId') String offerId,
  );

  @POST(RequestConstantsEndpoints.rejectChatOffer)
  Future<ChatOfferResponse> rejectChatOffer(
    @Path('conversationId') String conversationId,
    @Path('offerId') String offerId,
  );

  // ── Address ─────────────────────────────────────────────────────────────

  @GET(RequestConstantsEndpoints.userAddress)
  Future<AddressResponse> getAddress();

  @POST(RequestConstantsEndpoints.userAddress)
  Future<AddressResponse> createAddress(
    @Field(RequestConstants.fullName) String fullName,
    @Field(RequestConstants.latitude) double latitude,
    @Field(RequestConstants.longitude) double longitude,
    @Field(RequestConstants.detailedDescription) String detailedDescription,
  );

  @PATCH(RequestConstantsEndpoints.userAddress)
  Future<AddressResponse> updateAddress(
    @Field(RequestConstants.fullName) String fullName,
    @Field(RequestConstants.latitude) double latitude,
    @Field(RequestConstants.longitude) double longitude,
    @Field(RequestConstants.detailedDescription) String detailedDescription,
  );

  // ── Change Password ────────────────────────────────────────────────────

  @PATCH(RequestConstantsEndpoints.changePassword)
  Future<ChangePasswordResponse> changePassword(
    @Body() Map<String, dynamic> body,
  );

  // ── Provider Login OTP ────────────────────────────────────────────────

  @POST(RequestConstantsEndpoints.completeLoginWithCode)
  Future<LoginResponse> completeLoginWithCode(
    @Field(RequestConstants.phoneNumber) String phoneNumber,
    @Field(RequestConstants.code) String code,
  );

  // ── Shop Owner Products ─────────────────────────────────────────────────

  @GET(RequestConstantsEndpoints.shopOwnerProducts)
  Future<GetProductsResponse> getShopOwnerProducts();

  @GET(RequestConstantsEndpoints.shopOwnerProductById)
  Future<GetProductDetailsResponse> getShopOwnerProductDetails(
    @Path(RequestConstants.productId) String productId,
  );

  @DELETE(RequestConstantsEndpoints.shopOwnerDeleteProduct)
  Future<ProductActionResponse> deleteShopOwnerProduct(
    @Path(RequestConstants.productId) String productId,
  );

  @PATCH(RequestConstantsEndpoints.shopOwnerActivateProduct)
  Future<ProductActionResponse> activateShopOwnerProduct(
    @Path(RequestConstants.productId) String productId,
  );

  @PATCH(RequestConstantsEndpoints.shopOwnerCancelProduct)
  Future<ProductActionResponse> cancelShopOwnerProduct(
    @Path(RequestConstants.productId) String productId,
  );

  @POST(RequestConstantsEndpoints.shopOwnerProductVariants)
  Future<ProductActionResponse> addVariantToProduct(
    @Path(RequestConstants.productId) String productId,
    @Body() Map<String, dynamic> body,
  );

  @PATCH(RequestConstantsEndpoints.shopOwnerProductVariantById)
  Future<ProductActionResponse> updateVariantInProduct(
    @Path(RequestConstants.productId) String productId,
    @Path(RequestConstants.variantIdPath) String variantId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE(RequestConstantsEndpoints.shopOwnerProductVariantById)
  Future<ProductActionResponse> deleteVariantFromProduct(
    @Path(RequestConstants.productId) String productId,
    @Path(RequestConstants.variantIdPath) String variantId,
  );

  @DELETE(RequestConstantsEndpoints.shopOwnerProductImageById)
  Future<ProductActionResponse> deleteShopOwnerProductImage(
    @Path(RequestConstants.productId) String productId,
    @Path(RequestConstants.imageIdPath) String imageId,
  );

  // ── Comprehensive Tailor Products ─────────────────────────────────────────

  @GET(RequestConstantsEndpoints.comprehensiveTailorProductsAll)
  Future<GetProductsResponse> getComprehensiveTailorProducts();

  @GET(RequestConstantsEndpoints.comprehensiveTailorProductById)
  Future<GetProductDetailsResponse> getComprehensiveTailorProductDetails(
    @Path(RequestConstants.productId) String productId,
  );

  @DELETE(RequestConstantsEndpoints.comprehensiveTailorDeleteProduct)
  Future<ProductActionResponse> deleteComprehensiveTailorProduct(
    @Path(RequestConstants.productId) String productId,
  );

  @PATCH(RequestConstantsEndpoints.comprehensiveTailorActivateProduct)
  Future<ProductActionResponse> activateComprehensiveTailorProduct(
    @Path(RequestConstants.productId) String productId,
  );

  @PATCH(RequestConstantsEndpoints.comprehensiveTailorCancelProduct)
  Future<ProductActionResponse> cancelComprehensiveTailorProduct(
    @Path(RequestConstants.productId) String productId,
  );

  @POST(RequestConstantsEndpoints.comprehensiveTailorProductVariants)
  Future<ProductActionResponse> addVariantToComprehensiveTailorProduct(
    @Path(RequestConstants.productId) String productId,
    @Body() Map<String, dynamic> body,
  );

  @PATCH(RequestConstantsEndpoints.comprehensiveTailorProductVariantById)
  Future<ProductActionResponse> updateVariantInComprehensiveTailorProduct(
    @Path(RequestConstants.productId) String productId,
    @Path(RequestConstants.variantIdPath) String variantId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE(RequestConstantsEndpoints.comprehensiveTailorProductVariantById)
  Future<ProductActionResponse> deleteVariantFromComprehensiveTailorProduct(
    @Path(RequestConstants.productId) String productId,
    @Path(RequestConstants.variantIdPath) String variantId,
  );

  @DELETE(RequestConstantsEndpoints.comprehensiveTailorProductImageById)
  Future<ProductActionResponse> deleteComprehensiveTailorProductImage(
    @Path(RequestConstants.productId) String productId,
    @Path(RequestConstants.imageIdPath) String imageId,
  );

  // ── Loyalty ──────────────────────────────────────────────────────────────

  @GET(RequestConstantsEndpoints.loyaltyPoints)
  Future<LoyaltyPointsResponse> getLoyaltyPoints();

  @GET(RequestConstantsEndpoints.loyaltyRewards)
  Future<LoyaltyRewardsResponse> getLoyaltyRewards();

  @POST(RequestConstantsEndpoints.loyaltyRedeem)
  Future<RedeemLoyaltyResponse> redeemLoyalty(
    @Field(RequestConstants.rewardId) String rewardId,
  );

  @GET(RequestConstantsEndpoints.loyaltyUnusedCodes)
  Future<UnusedLoyaltyCodesResponse> getLoyaltyUnusedCodes();

  @GET(RequestConstantsEndpoints.shopDetails)
  Future<ShopDetailsResponse> getShopDetails(
    @Path('shopId') String shopId,
  );

  // ── Cart ─────────────────────────────────────────────────────────────────

  @GET(RequestConstantsEndpoints.getCart)
  Future<CartResponse> getCart();

  @POST(RequestConstantsEndpoints.cartItems)
  Future<CartResponse> addCartItem(
    @Body() Map<String, dynamic> body,
  );

  @PATCH(RequestConstantsEndpoints.cartItem)
  Future<CartResponse> updateCartItem(
    @Path(RequestConstants.cartItemId) String cartItemId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE(RequestConstantsEndpoints.cartItem)
  Future<CartResponse> removeCartItem(
    @Path(RequestConstants.cartItemId) String cartItemId,
  );

  @POST(RequestConstantsEndpoints.cartCoupon)
  Future<CartResponse> applyCoupon(
    @Field(RequestConstants.couponCode) String code,
  );

  @DELETE(RequestConstantsEndpoints.cartCoupon)
  Future<CartResponse> removeCoupon();

  @POST(RequestConstantsEndpoints.checkout)
  Future<CheckoutResponse> checkout();

  // ── Product Details ───────────────────────────────────────────────────────

  @GET(RequestConstantsEndpoints.productDetails)
  Future<ProductDetailsResponse> getProductDetails(
    @Path('productId') String productId,
  );

  // ── Tailor Details ────────────────────────────────────────────────────────

  @GET(RequestConstantsEndpoints.tailorDetails)
  Future<TailorDetailsResponse> getTailorDetails(
    @Path('tailorId') String tailorId,
  );

  @GET(RequestConstantsEndpoints.nearbyTailors)
  Future<NearbyTailorsResponse> getNearbyTailors(
    @Query(RequestConstants.latitude) double latitude,
    @Query(RequestConstants.longitude) double longitude,
    @Query(RequestConstants.searchLimit) int limit,
  );

  // ── My Orders (user) ──────────────────────────────────────────────────────

  @GET(RequestConstantsEndpoints.userOrders)
  Future<UserOrdersResponse> getUserOrders();

  @GET(RequestConstantsEndpoints.userOrderDetail)
  Future<UserOrderDetailResponse> getUserOrderDetail(
    @Path('orderId') String orderId,
  );

  @GET(RequestConstantsEndpoints.zoqakOffers)
  Future<ZoqakOffersResponse> getZoqakOffers(
    @Path('orderId') String orderId,
  );

  @GET(RequestConstantsEndpoints.zoqakOrderDetail)
  Future<ZoqakOrderDetailResponse> getZoqakOrderDetail(
    @Path('orderId') String orderId,
  );

  @POST(RequestConstantsEndpoints.acceptZoqakOffer)
  Future<AcceptZoqakOfferResponse> acceptZoqakOffer(
    @Path('orderId') String orderId,
    @Path('offerId') String offerId,
  );

  // Contact Us
  @POST(RequestConstantsEndpoints.contactUs)
  Future<ContactUsResponse> contactUs(
    @Field(RequestConstants.name) String name,
    @Field(RequestConstants.email) String email,
    @Field(RequestConstants.subject) String subject,
    @Field(RequestConstants.message) String message,
  );

  // ── Wallet ───────────────────────────────────────────────────────────────

  @GET(RequestConstantsEndpoints.traderWallet)
  Future<WalletResponse> getTraderWallet();

  @GET(RequestConstantsEndpoints.traderWalletTransactions)
  Future<TransactionsResponse> getWalletTransactions();

  @GET(RequestConstantsEndpoints.traderBankAccounts)
  Future<BankAccountsResponse> getBankAccounts();

  @POST(RequestConstantsEndpoints.traderBankAccounts)
  Future<BankAccountActionResponse> addBankAccount(
    @Body() Map<String, dynamic> body,
  );

  @PATCH(RequestConstantsEndpoints.traderBankAccountById)
  Future<BankAccountActionResponse> updateBankAccount(
    @Path(RequestConstants.bankAccountIdPath) String bankAccountId,
    @Body() Map<String, dynamic> body,
  );

  @POST(RequestConstantsEndpoints.traderWalletWithdrawals)
  Future<WalletActionResponse> requestWithdrawal(
    @Body() Map<String, dynamic> body,
  );

  // ── Portfolio (independent tailor) ────────────────────────────────────────

  @POST(RequestConstantsEndpoints.independentTailorPortfolioImages)
  @MultiPart()
  Future<PortfolioActionResponse> addIndependentTailorPortfolioImages(
    @Part(name: RequestConstants.images) List<MultipartFile> images,
  );

  @DELETE(RequestConstantsEndpoints.independentTailorPortfolioImageById)
  Future<PortfolioActionResponse> deleteIndependentTailorPortfolioImage(
    @Path(RequestConstants.imageIdPath) String imageId,
  );

  @POST(RequestConstantsEndpoints.independentTailorPortfolioSpecializations)
  Future<PortfolioActionResponse> addIndependentTailorSpecialization(
    @Field(RequestConstants.name) String name,
  );

  @DELETE(
      RequestConstantsEndpoints.independentTailorPortfolioSpecializationById)
  Future<PortfolioActionResponse> deleteIndependentTailorSpecialization(
    @Path(RequestConstants.specializationIdPath) String specializationId,
  );

  // ── Portfolio (comprehensive tailor) ─────────────────────────────────────

  @POST(RequestConstantsEndpoints.comprehensiveTailorPortfolioImages)
  @MultiPart()
  Future<PortfolioActionResponse> addComprehensiveTailorPortfolioImages(
    @Part(name: RequestConstants.images) List<MultipartFile> images,
  );

  @DELETE(RequestConstantsEndpoints.comprehensiveTailorPortfolioImageById)
  Future<PortfolioActionResponse> deleteComprehensiveTailorPortfolioImage(
    @Path(RequestConstants.imageIdPath) String imageId,
  );

  @POST(RequestConstantsEndpoints.comprehensiveTailorPortfolioSpecializations)
  Future<PortfolioActionResponse> addComprehensiveTailorSpecialization(
    @Field(RequestConstants.name) String name,
  );

  @DELETE(
      RequestConstantsEndpoints.comprehensiveTailorPortfolioSpecializationById)
  Future<PortfolioActionResponse> deleteComprehensiveTailorSpecialization(
    @Path(RequestConstants.specializationIdPath) String specializationId,
  );

  // ── Update profile (tailor) ──────────────────────────────────────────────────

  @PATCH(RequestConstantsEndpoints.comprehensiveTailorProfile)
  @MultiPart()
  Future<UpdateProviderProfileResponse> updateComprehensiveTailorProfile(
    @Part(name: RequestConstants.fullName) String fullName,
    @Part(name: RequestConstants.bio) String? bio,
    @Part(name: RequestConstants.image) List<MultipartFile>? image,
  );

  @PATCH(RequestConstantsEndpoints.independentTailorProfile)
  @MultiPart()
  Future<UpdateProviderProfileResponse> updateIndependentTailorProfile(
    @Part(name: RequestConstants.fullName) String fullName,
    @Part(name: RequestConstants.bio) String? bio,
    @Part(name: RequestConstants.image) List<MultipartFile>? image,
  );

  // ── Independent tailor home ──────────────────────────────────────────────────

  @GET(RequestConstantsEndpoints.independentTailorHome)
  Future<IndependentTailorHomeResponse> getIndependentTailorHome();

  @PATCH(RequestConstantsEndpoints.independentTailorAvailability)
  Future<ChangeIndependentTailorAvailabilityResponse>
      changeIndependentTailorAvailability(
    @Body() Map<String, dynamic> body,
  );

  // ── Comprehensive tailor home ───────────────────────────────────────────────

  @GET(RequestConstantsEndpoints.comprehensiveTailorHome)
  Future<ComprehensiveHomeResponse> getComprehensiveTailorHome();

  @PATCH(RequestConstantsEndpoints.comprehensiveTailorAvailability)
  Future<ChangeAvailabilityResponse> changeComprehensiveTailorAvailability(
    @Body() Map<String, dynamic> body,
  );

  // ── Independent tailor accepted orders ─────────────────────────────────────

  @GET(RequestConstantsEndpoints.myAcceptedOrders)
  Future<MyOrdersResponse> getMyAcceptedOrders();

  @GET(RequestConstantsEndpoints.myAcceptedOrderById)
  Future<AcceptedOrderDetailResponse> getMyAcceptedOrderDetail(
    @Path('orderId') String orderId,
  );

  @PATCH(RequestConstantsEndpoints.updateOrderStatus)
  Future<UpdateOrderStatusResponse> updateOrderStatus(
    @Path('orderId') String orderId,
    @Body() Map<String, dynamic> body,
  );

  // ── Update shop (shop owner) ─────────────────────────────────────────────────

  @PATCH(RequestConstantsEndpoints.shopOwnerShop)
  @MultiPart()
  Future<UpdateProviderProfileResponse> updateShopOwnerShop(
    @Part(name: RequestConstants.nameAr) String nameAr,
    @Part(name: RequestConstants.nameEn) String nameEn,
    @Part(name: RequestConstants.bio) String? bio,
    @Part(name: RequestConstants.image) List<MultipartFile>? image,
    @Part(name: RequestConstants.coverImage) List<MultipartFile>? coverImage,
  );

  // ── Search ───────────────────────────────────────────────────────────────────

  @GET(RequestConstantsEndpoints.search)
  Future<SearchResponse> search(
    @Query(RequestConstants.searchQuery) String query,
    @Query(RequestConstants.searchType) String type,
  );

  @GET(RequestConstantsEndpoints.searchHistory)
  Future<SearchHistoryListResponse> getSearchHistory();

  @DELETE(RequestConstantsEndpoints.searchHistoryById)
  Future<void> deleteSearchHistoryItem(
    @Path(RequestConstants.historyId) String historyId,
  );

  @DELETE(RequestConstantsEndpoints.searchHistory)
  Future<void> clearSearchHistory();

  // ── Notifications ──────────────────────────────────────────────────────────

  @GET(RequestConstantsEndpoints.myNotifications)
  Future<NotificationListResponse> getMyNotifications(
    @Query(RequestConstants.notificationLimit) int limit,
    @Query(RequestConstants.notificationOffset) int offset,
  );

  @PATCH(RequestConstantsEndpoints.markNotificationRead)
  Future<MarkNotificationReadResponse> markNotificationAsRead(
    @Path(RequestConstants.notificationIdPath) String notificationId,
  );
}
