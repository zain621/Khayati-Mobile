import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../core/resources/manager_colors.dart';
import '../../../../../core/widgets/app_safe_area.dart';
import '../../domain/di/di.dart' as tailor_di;
import '../controller/tailor_details_controller.dart';
import '../widgets/tailor_details_widgets.dart';

class TailorDetailsScreen extends StatefulWidget {
  final String tailorId;

  const TailorDetailsScreen({super.key, required this.tailorId});

  @override
  State<TailorDetailsScreen> createState() => _TailorDetailsScreenState();
}

class _TailorDetailsScreenState extends State<TailorDetailsScreen> {
  late TailorDetailsController _controller;

  @override
  void initState() {
    super.initState();
    tailor_di.initTailorDetails(tailorId: widget.tailorId);
    _controller = Get.find<TailorDetailsController>();
  }

  @override
  void dispose() {
    tailor_di.disposeTailorDetails();
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
              return const TailorDetailsLoadingBody();
            }
            return TailorDetailsLoadedBody(controller: _controller);
          }),
        ),
      ),
    );
  }
}
