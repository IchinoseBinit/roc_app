import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roc_app/models/contact_us.dart';
import 'package:roc_app/models/doctor.dart';

import '/widgets/body_template.dart';
import '/widgets/general_elevated_button.dart';
import '/widgets/header_template.dart';

class MessageDetailsScreen extends StatelessWidget {
  const MessageDetailsScreen({super.key, required this.contactUs});

  final ContactUs contactUs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BodyTemplate(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderTemplate(headerText: contactUs.subject),
              SizedBox(
                height: 24.h,
              ),
              getText(context, title: "Message", value: contactUs.message),
              SizedBox(
                height: 16.h,
              ),
              getText(context, title: "Name", value: contactUs.name),
              SizedBox(
                height: 16.h,
              ),
              getText(context, title: "Email", value: contactUs.email),
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
