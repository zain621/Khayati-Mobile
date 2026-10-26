import 'package:get/get.dart';

/// Navigation Tab Indices — matches MainNavigationPage IndexedStack.
class NavIndex {
  static const int home = 0;
  static const int orders = 1;
  static const int products = 2;
  static const int messages = 3;
}

/// Main Navigation Controller - متحكم التنقل الرئيسي
/// Manages bottom navigation state only.
class MainNavigationController extends GetxController {
  final currentIndex = NavIndex.home.obs;

  void onItemTapped(int index) {
    if (currentIndex.value == index) return;
    currentIndex.value = index;
  }

  void goToTab(int index) {
    onItemTapped(index);
  }

  void goToHome() => goToTab(NavIndex.home);

  void goToOrders() => goToTab(NavIndex.orders);

  void goToProducts() => goToTab(NavIndex.products);

  void goToMessages() => goToTab(NavIndex.messages);
}
