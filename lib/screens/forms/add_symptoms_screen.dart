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
  AddSymptomsScreen({super.key});

  final symptomController = TextEditingController();
  final symptomRangeController = TextEditingController();
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
                validate: (v) =>
                    ValidationMixin().validate(v, title: "Symptom Range"),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 12.h,
              ),
              GeneralTextField(
                labelText: "Date",
                controller: dateController,
                obscureText: false,
                textInputType: TextInputType.none,
                suffixIcon: Icons.calendar_month_outlined,
                suffixIconColor: baseColor,
                readonly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.tryParse(dateController.text) ??
                        DateTime.now(),
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 30)),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    dateController.text = DateFormat("yyyy-MM-dd").format(date);
                  }
                },
                validate: (v) => ValidationMixin().validate(v, title: "Date"),
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
                    final symptom = Symptom(
                      symptom: getText(symptomController),
                      date: getText(dateController),
                      rate: int.parse(getText(symptomRangeController)),
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
