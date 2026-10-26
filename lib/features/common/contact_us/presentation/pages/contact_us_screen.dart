import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_images.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/app_safe_area.dart';
import 'package:app_mobile/core/widgets/button_app.dart';
import 'package:app_mobile/core/widgets/custom_appbar.dart';
import 'package:app_mobile/core/widgets/labeled_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../domain/di/di.dart';
import '../controller/contact_us_controller.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Contact Us Screen — تواصل معنا
// ─────────────────────────────────────────────────────────────────────────────

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  final _nameController    = TextEditingController();
  final _emailController   = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initContactUs();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 950),
    )..forward();
  }

  @override
  void dispose() {
    disposeContactUs();
    _controller.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // ── Staggered helpers ──────────────────────────────────────────────────────
  Animation<double> _interval(double start, double end) => CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.easeOutCubic),
      );

  Widget _fadeSlide(
    Widget child, {
    required double start,
    required double end,
    Offset from = const Offset(0, 0.18),
  }) {
    final anim = _interval(start, end);
    return FadeTransition(
      opacity: anim,
      child: SlideTransition(
        position: Tween<Offset>(begin: from, end: Offset.zero).animate(anim),
        child: child,
      ),
    );
  }

  // ── Build ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: AppSafeArea(
        child: Scaffold(
          backgroundColor: ManagerColors.white,
          body: Column(
            children: [
              // ── Header ─────────────────────────────────────────────────────
              CustomAppBar(
                title: ManagerStrings.contactUsTitle,
                subtitle: ManagerStrings.contactUsSubtitle,
                showBackButton: true,
                onBackPressed: () => Navigator.pop(context),
              ),

              // ── Scrollable body ────────────────────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: ManagerWidth.w16,
                    vertical: ManagerHeight.h20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Contact info cards ──────────────────────────────────
                      _fadeSlide(
                        _ContactInfoRow(),
                        start: 0.0,
                        end: 0.45,
                        from: const Offset(0, 0.14),
                      ),

                      SizedBox(height: ManagerHeight.h20),

                      // ── Send message form card ──────────────────────────────
                      _fadeSlide(
                        _SendMessageCard(
                          nameController: _nameController,
                          emailController: _emailController,
                          subjectController: _subjectController,
                          messageController: _messageController,
                        ),
                        start: 0.2,
                        end: 0.65,
                      ),

                      SizedBox(height: ManagerHeight.h20),

                      // ── Submit button ───────────────────────────────────────
                      _fadeSlide(
                        Obx(() {
                          final ctrl = Get.find<ContactUsController>();
                          if (ctrl.isSubmitting.value) {
                            return SizedBox(
                              height: ManagerHeight.h46,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          return ButtonApp(
                            title: ManagerStrings.contactUsSendButton,
                            onPressed: () => ctrl.submitContactUs(
                              name: _nameController.text.trim(),
                              email: _emailController.text.trim(),
                              subject: _subjectController.text.trim(),
                              message: _messageController.text.trim(),
                            ),
                            paddingWidth: 0,
                          );
                        }),
                        start: 0.45,
                        end: 0.80,
                        from: const Offset(0, 0.12),
                      ),

                      SizedBox(height: ManagerHeight.h16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Contact Info Row — two cards side by side
// ══════════════════════════════════════════════════════════════════════════════

class _ContactInfoRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ContactCard(
            icon: Icons.email_outlined,
            value: ManagerStrings.contactUsEmail,
            label: ManagerStrings.contactUsEmailLabel,
          ),
        ),
        SizedBox(width: ManagerWidth.w12),
        Expanded(
          child: _ContactCard(
            icon: Icons.phone_outlined,
            value: ManagerStrings.contactUsPhone,
            label: ManagerStrings.contactUsPhoneLabel,
          ),
        ),
      ],
    );
  }
}

class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _ContactCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
        boxShadow: [
          BoxShadow(
            color: ManagerColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background fabric pattern
          Positioned(
            top: 0,
            left: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ManagerRadius.r16),
                bottomLeft: Radius.circular(ManagerRadius.r16),
              ),
              child: Opacity(
                opacity: 0.6,
                child: Image.asset(
                  ManagerImages.updateProfileBackground,
                  height: ManagerHeight.h80,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // Content
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: ManagerHeight.h18,
                horizontal: ManagerWidth.w12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon badge
                  Container(
                    width: ManagerWidth.w42,
                    height: ManagerHeight.h42,
                    decoration: BoxDecoration(
                      color: ManagerColors.primaryColor.withOpacity(0.09),
                      borderRadius: BorderRadius.circular(ManagerRadius.r12),
                    ),
                    child: Icon(
                      icon,
                      color: ManagerColors.primaryColor,
                      size: ManagerFontSize.s20,
                    ),
                  ),
                  SizedBox(height: ManagerHeight.h10),
                  // Value
                  Text(
                    value,
                    style: getMediumTextStyle(
                      fontSize: ManagerFontSize.s11,
                      color: ManagerColors.black,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: ManagerHeight.h4),
                  // Label
                  Text(
                    label,
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s10,
                      color: ManagerColors.greyWhiteColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Send Message Form Card
// ══════════════════════════════════════════════════════════════════════════════

class _SendMessageCard extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController subjectController;
  final TextEditingController messageController;

  const _SendMessageCard({
    required this.nameController,
    required this.emailController,
    required this.subjectController,
    required this.messageController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
        boxShadow: [
          BoxShadow(
            color: ManagerColors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background fabric pattern
          Align(
            alignment: Alignment.topLeft,
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                ManagerImages.updateProfileBackground,
                fit: BoxFit.contain,
                height: ManagerHeight.h100,
              ),
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w16,
              vertical: ManagerHeight.h16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Section title ─────────────────────────────────────────
                Row(
                  children: [
                    Icon(
                      Icons.send_rounded,
                      size: ManagerFontSize.s16,
                      color: ManagerColors.primaryColor,
                    ),
                    SizedBox(width: ManagerWidth.w6),
                    Text(
                      ManagerStrings.contactUsSendSection,
                      style: getMediumTextStyle(
                        fontSize: ManagerFontSize.s13,
                        color: ManagerColors.primaryColor,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: ManagerHeight.h16),

                // ── Form fields ───────────────────────────────────────────
                LabeledTextField(
                  label: ManagerStrings.contactUsNameLabel,
                  hintText: ManagerStrings.contactUsNameHint,
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  paddingWidth: 0,
                ),
                SizedBox(height: ManagerHeight.h12),
                LabeledTextField(
                  label: ManagerStrings.contactUsEmailFieldLabel,
                  hintText: ManagerStrings.contactUsEmailFieldHint,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  paddingWidth: 0,
                ),
                SizedBox(height: ManagerHeight.h12),
                LabeledTextField(
                  label: ManagerStrings.contactUsSubjectLabel,
                  hintText: ManagerStrings.contactUsSubjectHint,
                  controller: subjectController,
                  paddingWidth: 0,
                ),
                SizedBox(height: ManagerHeight.h12),
                LabeledTextField(
                  label: ManagerStrings.contactUsMessageLabel,
                  hintText: ManagerStrings.contactUsMessageHint,
                  controller: messageController,
                  maxLines: 4,
                  minLines: 4,
                  paddingWidth: 0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


