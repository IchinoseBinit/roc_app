import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:roc_app/constants/constants.dart';
import 'package:roc_app/models/log_symptom.dart';
import 'package:roc_app/models/symptom.dart';
import 'package:roc_app/screens/forms/add_symptoms_screen.dart';
import 'package:roc_app/screens/list_screens/symptoms_list_screen.dart';
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

class LogSymptomsScreen extends StatefulWidget {
  LogSymptomsScreen({super.key});

  @override
  State<LogSymptomsScreen> createState() => _LogSymptomsScreenState();
}

class _LogSymptomsScreenState extends State<LogSymptomsScreen> {
  Symptom? symptom;

  final formKey = GlobalKey<FormState>();

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
            if (!formKey.currentState!.validate()) {
              return;
            }
            try {
              onLoading(context);
              final symptomDetail = LogSymptom(
                symptom: symptom,
                dateTime:
                    "${getText(dateController).trim()} ${getText(timeController).trim()}",
                userId: FirebaseAuth.instance.currentUser!.uid,
                pelvic: getText(pelvicController),
                nausea: getText(nauseaController),
                indigestion: getText(indigestionController),
                bloating: getText(bloatingController),
                weightLoss: getText(weightLossController),
              ).toJson();
              await FirebaseHelper().addData(
                context,
                map: symptomDetail,
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
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  suffixIconColor: Theme.of(context).primaryColor,
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.tryParse(dateController.text) ??
                          DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 360)),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      dateController.text =
                          DateFormat("yyyy-MM-dd").format(date);
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
                  suffixIconColor: Theme.of(context).primaryColor,
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
                if (symptom == null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Symptoms",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      CurvedButton(
                          title: "Add Symptom",
                          onTap: () async {
                            final data = await navigate(
                                context, const SymptomsListScreen());
                            if (data != null) {
                              setState(() {
                                symptom = data;
                              });
                            }
                          })
                    ],
                  )
                else ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Details",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                            ),
                      ),
                      IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.edit_outlined,
                            size: 20.h,
                            color: Colors.black,
                          ),
                          onPressed: () async {
                            final data = await navigate(
                                context, const SymptomsListScreen());
                            if (data != null) {
                              setState(() {
                                symptom = data;
                              });
                            }
                          })
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12.r,
                      ),
                    ),
                    color: Colors.teal,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getTextDetail(context,
                              title: "Symptom Name", value: symptom!.symptom),
                          SizedBox(
                            height: 8.h,
                          ),
                          getTextDetail(context,
                              title: "Rate",
                              value: symptom!.rate.toStringAsFixed(2)),
                        ],
                      ),
                    ),
                  ),
                ],
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
      ),
    );
  }

  Widget getTextDetail(BuildContext context,
      {required String title, required String value}) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        "$title: ",
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.white,
            ),
      ),
      Text(
        value,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
      )
    ]);
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
  void initState() {
    super.initState();
    widget.controller.text = "0";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CurvedButton(
          title: widget.title,
          onTap: () {},
          color: const Color(0xFFCAB47C),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 8.h,
            bottom: 16.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              50,
            ),
            color: Colors.white.withOpacity(.4),
          ),
          child: Slider(
            value: value,
            min: 0,
            max: 10,
            divisions: 10,
            semanticFormatterCallback: ((value) => value.toString()),
            thumbColor: Colors.teal,
            inactiveColor: Colors.teal,
            activeColor: Colors.teal,
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
