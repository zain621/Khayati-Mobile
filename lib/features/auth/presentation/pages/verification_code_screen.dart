import 'dart:async';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/resources/manager_width.dart';
import '../../../../core/widgets/base_auth_scaffold.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import '../../../../core/widgets/button_app.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../controller/forgot_password_controller.dart';
import '../widgets/auth_back_button.dart';
import '../widgets/auth_footer_row.dart';
import 'package:pinput/pinput.dart';

/// Verification code entry screen (UI only).
class VerificationCodeScreen extends StatefulWidget {
  final String? phoneNumber;

  const VerificationCodeScreen({
    super.key,
    this.phoneNumber,
  });

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  // ignore: unused_field
  bool _isCodeComplete = false; // tracks completion for UI state

  late ForgotPasswordController _fpController;

  /// Countdown timer state
  late Timer _timer;
  int _remainingSeconds = 185; // 03:05
  bool _canResend = false;

  /// Animations
  late AnimationController _animController;
  late Animation<double> _fadeTitle;
  late Animation<Offset> _slideTitle;
  late Animation<double> _fadeSubtitle;
  late Animation<Offset> _slideSubtitle;
  late Animation<double> _fadePin;
  late Animation<Offset> _slidePin;
  late Animation<double> _fadeButton;
  late Animation<Offset> _slideButton;

  @override
  void initState() {
    super.initState();
    _fpController = Get.find<ForgotPasswordController>();
    _startTimer();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeTitle = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: const Interval(0.0, 0.4, curve: Curves.easeOut)),
    );
    _slideTitle = Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(parent: _animController, curve: const Interval(0.0, 0.4, curve: Curves.easeOut)),
    );

    _fadeSubtitle = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: const Interval(0.15, 0.5, curve: Curves.easeOut)),
    );
    _slideSubtitle = Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(parent: _animController, curve: const Interval(0.15, 0.5, curve: Curves.easeOut)),
    );

    _fadePin = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: const Interval(0.3, 0.7, curve: Curves.easeOut)),
    );
    _slidePin = Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(parent: _animController, curve: const Interval(0.3, 0.7, curve: Curves.easeOut)),
    );

    _fadeButton = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: const Interval(0.5, 1.0, curve: Curves.easeOut)),
    );
    _slideButton = Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(parent: _animController, curve: const Interval(0.5, 1.0, curve: Curves.easeOut)),
    );

    _animController.forward();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        setState(() => _canResend = true);
        _timer.cancel();
      }
    });
  }

  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _resendCode() async {
    await _fpController.resendCode();
    setState(() {
      _remainingSeconds = 185;
      _canResend = false;
    });
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pinController.dispose();
    _focusNode.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: ManagerWidth.w70,
      height: ManagerHeight.h60,
      textStyle: getBoldTextStyle(
        fontSize: ManagerFontSize.s24,
        color: ManagerColors.black,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ManagerColors.greyWhiteColor.withOpacity(0.3),
          width: 1.5,
        ),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ManagerColors.primaryColor,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: ManagerColors.primaryColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: ManagerColors.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ManagerColors.primaryColor,
          width: 1.5,
        ),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.red,
          width: 1.5,
        ),
      ),
    );

    return Stack(
      children: [
        BaseAuthScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: ManagerHeight.h52),

          /// Back Button
          const AuthBackButton(),

          SizedBox(height: ManagerHeight.h40),

          /// Title
          FadeTransition(
            opacity: _fadeTitle,
            child: SlideTransition(
              position: _slideTitle,
              child: Text(
                ManagerStrings.verificationTitle,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s16,
                  color: ManagerColors.black,
                ),
              ),
            ),
          ),

          SizedBox(height: ManagerHeight.h12),

          /// Subtitle with phone number
          FadeTransition(
            opacity: _fadeSubtitle,
            child: SlideTransition(
              position: _slideSubtitle,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: ManagerStrings.verificationSubTitle1,
                      style: getRegularTextStyle(
                        fontSize: ManagerFontSize.s14,
                        color: ManagerColors.greyWhiteColor,
                      ),
                    ),
                    TextSpan(
                      text: '\n\n${widget.phoneNumber ?? "+971501234567"}',
                      style: getMediumTextStyle(
                        fontSize: ManagerFontSize.s14,
                        color: ManagerColors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: ManagerHeight.h100),

          /// PIN section with animations
          FadeTransition(
            opacity: _fadePin,
            child: SlideTransition(
              position: _slidePin,
              child: Column(
                children: [
                  /// Header Row above PIN
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ManagerStrings.verificationCodeLabel,
                        style: getBoldTextStyle(
                          fontSize: ManagerFontSize.s14,
                          color: ManagerColors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: _canResend ? _resendCode : null,
                        child: Text(
                          ManagerStrings.verificationResend,
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s14,
                            color: _canResend
                                ? ManagerColors.primaryColor
                                : ManagerColors.greyWhiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: ManagerHeight.h24),

                  /// PIN Input
                  Center(
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        controller: _pinController,
                        focusNode: _focusNode,
                        length: 6,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        submittedPinTheme: submittedPinTheme,
                        errorPinTheme: errorPinTheme,
                        separatorBuilder: (index) =>
                            SizedBox(width: ManagerWidth.w6),
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        cursor: Container(
                          width: 2,
                          height: ManagerHeight.h24,
                          color: ManagerColors.primaryColor,
                        ),
                        onCompleted: (pin) {
                          _isCodeComplete = true;
                        },
                        onChanged: (value) {
                          setState(() => _isCodeComplete = value.length == 6);
                        },
                        keyboardType: TextInputType.number,
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        showCursor: true,
                      ),
                    ),
                  ),

                  SizedBox(height: ManagerHeight.h24),

                  /// Resend timer row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ManagerStrings.verificationResendAfter,
                        style: getRegularTextStyle(
                          fontSize: ManagerFontSize.s12,
                          color: ManagerColors.greyWhiteColor,
                        ),
                      ),
                      Text(
                        _formatTime(_remainingSeconds),
                        style: getBoldTextStyle(
                          fontSize: ManagerFontSize.s14,
                          color: ManagerColors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: ManagerHeight.h72),

          /// Verify Button
          FadeTransition(
            opacity: _fadeButton,
            child: SlideTransition(
              position: _slideButton,
              child: ButtonApp(
                title: ManagerStrings.verificationVerifyButton,
                onPressed: () {
                  _fpController.verifyCode(_pinController.text);
                },
                paddingWidth: 0,
              ),
            ),
          ),

          const Spacer(),

          /// Footer
          AuthFooterRow(
            title: ManagerStrings.authFooterRememberPassword,
            titleButton: ManagerStrings.authFooterLogin,
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.loginScreen,
                (route) => false,
              );
            },
          ),

          SizedBox(height: ManagerHeight.h8),
        ],
      ),
        ),

        /// Loading overlay
        Obx(() {
          if (_fpController.isLoading.value) return const LoadingWidget();
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}
