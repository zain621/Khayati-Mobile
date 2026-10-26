import 'package:app_mobile/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/button_app.dart';
import 'package:app_mobile/core/widgets/custom_confirm_dialog.dart';
import 'package:app_mobile/core/widgets/labeled_text_field.dart';
import 'package:app_mobile/core/widgets/loading_widget.dart';
import 'package:app_mobile/features/providers/common_features/chat/presentation/controller/chat_detail_controller.dart';

/// Screen for creating/editing a custom offer to send in a chat.
class AddCustomOfferScreen extends StatefulWidget {
  final String conversationId;
  final String userName;
  final bool isEdit;
  final String? offerId;
  final String? existingTitle;
  final String? existingDescription;
  final double? existingPrice;
  final List<String>? existingAdditions;

  const AddCustomOfferScreen({
    super.key,
    required this.conversationId,
    required this.userName,
    this.isEdit = false,
    this.offerId,
    this.existingTitle,
    this.existingDescription,
    this.existingPrice,
    this.existingAdditions,
  });

  @override
  State<AddCustomOfferScreen> createState() => _AddCustomOfferScreenState();
}

class _AddCustomOfferScreenState extends State<AddCustomOfferScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  late final TextEditingController _titleController;
  late final TextEditingController _descController;
  late final TextEditingController _amountController;
  final TextEditingController _newAdditionController = TextEditingController();

  final FocusNode _titleFocus = FocusNode();
  final FocusNode _descFocus = FocusNode();
  final FocusNode _amountFocus = FocusNode();
  final FocusNode _additionFocus = FocusNode();

  List<String> _additions = [];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.existingTitle ?? '');
    _descController =
        TextEditingController(text: widget.existingDescription ?? '');
    _amountController = TextEditingController(
      text: widget.existingPrice != null
          ? widget.existingPrice!.toStringAsFixed(0)
          : '',
    );
    _additions = List<String>.from(widget.existingAdditions ?? []);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _amountController.dispose();
    _newAdditionController.dispose();
    _titleFocus.dispose();
    _descFocus.dispose();
    _amountFocus.dispose();
    _additionFocus.dispose();
    super.dispose();
  }

  void _addAddition() {
    final text = _newAdditionController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _additions.add(text);
      _newAdditionController.clear();
    });
  }

  void _removeAddition(int index) {
    setState(() => _additions.removeAt(index));
  }

  Future<void> _handleSubmit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final confirmed = await CustomConfirmDialog.show(
      context: context,
      title: ManagerStrings.addCustomOfferConfirmTitle,
      subtitle: ManagerStrings.addCustomOfferConfirmSubtitle,
      confirmText: ManagerStrings.addCustomOfferConfirmButton,
      cancelText: ManagerStrings.addCustomOfferCancelButton,
    );

    if (confirmed != true || !mounted) return;

    setState(() => _isLoading = true);

    final controller = Get.find<ChatDetailController>();
    final title = _titleController.text.trim();
    final description = _descController.text.trim();
    final amount = double.tryParse(_amountController.text.trim()) ?? 0;

    bool success;
    if (widget.isEdit && widget.offerId != null) {
      success = await controller.updateOffer(
        offerId: widget.offerId!,
        title: title,
        description: description,
        amount: amount,
        additions: _additions.isNotEmpty ? _additions : null,
      );
    } else {
      success = await controller.createOffer(
        title: title,
        description: description,
        amount: amount,
        additions: _additions.isNotEmpty ? _additions : null,
      );
    }

    if (mounted) {
      setState(() => _isLoading = false);
      if (success) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: ManagerColors.white,
            body: Column(
          children: [
            /// App bar
            CustomAppBar(
              title: ManagerStrings.addCustomOfferAppBarTitle,
              subtitle: ManagerStrings.addCustomOfferAppBarSubtitle,
              showBackButton: true,
            ),

            /// Form content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: ManagerHeight.h16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Card header
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ManagerWidth.w16),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(ManagerWidth.w16),
                          decoration: BoxDecoration(
                            color: ManagerColors.white,
                            borderRadius:
                                BorderRadius.circular(ManagerRadius.r12),
                            
                            boxShadow: [
                              BoxShadow(
                                color:
                                    ManagerColors.black.withOpacity(0.08),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Title row with icon
                              Row(
                                children: [
                                  Container(
                                    width: ManagerWidth.w36,
                                    height: ManagerHeight.h36,
                                    decoration: BoxDecoration(
                                      color: ManagerColors.primaryColor
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(
                                          ManagerRadius.r8),
                                    ),
                                    child: Icon(
                                      Icons.local_offer_rounded,
                                      color: ManagerColors.primaryColor,
                                      size: ManagerWidth.w20,
                                    ),
                                  ),
                                  SizedBox(width: ManagerWidth.w10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ManagerStrings
                                              .addCustomOfferCardTitle,
                                          style: getBoldTextStyle(
                                            fontSize:
                                                ManagerFontSize.s14,
                                            color: ManagerColors
                                                .primaryColor,
                                          ),
                                        ),
                                        SizedBox(
                                            height: ManagerHeight.h4),
                                        Text(
                                          ManagerStrings
                                              .addCustomOfferCardSubtitle,
                                          style: getRegularTextStyle(
                                            fontSize:
                                                ManagerFontSize.s11,
                                            color: ManagerColors
                                                .greyWhiteColor,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: ManagerHeight.h20),

                              /// Offer title field
                              LabeledTextField(
                                label:
                                    ManagerStrings.addCustomOfferTitleLabel,
                                hintText:
                                    ManagerStrings.addCustomOfferTitleHint,
                                controller: _titleController,
                                focusNode: _titleFocus,
                                nextFocusNode: _descFocus,
                                textInputAction: TextInputAction.next,
                                paddingWidth: 0,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return ManagerStrings.addCustomOfferValidateTitle;
                                  }
                                  return null;
                                },
                              ),

                              SizedBox(height: ManagerHeight.h16),

                              /// Description field
                              LabeledTextField(
                                label:
                                    ManagerStrings.addCustomOfferDescLabel,
                                hintText:
                                    ManagerStrings.addCustomOfferDescHint,
                                controller: _descController,
                                focusNode: _descFocus,
                                nextFocusNode: _amountFocus,
                                textInputAction: TextInputAction.next,
                                minLines: 4,
                                maxLines: 6,
                                paddingWidth: 0,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return ManagerStrings.addCustomOfferValidateDesc;
                                  }
                                  return null;
                                },
                              ),

                              SizedBox(height: ManagerHeight.h16),

                              /// Amount field with currency icon
                              LabeledTextField(
                                label: ManagerStrings
                                    .addCustomOfferAmountLabel,
                                hintText: ManagerStrings
                                    .addCustomOfferAmountHint,
                                controller: _amountController,
                                focusNode: _amountFocus,
                                nextFocusNode: _additionFocus,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                paddingWidth: 0,
                                buttonWidget: Icon(
                                  Icons.currency_exchange,
                                  color: ManagerColors.white,
                                  size: ManagerWidth.w16,
                                ),
                                onButtonTap: () {},
                                widthButton: ManagerWidth.w48,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return ManagerStrings.addCustomOfferValidateAmount;
                                  }
                                  final amount = double.tryParse(value);
                                  if (amount == null || amount <= 0) {
                                    return ManagerStrings.addCustomOfferValidateAmount;
                                  }
                                  return null;
                                },
                              ),

                              SizedBox(height: ManagerHeight.h16),

                              /// Additions section
                              Row(
                                children: [
                                  Text(
                                    ManagerStrings.addCustomOfferAdditionsLabel,
                                    style: getBoldTextStyle(
                                      fontSize: ManagerFontSize.s13,
                                      color: ManagerColors.black,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: ManagerHeight.h8),

                              /// Addition input row
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: ManagerHeight.h44,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF5F5F5),
                                        borderRadius: BorderRadius.circular(
                                            ManagerRadius.r10),
                                      ),
                                      child: TextField(
                                        controller: _newAdditionController,
                                        focusNode: _additionFocus,
                                        textDirection: Directionality.of(context),
                                        textInputAction: TextInputAction.done,
                                        onSubmitted: (_) => _addAddition(),
                                        style: getRegularTextStyle(
                                          fontSize: ManagerFontSize.s12,
                                          color: ManagerColors.black,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: ManagerStrings
                                              .addCustomOfferAdditionsHint,
                                          hintStyle: getRegularTextStyle(
                                            fontSize: ManagerFontSize.s12,
                                            color: ManagerColors.greyWhiteColor,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: ManagerWidth.w12,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: ManagerWidth.w8),
                                  GestureDetector(
                                    onTap: _addAddition,
                                    child: Container(
                                      height: ManagerHeight.h44,
                                      width: ManagerWidth.w60,
                                      decoration: BoxDecoration(
                                        color: ManagerColors.primaryColor,
                                        borderRadius: BorderRadius.circular(
                                            ManagerRadius.r10),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        ManagerStrings
                                            .addCustomOfferAdditionsAdd,
                                        style: getBoldTextStyle(
                                          fontSize: ManagerFontSize.s12,
                                          color: ManagerColors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              /// Chips list
                              if (_additions.isNotEmpty) ...[
                                SizedBox(height: ManagerHeight.h10),
                                Wrap(
                                  spacing: ManagerWidth.w8,
                                  runSpacing: ManagerHeight.h6,
                                  children: List.generate(
                                    _additions.length,
                                    (i) => _AdditionChip(
                                      label: _additions[i],
                                      onRemove: () => _removeAddition(i),
                                    ),
                                  ),
                                ),
                              ],

                              SizedBox(height: ManagerHeight.h8),

                              /// Hint note
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.info_outline_rounded,
                                    color: ManagerColors.greyWhiteColor,
                                    size: ManagerWidth.w14,
                                  ),
                                  SizedBox(width: ManagerWidth.w6),
                                  Expanded(
                                    child: Text(
                                      ManagerStrings.addCustomOfferAdditionsNote,
                                      style: getRegularTextStyle(
                                        fontSize: ManagerFontSize.s10,
                                        color: ManagerColors.greyWhiteColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: ManagerHeight.h24),

                      /// Submit button
                      ButtonApp(
                        title: ManagerStrings.addCustomOfferSendButton,
                        onPressed: _handleSubmit,
                        paddingWidth: ManagerWidth.w16,
                      ),

                      SizedBox(height: ManagerHeight.h20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
          ),

          /// Loading overlay
          if (_isLoading)
            const Positioned.fill(
              child: ColoredBox(
                color: Color(0x55000000),
                child: Center(child: LoadingWidget()),
              ),
            ),
        ],
      ),
    );
  }
}

// ── Addition Chip ──────────────────────────────────────────────────────────
class _AdditionChip extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;

  const _AdditionChip({required this.label, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: ManagerWidth.w10,
        left: ManagerWidth.w4,
        top: ManagerHeight.h4,
        bottom: ManagerHeight.h4,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.primaryColor.withOpacity(0.10),
        borderRadius: BorderRadius.circular(ManagerRadius.r20),
        border: Border.all(
          color: ManagerColors.primaryColor.withOpacity(0.30),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onRemove,
            child: Container(
              width: ManagerWidth.w18,
              height: ManagerHeight.h18,
              decoration: BoxDecoration(
                color: ManagerColors.primaryColor.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close_rounded,
                size: ManagerFontSize.s11,
                color: ManagerColors.primaryColor,
              ),
            ),
          ),
          SizedBox(width: ManagerWidth.w6),
          Text(
            label,
            textDirection: Directionality.of(context),
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s12,
              color: ManagerColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
