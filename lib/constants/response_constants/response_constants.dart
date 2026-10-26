class ResponseConstants {
  static const String message = "message";
  static const String status = "status";
  static const String code = "code";
  static const String token = "token";
  static const String data = "data";
  static const String accessToken = "accessToken";
  static const String user = "user";
  static const String id = "_id";
  static const String entityId = "id";
  static const String bio = "bio";
  static const String fullName = "fullName";
  static const String image = "image";
  static const String phoneNumber = "phoneNumber";
  static const String role = "role";
  static const String completedOrdersCount = "completedOrdersCount";
  static const String inProgressOrdersCount = "inProgressOrdersCount";
  static const String loyaltyPoints = "loyaltyPoints";
  static const String orderNumber = "orderNumber";
  static const String productName = "productName";
  static const String description = "description";
  static const String specialRequests = "specialRequests";
  static const String fabricType = "fabricType";
  static const String deliveryDate = "deliveryDate";
  static const String similarImages = "similarImages";
  static const String minExpectedBudget = "minExpectedBudget";
  static const String maxExpectedBudget = "maxExpectedBudget";
  static const String orderStatus = "status";
  static const String createdAt = "createdAt";
  static const String userName = "userName";
  static const String userImage = "userImage";
  static const String offersCount = "offersCount";

  // My Offers (offer list)
  static const String orderId = "orderId";
  static const String requesterImage = "requesterImage";
  static const String requesterName = "requesterName";
  static const String requesterDescription = "requesterDescription";
  static const String myOffer = "myOffer";
  static const String timeline = "timeline";
  static const String occurredAt = "occurredAt";
  static const String proposedPrice = "proposedPrice";
  static const String executionDays = "executionDays";
  static const String details = "details";
  static const String clientBudget = "clientBudget";
  static const String competitors = "competitors";

  // Forgot/Reset Password
  static const String userId = "userId";

  // Provider Register
  static const String requestId = "requestId";

  // Categories
  static const String name = "name";
  static const String updatedAt = "updatedAt";

  // Home endpoint
  static const String latestProducts = "latestProducts";
  static const String shops = "shops";
  static const String bestTailors = "bestTailors";
  static const String variantId = "variantId";
  static const String variantColor = "variantColor";
  static const String variantSize = "variantSize";
  static const String price = "price";
  static const String priceBeforeDiscount = "priceBeforeDiscount";
  static const String imageUrl = "imageUrl";
  static const String shopId = "shopId";
  static const String shopName = "shopName";
  static const String isBestSelling = "isBestSelling";
  static const String rating = "rating";
  static const String ratersCount = "ratersCount";
  static const String isAvailable = "isAvailable";
  static const String categoryId = "categoryId";
  static const String categoryName = "categoryName";
  static const String productsCount = "productsCount";
  static const String location = "location";
  static const String specializations = "specializations";
  static const String rankLabel = "rankLabel";
  static const String rank = "rank";
  static const String ordersCount = "ordersCount";
  static const String availableTailorsCount = "availableTailorsCount";
  static const String nearbyTailors = "nearbyTailors";
  static const String distanceKm = "distanceKm";
  static const String radiusKm = "radiusKm";

  // Cart response keys
  static const String cartItemId = 'cartItemId';
  static const String lineTotal = 'lineTotal';
  static const String subtotal = 'subtotal';
  static const String grandTotal = 'grandTotal';
  static const String grandTotalAfterDiscount = 'grandTotalAfterDiscount';
  static const String discountAmount = 'discountAmount';
  static const String couponCode = 'couponCode';
  static const String maxQuantity = 'maxQuantity';
  static const String productId = 'productId';

  // Checkout + Product Details response keys
  static const String paymentStatus = 'paymentStatus';
  static const String payment = 'payment';
  static const String paymentSessionId = 'paymentSessionId';
  static const String provider = 'provider';

  // Shops ads
  static const String ads = "ads";
  static const String linkUrl = "linkUrl";
  static const String adTitle = "title";
  static const String adSubtitle = "subtitle";

  // Top shops fields
  static const String coverImageUrl = "coverImageUrl";
  static const String categories = "categories";
  static const String products = "products";
  static const String address = "address";
  static const String productStatus = "status";
  static const String paymentUrl = 'paymentUrl';
  static const String invoiceUrl = 'invoiceUrl';
  static const String totalAmount = 'totalAmount';
  static const String itemsCount = 'itemsCount';
  static const String userLoyaltyPoints = 'userLoyaltyPoints';
  static const String orders = 'orders';

  // Shops list
  static const String items = "items";
  static const String total = "total";

  // Chat
  static const String userInfo = "userInfo";
  static const String lastMessage = "lastMessage";
  static const String latestOffer = "latestOffer";
  static const String unreadCount = "unreadCount";
  static const String hasUnread = "hasUnread";
  static const String tailor = "tailor";
  static const String tailorId = "tailorId";
  static const String conversationId = "conversationId";
  static const String senderId = "senderId";
  static const String senderType = "senderType";
  static const String content = "content";
  static const String hasMore = "hasMore";
  static const String nextCursor = "nextCursor";
  // Address
  static const String latitude = "latitude";
  static const String longitude = "longitude";
  static const String detailedDescription = "detailedDescription";

  // Provider login OTP
  static const String requiresVerification = "requiresVerification";
  static const String temporaryToken = "temporaryToken";

  // Loyalty
  static const String points = "points";
  static const String titleAr = "titleAr";
  static const String titleEn = "titleEn";
  static const String titleUr = "titleUr";
  static const String pointsRequired = "pointsRequired";
  static const String discountType = "discountType";
  static const String discountValue = "discountValue";
  static const String rewardId = "rewardId";
  static const String rewardTitleAr = "rewardTitleAr";
  static const String rewardTitleEn = "rewardTitleEn";
  static const String rewardTitleUr = "rewardTitleUr";

  // Shop Owner Products
  static const String variants = "variants";
  static const String color = "color";
  static const String hexCode = "hexCode";
  static const String colorHexCode = "colorHexCode";
  static const String size = "size";
  static const String quantity = "quantity";
  static const String careInstructions = "careInstructions";
  static const String features = "features";
  static const String deliveryTimeMin = "deliveryTimeMin";
  static const String deliveryTimeMax = "deliveryTimeMax";
  static const String images = "images";
  static const String sortOrder = "sortOrder";
  static const String category = "category";
  static const String nameAr = "nameAr";
  static const String nameEn = "nameEn";
  static const String nameUr = "nameUr";

  // Search
  static const String searchQuery = 'query';
  static const String counts = 'counts';
  static const String globalCounts = 'globalCounts';
  static const String results = 'results';
  static const String tailors = 'tailors';

  // Shop Details
  static const String isOpen = "isAvailable";

  // Customer Reviews
  static const String reviewId = "reviewId";
  static const String comment = "comment";
  static const String reviewer = "reviewer";
  static const String reviewerName = "reviewerName";
  static const String reviewerImage = "reviewerImage";
  static const String reviewType = "type";
  static const String limit = "limit";
  static const String offset = "offset";
  static const String summary = "summary";
  static const String totalReviews = "totalReviews";
  static const String averageRating = "averageRating";
  static const String ratingBreakdown = "ratingBreakdown";
  static const String fiveStars = "fiveStars";
  static const String fourStars = "fourStars";
  static const String threeStars = "threeStars";
  static const String twoStars = "twoStars";
  static const String oneStar = "oneStar";
  static const String productInsights = "productInsights";
  static const String pagination = "pagination";
  static const String shopStatus = "status";

  // Tailor Details
  static const String portfolio = "portfolio";

  // Shop Owner Home
  static const String shopOwnerShopStatus = "shopStatus";
  static const String withdrawableBalance = "withdrawableBalance";
  static const String lastLoginAt = "lastLoginAt";
  static const String reviews = "reviews";
  // static const String averageRating        = "averageRating";
  static const String reviewsCount = "reviewsCount";

  // My Orders (user)
  static const String orderType = "orderType";
  static const String stagesSummary = "stagesSummary";
  static const String stages = "stages";
  static const String stageKey = "key";
  static const String stageLabel = "label";
  static const String stageCompleted = "completed";
  static const String stageStatusDate = "statusDate";
  static const String totalStages = "totalStages";
  static const String completedStagesCount = "completedStagesCount";
  static const String incompleteStagesCount = "incompleteStagesCount";
  static const String acceptedByProviderId = "acceptedByProviderId";
  static const String acceptedByProviderName = "acceptedByProviderName";
  static const String zoqakData = "zoqak";
  static const String providerId = "providerId";
  static const String providerName = "providerName";
  static const String providerImage = "providerImage";
  static const String providerIsAvailable = "providerIsAvailable";
  static const String providerRank = "providerRank";
  static const String providerRankLabel = "providerRankLabel";
  static const String providerRating = "providerRating";
  static const String providerRatersCount = "providerRatersCount";
  static const String providerOffersCount = "providerOffersCount";
  static const String orderOffersCount = "orderOffersCount";
  static const String offers = "offers";
  static const String unitPrice = "unitPrice";

  // Wallet Transactions
  static const String pendingBalance = 'pendingBalance';
  static const String totalBalance = 'totalBalance';
  static const String typeLabel = 'typeLabel';
  static const String transactionType = 'type';
  static const String amount = 'amount';

  // Bank Account
  static const String bankName = 'bankName';
  static const String accountHolderName = 'accountHolderName';
  static const String accountNumber = 'accountNumber';
  static const String iban = 'iban';

  // Independent tailor home
  static const String buyerName = 'buyerName';
  static const String zoqakAvailableForOffersCount =
      'zoqakAvailableForOffersCount';

  // Comprehensive tailor home
  static const String isAcceptingOrders = 'isAcceptingOrders';
  static const String zoqakOrdersCount = 'zoqakOrdersCount';

  // Shop owner shop status
  static const String shopIsOpen = 'isOpen';
  static const String profile = 'profile';
  static const String dashboard = 'dashboard';
  static const String shop = 'shop';
  static const String email = 'email';

  // Comprehensive tailor orders
  static const String zoqakOrders = 'zoqakOrders';
  static const String shopOrders = 'shopOrders';

  // My accepted orders (independent tailor order tracking)
  static const String statusPayment = 'statusPayment';
  static const String userPhone = 'userPhone';
  static const String latestStatus = 'latestStatus';
  static const String deliveryDeadline = 'deliveryDeadline';
  static const String orderDate = 'orderDate';

  // Shop Owner Order Tracking
  static const String buyer = 'buyer';
  static const String seller = 'seller';
  static const String buyerId = 'buyerId';
  static const String totalPrice = 'totalPrice';

  // Comprehensive tailor order detail
  static const String source = 'source';
  static const String order = 'order';
  static const String requester = 'requester';
  static const String totalOffersOnOrder = 'totalOffersOnOrder';
  static const String offer = 'offer';

  // Notifications
  static const String notificationIsRead = 'isRead';
  static const String notificationReadAt = 'readAt';
  static const String notificationBody   = 'body';
  static const String notificationType   = 'type';
  static const String notificationTitle  = 'title';
}
