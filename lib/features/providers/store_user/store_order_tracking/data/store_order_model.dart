/// Status of a store order.
enum StoreOrderStatus { newOrder, inPreparation, readyForDelivery }

/// A single product item inside an order.
class StoreOrderProduct {
  final String name;
  final double price;
  final String size;
  final String color;
  final int quantity;

  const StoreOrderProduct({
    required this.name,
    required this.price,
    required this.size,
    required this.color,
    required this.quantity,
  });

  String get formattedPrice => '${price.toInt()} د.إ';
}

/// Represents one customer order from the store.
class StoreOrderModel {
  final String orderId;
  final String customerName;
  final String customerAvatar;
  final String customerPhone;
  final String orderDate;
  final String deliveryAddress;
  final StoreOrderStatus status;
  final List<StoreOrderProduct> products;

  const StoreOrderModel({
    required this.orderId,
    required this.customerName,
    required this.customerAvatar,
    required this.customerPhone,
    required this.orderDate,
    required this.deliveryAddress,
    required this.status,
    required this.products,
  });

  double get totalAmount =>
      products.fold(0.0, (sum, p) => sum + p.price * p.quantity);

  String get formattedTotal => '${totalAmount.toInt()} د.إ';
}

/// Mock data for UI development.
class StoreOrderMockData {
  static final List<StoreOrderModel> orders = [
    StoreOrderModel(
      orderId: 'ORD-2024-1234',
      customerName: 'نورة المطيري',
      customerAvatar: 'assets/images_remove/remove1.png',
      customerPhone: '+971 55 234 5678',
      orderDate: '2024-01-15 10:30',
      deliveryAddress: 'أبوظبي، جزيرة الريم، شارع النجمة، فيلا 45',
      status: StoreOrderStatus.newOrder,
      products: [
        StoreOrderProduct(
          name: 'عباية كلاسيكية سوداء',
          price: 450,
          size: 'M',
          color: 'أسود',
          quantity: 1,
        ),
      ],
    ),
    StoreOrderModel(
      orderId: 'ORD-2024-1235',
      customerName: 'فاطمة الزهراني',
      customerAvatar: 'assets/images_remove/remove1.png',
      customerPhone: '+971 55 234 5678',
      orderDate: '2024-01-15 09:15',
      deliveryAddress: 'أبوظبي، جزيرة الريم، شارع النجمة، فيلا 45',
      status: StoreOrderStatus.inPreparation,
      products: [
        StoreOrderProduct(
          name: 'عباية مطرزة بالذهبي',
          price: 690,
          size: 'L',
          color: 'بني',
          quantity: 1,
        ),
        StoreOrderProduct(
          name: 'شيلة حريرية',
          price: 100,
          size: 'واحد',
          color: 'بيج',
          quantity: 2,
        ),
      ],
    ),
    StoreOrderModel(
      orderId: 'ORD-2024-1233',
      customerName: 'فاطمة الزهراني',
      customerAvatar: 'assets/images_remove/remove1.png',
      customerPhone: '+971 55 234 5678',
      orderDate: '2024-01-15 09:15',
      deliveryAddress: 'أبوظبي، جزيرة الريم، شارع النجمة، فيلا 45',
      status: StoreOrderStatus.inPreparation,
      products: [
        StoreOrderProduct(
          name: 'عباية مطرزة بالذهبي',
          price: 690,
          size: 'L',
          color: 'بني',
          quantity: 1,
        ),
        StoreOrderProduct(
          name: 'شيلة حريرية',
          price: 100,
          size: 'واحد',
          color: 'بيج',
          quantity: 2,
        ),
      ],
    ),
    StoreOrderModel(
      orderId: 'ORD-2024-1230',
      customerName: 'سارة العتيبي',
      customerAvatar: 'assets/images_remove/remove1.png',
      customerPhone: '+971 50 112 3344',
      orderDate: '2024-01-14 14:00',
      deliveryAddress: 'دبي، مدينة محمد بن راشد، شارع الربوع، عمارة 12',
      status: StoreOrderStatus.readyForDelivery,
      products: [
        StoreOrderProduct(
          name: 'عباية سهرة مطرزة',
          price: 850,
          size: 'M',
          color: 'أسود',
          quantity: 1,
        ),
        StoreOrderProduct(
          name: 'وشاح حرير',
          price: 120,
          size: 'واحد',
          color: 'ذهبي',
          quantity: 1,
        ),
      ],
    ),
    StoreOrderModel(
      orderId: 'ORD-2024-1229',
      customerName: 'منى الشهري',
      customerAvatar: 'assets/images_remove/remove1.png',
      customerPhone: '+971 54 987 6543',
      orderDate: '2024-01-14 11:30',
      deliveryAddress: 'الشارقة، النهدة، شارع المجاز، برج 7، شقة 402',
      status: StoreOrderStatus.newOrder,
      products: [
        StoreOrderProduct(
          name: 'عباية يومية مخططة',
          price: 320,
          size: 'XL',
          color: 'رمادي',
          quantity: 1,
        ),
      ],
    ),
  ];
}
