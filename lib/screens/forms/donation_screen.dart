import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:roc_app/constants/constants.dart';
import 'package:roc_app/models/donation.dart';
import 'package:roc_app/utils/firebase_helper.dart';
import 'package:roc_app/utils/show_toast_message.dart';
import 'package:roc_app/utils/util.dart';
import 'package:roc_app/widgets/custom_loading_indicator.dart';
import 'package:roc_app/widgets/general_alert_dialog.dart';
import '/utils/validation_mixin.dart';
import '/widgets/body_template.dart';
import '/widgets/general_elevated_button.dart';
import '/widgets/general_text_field.dart';
import '/widgets/header_template.dart';

class DonationScreen extends StatelessWidget {
  DonationScreen({super.key});

  final amountController = TextEditingController();
  final fullNameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expiryDateController = TextEditingController();
  final cvvController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BodyTemplate(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const HeaderTemplate(headerText: "Donation"),
                SizedBox(
                  height: 24.h,
                ),
                GeneralTextField(
                  labelText: "Amount",
                  controller: amountController,
                  obscureText: false,
                  textInputType: TextInputType.number,
                  validate: (v) =>
                      ValidationMixin().validate(v, title: "Amount"),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: 12.h,
                ),
                GeneralTextField(
                  labelText: "Full Name",
                  controller: fullNameController,
                  obscureText: false,
                  textInputType: TextInputType.name,
                  validate: (v) =>
                      ValidationMixin().validate(v, title: "Full Name"),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: 12.h,
                ),
                GeneralTextField(
                  labelText: "Card Number",
                  controller: cardNumberController,
                  obscureText: false,
                  textInputType: TextInputType.number,
                  validate: (v) =>
                      ValidationMixin().validate(v, title: "Card Number"),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: .4.sw,
                      child: GeneralTextField(
                        labelText: "Date",
                        controller: expiryDateController,
                        obscureText: false,
                        textInputType: TextInputType.datetime,
                        validate: (v) =>
                            ValidationMixin().validate(v, title: "Date"),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    SizedBox(
                      width: .4.sw,
                      child: GeneralTextField(
                        labelText: "CVV",
                        controller: cvvController,
                        maxLength: 3,
                        obscureText: false,
                        textInputType: TextInputType.number,
                        validate: (v) =>
                            ValidationMixin().validate(v, title: "CVV"),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24.h,
                ),
                GeneralElevatedButton(
                  title: "Submit",
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        onLoading(context);
                        final donation = Donation(
                          name: getText(fullNameController),
                          amount: double.parse(getText(amountController)),
                          cardNumber: int.parse(getText(cardNumberController)),
                          date: getText(expiryDateController),
                          cvv: int.parse(getText(cvvController)),
                        ).toJson();
                        await FirebaseHelper().addData(
                          context,
                          map: donation,
                          collectionId: DonationConstant.donationCollection,
                        );
                        showToast("Donated Successfully");
                        Navigator.pop(context);
                        Navigator.pop(context);
                      } catch (ex) {
                        Navigator.pop(context);
                        await GeneralAlertDialog()
                            .customAlertDialog(context, ex.toString());
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
