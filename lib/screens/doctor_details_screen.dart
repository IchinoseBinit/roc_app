import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roc_app/models/doctor.dart';
import 'package:roc_app/screens/forms/book_appointment_screen.dart';
import 'package:roc_app/utils/navigate.dart';
import '/widgets/general_elevated_button.dart';

import '/widgets/body_template.dart';
import '/widgets/header_template.dart';

class DoctorDetailsScreen extends StatelessWidget {
  const DoctorDetailsScreen({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BodyTemplate(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderTemplate(headerText: "Doctor Details"),
              SizedBox(
                height: 24.h,
              ),
              DoctorBody(doctor: doctor),
              SizedBox(
                height: 32.h,
              ),
              GeneralElevatedButton(
                title: "Book Appointment",
                onPressed: () => navigate(
                  context,
                  BookAppointmentScreen(
                    doctor: doctor,
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

class DoctorBody extends StatelessWidget {
  const DoctorBody({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getText(context, title: "Name", value: doctor.name),
        SizedBox(
          height: 16.h,
        ),
        getText(context, title: "Address", value: doctor.address),
        SizedBox(
          height: 16.h,
        ),
        getText(context, title: "Qualification", value: doctor.qualification),
        SizedBox(
          height: 16.h,
        ),
        getText(context, title: "Experience", value: doctor.experience),
      ],
    );
  }

  Widget getText(BuildContext context,
      {required String title, required String value}) {
    return Text.rich(
      TextSpan(
        text: "$title: ",
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontWeight: FontWeight.bold,
            ),
        children: [
          TextSpan(
            text: value,
            style: Theme.of(context).textTheme.bodyText1,
          )
        ],
      ),
    );
  }
}
