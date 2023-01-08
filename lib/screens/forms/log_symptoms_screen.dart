import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:roc_app/constants/constants.dart';
import 'package:roc_app/models/log_symptom.dart';
import 'package:roc_app/models/symptom.dart';
import 'package:roc_app/screens/forms/add_symptoms_screen.dart';
import 'package:roc_app/utils/curved_button.dart';
import 'package:roc_app/utils/firebase_helper.dart';
import 'package:roc_app/utils/navigate.dart';
import 'package:roc_app/utils/show_toast_message.dart';
import 'package:roc_app/utils/util.dart';
import 'package:roc_app/widgets/custom_loading_indicator.dart';
import 'package:roc_app/widgets/general_alert_dialog.dart';
import '/utils/validation_mixin.dart';
import '/widgets/body_template.dart';
import '/widgets/general_elevated_button.dart';
import '/widgets/general_text_field.dart';
import '/widgets/header_template.dart';

class LogSymptomsScreen extends StatelessWidget {
  LogSymptomsScreen({super.key});

  final pelvicController = TextEditingController();
  final indigestionController = TextEditingController();
  final nauseaController = TextEditingController();
  final bloatingController = TextEditingController();
  final weightLossController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: GeneralElevatedButton(
          marginH: 16,
          title: "Save",
          onPressed: () async {
            try {
              onLoading(context);
              final symptom = LogSymptom(
                date: getText(dateController),
                time: getText(timeController),
                userId: FirebaseAuth.instance.currentUser!.uid,
                pelvic: getText(pelvicController),
                nausea: getText(nauseaController),
                indigestion: getText(indigestionController),
                bloating: getText(bloatingController),
                weightLoss: getText(weightLossController),
              ).toJson();
              await FirebaseHelper().addData(
                context,
                map: symptom,
                collectionId: LogSymptomConstant.logSymptomCollection,
              );
              showToast("Logged Symptom Successfully");
              Navigator.pop(context);
              Navigator.pop(context);
            } catch (ex) {
              Navigator.pop(context);
              await GeneralAlertDialog()
                  .customAlertDialog(context, ex.toString());
            }
          },
        ),
      ),
      body: SafeArea(
        child: BodyTemplate(
          child: Column(
            children: [
              const HeaderTemplate(headerText: "Log Symptoms"),
              SizedBox(
                height: 24.h,
              ),
              GeneralTextField(
                labelText: "Date",
                controller: dateController,
                obscureText: false,
                textInputType: TextInputType.none,
                readonly: true,
                suffixIcon: Icons.calendar_month_outlined,
                suffixIconColor: baseColor,
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
                height: 12.h,
              ),
              GeneralTextField(
                labelText: "Time",
                controller: timeController,
                obscureText: false,
                textInputType: TextInputType.none,
                readonly: true,
                suffixIcon: Icons.calendar_month_outlined,
                suffixIconColor: baseColor,
                onTap: () async {
                  final date = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                        DateTime.tryParse(timeController.text) ??
                            DateTime.now(),
                      )

                      // firstDate:
                      //     DateTime.now().subtract(const Duration(days: 30)),
                      // lastDate: DateTime.now(),
                      );
                  if (date != null) {
                    timeController.text = "${date.hour}:${date.minute}";
                  }
                },
                validate: (v) => ValidationMixin().validate(v, title: "Time"),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 24.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Symptoms",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  CurvedButton(
                      title: "Add Symptoms",
                      onTap: () => navigate(context, AddSymptomsScreen()))
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              SliderWidget(
                title: "Pelvic",
                controller: pelvicController,
              ),
              SliderWidget(
                title: "Indigestion",
                controller: indigestionController,
              ),
              SliderWidget(
                title: "Nausea",
                controller: nauseaController,
              ),
              SliderWidget(
                title: "Bloating",
                controller: bloatingController,
              ),
              SliderWidget(
                title: "Weight Loss",
                controller: weightLossController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SliderWidget extends StatefulWidget {
  const SliderWidget(
      {super.key, required this.title, required this.controller});

  final String title;
  final TextEditingController controller;

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double value = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CurvedButton(title: widget.title, onTap: () {}),
        Container(
          margin: EdgeInsets.only(
            top: 8.h,
            bottom: 16.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              50,
            ),
            color: Colors.pinkAccent.withOpacity(.4),
          ),
          child: Slider(
            value: value,
            min: 0,
            max: 10,
            divisions: 10,
            semanticFormatterCallback: ((value) => value.toString()),
            thumbColor: Colors.red,
            inactiveColor: Colors.red,
            activeColor: Colors.red,
            label: value.toStringAsFixed(0),
            onChanged: (val) {
              setState(() {
                value = val;
              });
              widget.controller.text = val.toStringAsFixed(0);
            },
          ),
        ),
      ],
    );
  }
}
