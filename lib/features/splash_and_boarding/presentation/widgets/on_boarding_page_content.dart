import 'package:flutter/material.dart';
import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_font_size.dart';
import '../../../../core/resources/manager_height.dart';
import '../../../../core/resources/manager_styles.dart';
import '../../../../core/resources/manager_width.dart';

/// Displays the onboarding page content: image, title, and subtitle.
/// Includes fade + slide entrance animations on each page change.
class OnBoardingPageContent extends StatefulWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const OnBoardingPageContent({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  @override
  State<OnBoardingPageContent> createState() => _OnBoardingPageContentState();
}

class _OnBoardingPageContentState extends State<OnBoardingPageContent>
    with TickerProviderStateMixin {
  late final AnimationController _imageController;
  late final AnimationController _textController;

  late final Animation<double> _imageFade;
  late final Animation<Offset> _imageSlide;
  late final Animation<double> _titleFade;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _subtitleFade;
  late final Animation<Offset> _subtitleSlide;

  @override
  void initState() {
    super.initState();

    _imageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _imageFade = CurvedAnimation(
      parent: _imageController,
      curve: Curves.easeOut,
    );
    _imageSlide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _imageController,
      curve: Curves.easeOutCubic,
    ));

    _titleFade = CurvedAnimation(
      parent: _textController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );
    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
    ));

    _subtitleFade = CurvedAnimation(
      parent: _textController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
    );
    _subtitleSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
    ));

    _imageController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _textController.forward();
    });
  }

  @override
  void dispose() {
    _imageController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image section with animation
        Expanded(
          flex: 5,
          child: SlideTransition(
            position: _imageSlide,
            child: FadeTransition(
              opacity: _imageFade,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(ManagerHeight.h12),
                  child: Image.asset(
                    widget.imagePath,
                    fit: BoxFit.contain,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: ManagerHeight.h24),

        // Text section with staggered animation
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w32),
            child: Column(
              children: [
                SlideTransition(
                  position: _titleSlide,
                  child: FadeTransition(
                    opacity: _titleFade,
                    child: Text(
                      widget.title,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s14,
                        color: ManagerColors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: ManagerHeight.h12),
                SlideTransition(
                  position: _subtitleSlide,
                  child: FadeTransition(
                    opacity: _subtitleFade,
                    child: Text(
                      widget.subtitle,
                      style: getRegularTextStyle(
                        fontSize: ManagerFontSize.s12,
                        color: ManagerColors.greyWhiteColor,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
