import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:roc_app/constants/constants.dart';
import 'package:roc_app/models/appointment.dart';
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

class AppointmentDetailScreen extends StatelessWidget {
  AppointmentDetailScreen({super.key, required this.appointment});

  final Appointment appointment;
  final remarksController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BodyTemplate(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderTemplate(headerText: "Appointment Details"),
                SizedBox(
                  height: 24.h,
                ),
                if (isAdmin(context))
                  FutureBuilder(
                    future: FirebaseHelper().getData(
                      collectionId: UserConstants.userCollection,
                      whereId: UserConstants.userId,
                      whereValue: appointment.userId,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator.adaptive();
                      }
                      if (snapshot.data != null &&
                          snapshot.data!.docs.first.exists) {
                        final user =
                            User.fromJson(snapshot.data!.docs.first.data());
                        return userDetails(context, user);
                      }
                      return const Text("User detail not found");
                    },
                  )
                else
                  userDetails(context,
                      Provider.of<UserProvider>(context, listen: false).user),
                SizedBox(
                  height: 8.h,
                ),
                getText(context, title: "Date", value: appointment.date),
                SizedBox(
                  height: 8.h,
                ),
                getText(context, title: "Time", value: appointment.time),
                SizedBox(
                  height: 8.h,
                ),
                getText(context,
                    title: "Doctor Name", value: appointment.doctor.name),
                SizedBox(
                  height: 8.h,
                ),
                getText(context,
                    title: "Appointment Status",
                    value: appointment.isChecked ? "Completed" : "Upcoming"),
                SizedBox(
                  height: appointment.remarks != null ? 8.h : 24.h,
                ),
                if (appointment.remarks != null) ...[
                  getText(context,
                      title: "Remarks", value: appointment.remarks!),
                  SizedBox(
                    height: 8.h,
                  ),
                ] else ...[
                  GeneralTextField(
                    labelText: "Remarks",
                    controller: remarksController,
                    obscureText: false,
                    maxLines: 5,
                    textInputType: TextInputType.multiline,
                    validate: (v) =>
                        ValidationMixin().validate(v, title: "Remarks"),
                    textInputAction: TextInputAction.newline,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  GeneralElevatedButton(
                    title: "Submit",
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          onLoading(context);
                          appointment.isChecked = true;
                          appointment.remarks = remarksController.text;
                          await FirebaseHelper().updateData(
                            context,
                            map: appointment.toJson(),
                            collectionId: BookAppointmentConstant.appointment,
                            docId: appointment.id!,
                          );
                          Navigator.pop(context);
                          Navigator.pop(context);
                        } catch (ex) {
                          Navigator.pop(context);
                          GeneralAlertDialog()
                              .customAlertDialog(context, ex.toString());
                        }
                      }
                    },
                  )
                ],
                SizedBox(
                  height: 8.h,
                ),
              ],
            ),
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
