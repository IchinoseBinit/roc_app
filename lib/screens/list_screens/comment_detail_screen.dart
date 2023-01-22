import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:roc_app/constants/constants.dart';
import 'package:roc_app/models/appointment.dart';
import 'package:roc_app/models/doctor_comments.dart';
import 'package:roc_app/models/log_symptom.dart';
import 'package:roc_app/models/user.dart';
import 'package:roc_app/providers/user_provider.dart';
import 'package:roc_app/utils/firebase_helper.dart';
import 'package:roc_app/utils/util.dart';
import 'package:roc_app/utils/validation_mixin.dart';
import 'package:roc_app/widgets/custom_loading_indicator.dart';
import 'package:roc_app/widgets/general_alert_dialog.dart';
import 'package:roc_app/widgets/general_elevated_button.dart';
import 'package:roc_app/widgets/general_text_field.dart';

import '/widgets/body_template.dart';
import '/widgets/header_template.dart';

class CommentDetailScreen extends StatelessWidget {
  CommentDetailScreen({super.key, required this.comments});

  final DoctorComments comments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BodyTemplate(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderTemplate(headerText: "Comment Details"),
              SizedBox(
                height: 24.h,
              ),
              userDetails(context, comments.user),
              SizedBox(
                height: 8.h,
              ),
              getText(context,
                  title: "Date",
                  value: DateFormat("yyyy-MMM-dd").format(comments.dateTime)),
              SizedBox(
                height: 8.h,
              ),
              getText(context,
                  title: "Doctor Name", value: comments.doctor.name),
              SizedBox(
                height: 8.h,
              ),
              getText(context, title: "Comment", value: comments.comment),
              SizedBox(
                height: 8.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget userDetails(BuildContext context, User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getText(
          context,
          title: "Name",
          value: user.name.toString(),
        ),
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
