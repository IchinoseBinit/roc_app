import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:roc_app/constants/constants.dart';
import 'package:roc_app/models/blood_mark.dart';
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

class AddBloodMarkScreen extends StatelessWidget {
  AddBloodMarkScreen({super.key});

  final nameController = TextEditingController();
  final amountOfProtienController = TextEditingController();
  final referenceRangeController = TextEditingController();
  final dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BodyTemplate(
          child: Column(
            children: [
              const HeaderTemplate(headerText: "Add Blood Mark"),
              SizedBox(
                height: 24.h,
              ),
              GeneralTextField(
                labelText: "Name",
                controller: nameController,
                obscureText: false,
                textInputType: TextInputType.text,
                validate: (v) => ValidationMixin().validate(v, title: "Name"),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 12.h,
              ),
              GeneralTextField(
                labelText: "Amount of Protien",
                controller: amountOfProtienController,
                obscureText: false,
                textInputType: TextInputType.number,
                validate: (v) =>
                    ValidationMixin().validate(v, title: "Amount of Protien"),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 12.h,
              ),
              GeneralTextField(
                labelText: "Reference Range",
                controller: referenceRangeController,
                obscureText: false,
                textInputType: TextInputType.number,
                validate: (v) =>
                    ValidationMixin().validate(v, title: "Reference Range"),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 24.h,
              ),
              GeneralElevatedButton(
                title: "Save",
                onPressed: () async {
                  try {
                    onLoading(context);
                    final bloodMark = BloodMark(
                      name: getText(nameController),
                      uuid: getUserId(),
                      amountOfProtien: double.parse(
                        getText(amountOfProtienController),
                      ),
                      referenceRange: double.parse(
                        getText(referenceRangeController),
                      ),
                    ).toJson();
                    await FirebaseHelper().addData(
                      context,
                      map: bloodMark,
                      collectionId: BloodMarkConstant.bloodMarkCollection,
                    );
                    showToast("Blood Mark added successfully");
                    Navigator.pop(context);
                    Navigator.pop(context);
                  } catch (ex) {
                    Navigator.pop(context);
                    await GeneralAlertDialog()
                        .customAlertDialog(context, ex.toString());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
