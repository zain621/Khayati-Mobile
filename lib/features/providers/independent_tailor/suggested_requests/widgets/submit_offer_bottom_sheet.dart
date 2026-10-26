import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/labeled_text_field.dart';
import 'package:app_mobile/features/providers/independent_tailor/suggested_requests/domain/model/suggested_order_model.dart';
import 'package:app_mobile/features/providers/independent_tailor/suggested_requests/presentation/controller/suggested_requests_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Bottom sheet for submitting an offer on a suggested order.
///
/// Uses plain [StatefulWidget] state (no Obx) so that GetX reactive updates
/// from the controller never try to rebuild an element whose parent
/// LayoutBuilder has already been made inactive by the modal animation.
class SubmitOfferBottomSheet extends StatefulWidget {
  final SuggestedOrderModel request;

  const SubmitOfferBottomSheet({
    super.key,
    required this.request,
  });

  static Future<void> show(
    BuildContext context,
    SuggestedOrderModel request,
  ) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SubmitOfferBottomSheet(request: request),
    );
  }

  @override
  State<SubmitOfferBottomSheet> createState() => _SubmitOfferBottomSheetState();
}

class _SubmitOfferBottomSheetState extends State<SubmitOfferBottomSheet> {
  final _priceController = TextEditingController();
  final _durationController = TextEditingController();
  final _detailsController = TextEditingController();

  late final SuggestedRequestsController _controller;

  // ---------- local UI state --------------------------------------------------
  bool _isSubmitting = false;
  String _submitError = '';
  // ---------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    _controller = Get.find<SuggestedRequestsController>();
    _priceController.addListener(_clearError);
    _durationController.addListener(_clearError);
    _detailsController.addListener(_clearError);
  }

  void _clearError() {
    if (_submitError.isNotEmpty) {
      setState(() => _submitError = '');
    }
  }

  @override
  void dispose() {
    _priceController.removeListener(_clearError);
    _durationController.removeListener(_clearError);
    _detailsController.removeListener(_clearError);
    _priceController.dispose();
    _durationController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  // ── Submit logic ─────────────────────────────────────────────────────────────

  Future<void> _doSubmit() async {
    final priceText = _priceController.text.trim();
    final durationText = _durationController.text.trim();

    final price = double.tryParse(priceText);
    final duration = int.tryParse(durationText);

    if (price == null || priceText.isEmpty) {
      setState(() => _submitError = ManagerStrings.enterValidPrice);
      return;
    }
    if (duration == null || durationText.isEmpty) {
      setState(() => _submitError = ManagerStrings.enterValidDuration);
      return;
    }

    setState(() {
      _isSubmitting = true;
      _submitError = '';
    });

    final success = await _controller.submitOffer(
      orderId: widget.request.id,
      proposedPrice: price,
      executionDays: duration,
      details: _detailsController.text.trim(),
    );

    // Always check mounted before touching State after an await.
    if (!mounted) return;

    if (success) {
      Navigator.pop(context);
    } else {
      setState(() {
        _isSubmitting = false;
        _submitError = _controller.submitError.value.isNotEmpty
            ? _controller.submitError.value
            : ManagerStrings.genericErrorRetry;
      });
    }
  }

  // ── Build ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      bottom: true,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        decoration: BoxDecoration(
          color: ManagerColors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(ManagerRadius.r24),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomInset),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDragHandle(),
              _buildHeader(),
              Flexible(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCustomerInfo(),
                      SizedBox(height: ManagerHeight.h20),

                      LabeledTextField(
                        label: ManagerStrings.submitOfferPriceLabel,
                        hintText: ManagerStrings.submitOfferPriceHint,
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        paddingWidth: 0,
                      ),
                      SizedBox(height: ManagerHeight.h6),
                      Text(
                        '${ManagerStrings.submitOfferBudgetRange} ${widget.request.budgetRange} ${ManagerStrings.suggestedRequestsCurrency}',
                        style: getRegularTextStyle(
                          fontSize: ManagerFontSize.s11,
                          color: ManagerColors.greyWhiteColor,
                        ),
                        textDirection: Directionality.of(context),
                      ),

                      SizedBox(height: ManagerHeight.h18),

                      LabeledTextField(
                        label: ManagerStrings.submitOfferDurationLabel,
                        hintText: ManagerStrings.submitOfferDurationHint,
                        controller: _durationController,
                        keyboardType: TextInputType.number,
                        paddingWidth: 0,
                      ),
                      SizedBox(height: ManagerHeight.h6),
                      Text(
                        '${ManagerStrings.submitOfferDeliveryNote} ${widget.request.deliveryDate}',
                        style: getRegularTextStyle(
                          fontSize: ManagerFontSize.s11,
                          color: ManagerColors.greyWhiteColor,
                        ),
                        textDirection: Directionality.of(context),
                      ),

                      SizedBox(height: ManagerHeight.h18),

                      LabeledTextField(
                        label: ManagerStrings.submitOfferDetailsLabel,
                        hintText: ManagerStrings.submitOfferDetailsHint,
                        controller: _detailsController,
                        maxLines: 4,
                        minLines: 4,
                        paddingWidth: 0,
                      ),

                      SizedBox(height: ManagerHeight.h24),

                      /// Error message — plain widget, no Obx
                      if (_submitError.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(bottom: ManagerHeight.h12),
                          child: Text(
                            _submitError,
                            style: getRegularTextStyle(
                              fontSize: ManagerFontSize.s12,
                              color: ManagerColors.redNew,
                            ),
                            textAlign: TextAlign.center,
                            textDirection: Directionality.of(context),
                          ),
                        ),

                      /// Submit button — plain widget, no Obx
                      _buildSubmitButton(),

                      SizedBox(height: ManagerHeight.h20),
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

  Widget _buildDragHandle() {
    return Padding(
      padding: EdgeInsets.only(top: ManagerHeight.h12),
      child: Center(
        child: Container(
          width: ManagerWidth.w40,
          height: ManagerHeight.h4,
          decoration: BoxDecoration(
            color: ManagerColors.greyWhiteColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(ManagerRadius.r4),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w20,
        vertical: ManagerHeight.h16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            ManagerStrings.submitOfferTitle,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s16,
              color: ManagerColors.black,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.close,
              size: ManagerFontSize.s22,
              color: ManagerColors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerInfo() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w14,
        vertical: ManagerHeight.h12,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: ManagerRadius.r20,
                backgroundColor: ManagerColors.greyWhiteColor.withOpacity(0.2),
                backgroundImage: widget.request.userImage != null
                    ? NetworkImage(widget.request.userImage!)
                    : null,
                child: widget.request.userImage == null
                    ? Icon(
                        Icons.person,
                        color: ManagerColors.greyWhiteColor,
                        size: ManagerFontSize.s18,
                      )
                    : null,
              ),
              SizedBox(width: ManagerWidth.w10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.request.userName,
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s14,
                      color: ManagerColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: ManagerHeight.h2),
                  Text(
                    widget.request.productName,
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s12,
                      color: ManagerColors.greyWhiteColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: ManagerHeight.h8),
          Text(
            widget.request.description,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s12,
              color: ManagerColors.black,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textDirection: Directionality.of(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: ManagerHeight.h50,
      child: ElevatedButton.icon(
        onPressed: _isSubmitting ? null : _doSubmit,
        icon: _isSubmitting
            ? SizedBox(
                width: ManagerWidth.w18,
                height: ManagerHeight.h18,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Icon(
                Icons.send_rounded,
                size: ManagerFontSize.s18,
                color: ManagerColors.white,
              ),
        label: Text(
          ManagerStrings.submitOfferButton,
          style: getMediumTextStyle(
            fontSize: ManagerFontSize.s15,
            color: ManagerColors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: ManagerColors.primaryColor,
          foregroundColor: ManagerColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ManagerRadius.r12),
          ),
        ),
      ),
    );
  }
}
