import 'package:app_mobile/features/user/create_order/presentation/pages/create_order_screen.dart';
import 'package:app_mobile/features/user/home_user/presentation/controller/main_navigation_controller.dart';
import 'package:app_mobile/features/user/home_user/presentation/pages/home_user_screen.dart';
import 'package:app_mobile/features/user/all_products/presentation/pages/all_products_screen.dart';
import 'package:app_mobile/features/user/all_products/domain/di/di.dart'
    as all_products_di;
import 'package:app_mobile/features/user/chat/presentation/pages/user_conversations_screen.dart';
import 'package:app_mobile/features/user/home_user/presentation/widgets/home_bottom_nav.dart';
import 'package:app_mobile/features/user/my_oredrs/presentation/pages/my_orders_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Main Navigation Page - صفحة التنقل الرئيسية
/// Contains the bottom navigation with FAB and switches between pages
class MainNavigationPage extends GetView<MainNavigationController> {
  const MainNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure products DI is ready for the Products tab.
    all_products_di.initAllProducts();

    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        body: Obx(
          () => IndexedStack(
            index: controller.currentIndex.value,
            children: const [
              HomeUserScreen(),
              MyOrdersUserScreen(),
              AllProductsScreen(showBackButton: false),
              UserConversationsScreen(),
            ],
          ),
        ),
        bottomNavigationBar: Obx(
          () => HomeBottomNav(
            currentIndex: controller.currentIndex.value,
            onItemTapped: controller.onItemTapped,
            onFabTapped: () => _onFabPressed(context),
          ),
        ),
      ),
    );
  }

  void _onFabPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const CreateOrderScreen(),
      ),
    );
  }
}
