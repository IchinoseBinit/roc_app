import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:roc_app/constants/constants.dart';
import 'package:roc_app/models/appointment.dart';
import 'package:roc_app/models/doctor.dart';
import 'package:roc_app/models/log_symptom.dart';
import 'package:roc_app/providers/user_provider.dart';
import 'package:roc_app/screens/doctor_details_screen.dart';
import 'package:roc_app/screens/forms/add_symptoms_screen.dart';
import 'package:roc_app/screens/navigation/navigation_screen.dart';
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

class BookAppointmentScreen extends StatelessWidget {
  BookAppointmentScreen({super.key, required this.doctor});

  final Doctor doctor;
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
              final appointment = Appointment(
                date: getText(dateController),
                time: getText(timeController),
                userId: getUserId(),
                doctor: doctor,
                isChecked: false,
              ).toJson();
              await FirebaseHelper().addData(
                context,
                map: appointment,
                collectionId: BookAppointmentConstant.appointment,
              );
              showToast("Appointment Booked Successfully");
              navigateAndRemoveAll(context, NavigationScreen());
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderTemplate(headerText: "Appointment Booking"),
              SizedBox(
                height: 24.h,
              ),
              Text(
                "Doctor Details",
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 8.h,
              ),
              DoctorBody(
                doctor: doctor,
              ),
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
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 30)),
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
                      ));
                  if (date != null) {
                    if (date.hour >= 9 && date.hour <= 18) {
                      if (date.minute % 15 == 0) {
                        timeController.text = "${date.hour}:${date.minute}";
                      } else {
                        showToast(
                          "Please select a time in multiple of 15 minutes",
                          color: Colors.red,
                        );
                      }
                    } else {
                      showToast(
                        "Please select a time within 9 a.m. to 6 p.m.",
                        color: Colors.red,
                      );
                    }
                  }
                },
                validate: (v) => ValidationMixin().validate(v, title: "Time"),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 6.h,
              ),
              const Text(
                "Note: You can only select time from 9 a.m. to 6 p.m.\nPlease select the minutes in multiple of 15 i.e. 0, 15, 30, 45",
              )
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
