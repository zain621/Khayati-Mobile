import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/widgets/app_safe_area.dart';
import 'package:app_mobile/features/user/details_shop/domain/di/di.dart';
import 'package:app_mobile/features/user/details_shop/presentation/controller/shop_details_controller.dart';
import 'package:app_mobile/features/user/details_shop/presentation/widgets/details_shop_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DetailsShopScreen extends StatefulWidget {
  final String shopId;

  const DetailsShopScreen({super.key, required this.shopId});

  @override
  State<DetailsShopScreen> createState() => _DetailsShopScreenState();
}

class _DetailsShopScreenState extends State<DetailsShopScreen> {
  late ShopDetailsController _controller;

  @override
  void initState() {
    super.initState();
    initShopDetails(shopId: widget.shopId);
    _controller = Get.find<ShopDetailsController>();
  }

  @override
  void dispose() {
    disposeShopDetails();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: AppSafeArea(
        child: Scaffold(
          backgroundColor: ManagerColors.white,
          body: Obx(() {
            if (_controller.isLoading.value) {
              return const ShopDetailsLoadingBody();
            }
            return ShopDetailsLoadedBody(controller: _controller);
          }),
        ),
      ),
    );
  }
}
