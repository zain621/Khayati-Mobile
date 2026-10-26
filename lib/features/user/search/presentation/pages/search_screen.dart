import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/widgets/app_safe_area.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../domain/di/di.dart' as search_di;
import '../controller/search_controller.dart';
import '../widgets/search_widgets.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// ── Entry Point
// ═══════════════════════════════════════════════════════════════════════════════

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchController _controller;

  @override
  void initState() {
    super.initState();
    search_di.initSearch();
    _controller = Get.find<SearchController>();
  }

  @override
  void dispose() {
    search_di.disposeSearch();
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
          backgroundColor: ManagerColors.backgroundTabBar,
          body: Column(
            children: [
              SearchHeaderWidget(controller: _controller),
              Expanded(
                child: Obx(() => AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      switchInCurve: Curves.easeOut,
                      switchOutCurve: Curves.easeIn,
                      child: _controller.hasQuery
                          ? SearchResultsView(
                              key: const ValueKey('results'),
                              controller: _controller,
                            )
                          : SearchHistoryView(
                              key: const ValueKey('history'),
                              controller: _controller,
                            ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
