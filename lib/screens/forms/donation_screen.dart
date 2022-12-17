import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
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
                        textInputType: TextInputType.none,
                        readonly: true,
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate:
                                DateTime.tryParse(expiryDateController.text) ??
                                    DateTime.now(),
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 30)),
                            lastDate: DateTime.now(),
                          );
                          if (date != null) {
                            expiryDateController.text =
                                DateFormat("yyyy-MM-dd").format(date);
                          }
                        },
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
                  onPressed: () {
                    if (formKey.currentState!.validate()) {}
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
