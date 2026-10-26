import 'package:app_mobile/core/widgets/app_safe_area.dart';
import 'package:app_mobile/features/user/product_details/presentation/controller/product_details_controller.dart';
import 'package:app_mobile/features/user/product_details/presentation/widgets/product_details_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../domain/di/di.dart' as product_details_di;

class ProductDetailsScreen extends StatefulWidget {
  final String productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late ProductDetailsController _controller;
  final PageController _pageController = PageController();
  final RxInt _currentImageIndex = 0.obs;

  @override
  void initState() {
    super.initState();
    product_details_di.initProductDetails(productId: widget.productId);
    _controller = Get.find<ProductDetailsController>();
  }

  @override
  void dispose() {
    product_details_di.disposeProductDetails();
    _pageController.dispose();
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
          backgroundColor: const Color(0xFFF5F5F5),
          body: Obx(() {
            if (_controller.isLoading.value) {
              return ProductDetailsLoadingBody(
                onBack: () => Get.back(),
              );
            }
            return ProductDetailsLoadedBody(
              controller: _controller,
              pageController: _pageController,
              currentImageIndex: _currentImageIndex,
            );
          }),
        ),
      ),
    );
  }
}
