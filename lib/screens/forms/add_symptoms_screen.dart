import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:roc_app/constants/constants.dart';
import 'package:roc_app/models/symptom.dart';
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

class AddSymptomsScreen extends StatelessWidget {
  AddSymptomsScreen({super.key, this.symptom});

  final Symptom? symptom;

  final symptomController = TextEditingController();
  final symptomRangeController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (symptom != null) {
      symptomController.text = symptom!.symptom;
      symptomRangeController.text = symptom!.rate.toStringAsFixed(2);
    }
    return Scaffold(
      body: SafeArea(
        child: BodyTemplate(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const HeaderTemplate(headerText: "Add Symptom"),
                SizedBox(
                  height: 24.h,
                ),
                GeneralTextField(
                  labelText: "Symptom",
                  controller: symptomController,
                  obscureText: false,
                  textInputType: TextInputType.text,
                  validate: (v) =>
                      ValidationMixin().validate(v, title: "Symptom"),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: 12.h,
                ),
                GeneralTextField(
                  labelText: "Symptom Range (0-10)",
                  controller: symptomRangeController,
                  obscureText: false,
                  textInputType: TextInputType.number,
                  validate: (v) => ValidationMixin().validateRange(
                    v,
                    title: "Symptom Range",
                    maxVal: 10,
                  ),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: 24.h,
                ),
                GeneralElevatedButton(
                  title: "Save",
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }
                    try {
                      onLoading(context);
                      final symptom = Symptom(
                        symptom: getText(symptomController),
                        rate: double.parse(getText(symptomRangeController)),
                        uuid: getUserId(),
                      ).toJson();
                      await FirebaseHelper().addData(
                        context,
                        map: symptom,
                        collectionId: SymptomConstant.symptomCollection,
                      );
                      showToast("Symptom added Successfully");
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } catch (ex) {
                      Navigator.pop(context);
                      GeneralAlertDialog()
                          .customAlertDialog(context, ex.toString());
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
