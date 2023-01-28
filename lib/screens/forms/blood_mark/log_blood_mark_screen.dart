import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:roc_app/constants/constants.dart';
import 'package:roc_app/models/blood_mark.dart';
import 'package:roc_app/models/log_blood_mark.dart';
import 'package:roc_app/screens/list_screens/blood_marks_list_screen.dart';
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

class LogBloodMarkScreen extends StatefulWidget {
  const LogBloodMarkScreen({super.key});

  @override
  State<LogBloodMarkScreen> createState() => _LogBloodMarkScreenState();
}

class _LogBloodMarkScreenState extends State<LogBloodMarkScreen> {
  BloodMark? bloodMark;

  final formKey = GlobalKey<FormState>();

  final inhibinBController = TextEditingController();

  final ca125Controller = TextEditingController();

  final dateController = TextEditingController();

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
              final bloodMarkDetail = LogBloodMark(
                      bloodMark: bloodMark,
                      dateTime: getText(dateController).trim(),
                      userId: FirebaseAuth.instance.currentUser!.uid,
                      inhibinB: getText(inhibinBController),
                      ca125: getText(ca125Controller))
                  .toJson();
              await FirebaseHelper().addData(
                context,
                map: bloodMarkDetail,
                collectionId: LogBloodMarkConstant.collection,
              );
              showToast("Logged Blood Mark Successfully");
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
                  height: 24.h,
                ),
                if (bloodMark == null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Blood Mark",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      CurvedButton(
                          title: "Add Blood Mark",
                          onTap: () async {
                            final data = await navigate(
                                context, const BloodMarkListScreen());
                            if (data != null) {
                              setState(() {
                                bloodMark = data;
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
                                context, const BloodMarkListScreen());
                            if (data != null) {
                              setState(() {
                                bloodMark = data;
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
                              title: "Blood Mark Name", value: bloodMark!.name),
                          SizedBox(
                            height: 8.h,
                          ),
                          getTextDetail(context,
                              title: "Amount of Protien",
                              value: bloodMark!.amountOfProtien
                                  .toStringAsFixed(2)),
                          SizedBox(
                            height: 8.h,
                          ),
                          getTextDetail(context,
                              title: "Reference Range",
                              value:
                                  bloodMark!.referenceRange.toStringAsFixed(2)),
                        ],
                      ),
                    ),
                  ),
                ],
                SizedBox(
                  height: 24.h,
                ),
                SliderWidget(
                  title: "Inhibin B",
                  controller: inhibinBController,
                ),
                SliderWidget(
                  title: "CA-125",
                  controller: ca125Controller,
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
