import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/labeled_text_field.dart';
import 'package:app_mobile/features/providers/independent_tailor/my_offers/domain/model/my_offer_model.dart';
import 'package:app_mobile/features/providers/independent_tailor/my_offers/presentation/controller/my_offers_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Pre-filled bottom sheet for editing a pending offer.
class EditOfferBottomSheet extends StatefulWidget {
  final MyOfferModel offer;

  const EditOfferBottomSheet({super.key, required this.offer});

  static Future<void> show(BuildContext context, MyOfferModel offer) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => EditOfferBottomSheet(offer: offer),
    );
  }

  @override
  State<EditOfferBottomSheet> createState() => _EditOfferBottomSheetState();
}

class _EditOfferBottomSheetState extends State<EditOfferBottomSheet> {
  late final TextEditingController _priceCtrl;
  late final TextEditingController _daysCtrl;
  late final TextEditingController _detailsCtrl;
  late final MyOffersController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<MyOffersController>();
    _priceCtrl = TextEditingController(
      text: widget.offer.myOffer.proposedPrice.toInt().toString(),
    );
    _daysCtrl = TextEditingController(
      text: widget.offer.myOffer.executionDays.toString(),
    );
    _detailsCtrl = TextEditingController(
      text: widget.offer.myOffer.details,
    );
  }

  @override
  void dispose() {
    _priceCtrl.dispose();
    _daysCtrl.dispose();
    _detailsCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final price = double.tryParse(_priceCtrl.text.trim());
    final days = int.tryParse(_daysCtrl.text.trim());
    final details = _detailsCtrl.text.trim();

    if (price == null || days == null || details.isEmpty) return;

    final ok = await _controller.updateOffer(
      offerId: widget.offer.myOffer.id,
      proposedPrice: price,
      executionDays: days,
      details: details,
    );

    if (ok && mounted) Navigator.of(context).pop();
  }

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
              _DragHandle(),
              _Header(),
              Flexible(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabeledTextField(
                        label: ManagerStrings.submitOfferPriceLabel,
                        hintText: ManagerStrings.submitOfferPriceHint,
                        controller: _priceCtrl,
                        keyboardType: TextInputType.number,
                        paddingWidth: 0,
                      ),
                      SizedBox(height: ManagerHeight.h16),
                      LabeledTextField(
                        label: ManagerStrings.submitOfferDurationLabel,
                        hintText: ManagerStrings.submitOfferDurationHint,
                        controller: _daysCtrl,
                        keyboardType: TextInputType.number,
                        paddingWidth: 0,
                      ),
                      SizedBox(height: ManagerHeight.h16),
                      LabeledTextField(
                        label: ManagerStrings.submitOfferDetailsLabel,
                        hintText: ManagerStrings.submitOfferDetailsHint,
                        controller: _detailsCtrl,
                        maxLines: 4,
                        minLines: 4,
                        paddingWidth: 0,
                      ),
                      SizedBox(height: ManagerHeight.h24),
                      Obx(() {
                        final busy = _controller.actionOfferId.value ==
                            widget.offer.myOffer.id;
                        return GestureDetector(
                          onTap: busy ? null : _submit,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical: ManagerHeight.h14),
                            decoration: BoxDecoration(
                              color: busy
                                  ? ManagerColors.primaryColor.withOpacity(0.5)
                                  : ManagerColors.primaryColor,
                              borderRadius:
                                  BorderRadius.circular(ManagerRadius.r12),
                            ),
                            child: Center(
                              child: busy
                                  ? SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: ManagerColors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
                                      ManagerStrings.editOfferSubmit,
                                      style: getMediumTextStyle(
                                        fontSize: ManagerFontSize.s15,
                                        color: ManagerColors.white,
                                      ),
                                    ),
                            ),
                          ),
                        );
                      }),
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
}

class _DragHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w20,
        vertical: ManagerHeight.h16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            ManagerStrings.editOfferTitle,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s16,
              color: ManagerColors.primaryColor,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.close,
              color: ManagerColors.greyWhiteColor,
              size: ManagerFontSize.s20,
            ),
          ),
        ],
      ),
    );
  }
}
