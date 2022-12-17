import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/widgets/general_elevated_button.dart';

import '/widgets/body_template.dart';
import '/widgets/header_template.dart';

class DoctorDetailsScreen extends StatelessWidget {
  const DoctorDetailsScreen({super.key});

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
              getText(context, title: "Name", value: "Professor Harley"),
              SizedBox(
                height: 16.h,
              ),
              getText(context,
                  title: "Address", value: "Rickard St, Balgowlah, NSW"),
              SizedBox(
                height: 16.h,
              ),
              getText(context,
                  title: "Qualification", value: "GCSEs/ three A*"),
              SizedBox(
                height: 16.h,
              ),
              getText(context,
                  title: "Experience",
                  value: "5 yeas oncology in Northshore Cancer Hospital"),
              SizedBox(
                height: 32.h,
              ),
              GeneralElevatedButton(
                title: "Book Appointment",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
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
