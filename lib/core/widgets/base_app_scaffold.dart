import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/widgets/app_safe_area.dart';
import 'package:app_mobile/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseAppScaffold extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Future<void> Function()? onRefresh;
  /// When [false] the child is placed directly inside [Expanded] without any
  /// wrapping [SingleChildScrollView]. Use this when the child manages its
  /// own scrolling (e.g. a [CustomScrollView]).
  final bool useScrollView;

  const BaseAppScaffold({
    super.key,
    required this.title,
    this.subtitle,
    required this.child,
    this.showBackButton = true,
    this.onBackPressed,
    this.onRefresh,
    this.useScrollView = true,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: AppSafeArea(
        child: Scaffold(
          backgroundColor: ManagerColors.white,
          extendBody: true,
          body: Column(
            children: [
              CustomAppBar(
                title: title,
                subtitle: subtitle,
                showBackButton: showBackButton,
                onBackPressed: onBackPressed,
              ),
              Expanded(
                child: !useScrollView
                    ? child
                    : onRefresh != null
                        ? RefreshIndicator(
                            onRefresh: onRefresh!,
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: child,
                            ),
                          )
                        : SingleChildScrollView(
                            child: child,
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
