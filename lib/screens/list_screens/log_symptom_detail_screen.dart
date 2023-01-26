import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:roc_app/constants/constants.dart';
import 'package:roc_app/models/doctor.dart';
import 'package:roc_app/models/log_symptom.dart';
import 'package:roc_app/models/user.dart';
import 'package:roc_app/providers/user_provider.dart';
import 'package:roc_app/screens/forms/book_appointment_screen.dart';
import 'package:roc_app/utils/firebase_helper.dart';
import 'package:roc_app/utils/navigate.dart';
import 'package:roc_app/utils/show_toast_message.dart';
import 'package:roc_app/utils/util.dart';
import 'package:roc_app/widgets/custom_loading_indicator.dart';
import '/widgets/general_elevated_button.dart';

import '/widgets/body_template.dart';
import '/widgets/header_template.dart';

class LogSymptomDetailScreen extends StatelessWidget {
  const LogSymptomDetailScreen({super.key, required this.logSymptom});

  final LogSymptom logSymptom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BodyTemplate(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderTemplate(headerText: "Log Symptom Details"),
              SizedBox(
                height: 24.h,
              ),
              if (isAdmin(context))
                FutureBuilder(
                  future: FirebaseHelper().getData(
                    collectionId: UserConstants.userCollection,
                    whereId: UserConstants.userId,
                    whereValue: logSymptom.userId,
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
              if (logSymptom.symptom != null) ...[
                getText(context,
                    title: "Symptom Name", value: logSymptom.symptom!.symptom),
                SizedBox(
                  height: 8.h,
                ),
                getText(context,
                    title: "Rate",
                    value: logSymptom.symptom!.rate.toStringAsFixed(2)),
                SizedBox(
                  height: 8.h,
                ),
              ],
              getText(context,
                  title: "Date", value: logSymptom.dateTime.split(" ").first),
              SizedBox(
                height: 8.h,
              ),
              getText(context,
                  title: "Time", value: logSymptom.dateTime.split(" ").last),
              SizedBox(
                height: 8.h,
              ),
              getText(context, title: "Pelvic", value: logSymptom.pelvic),
              SizedBox(
                height: 8.h,
              ),
              getText(context,
                  title: "Indigestion", value: logSymptom.indigestion),
              SizedBox(
                height: 8.h,
              ),
              getText(context, title: "Nausea", value: logSymptom.nausea),
              SizedBox(
                height: 8.h,
              ),
              getText(context, title: "Bloating", value: logSymptom.bloating),
              SizedBox(
                height: 8.h,
              ),
              getText(context,
                  title: "Weight Loss", value: logSymptom.weightLoss),
              SizedBox(
                height: 24.h,
              ),
              GeneralElevatedButton(
                title: "Delete",
                onPressed: () async {
                  final val = await showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Delete"),
                      content: const Text("Do you want to delete the symptom"),
                      actions: [
                        OutlinedButton(
                          onPressed: () => Navigator.pop(context, true),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide.none,
                          ),
                          child: const Text("Yes"),
                        ),
                        OutlinedButton(
                          onPressed: () => Navigator.pop(context, false),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: BorderSide.none,
                          ),
                          child: const Text("No"),
                        )
                      ],
                    ),
                  );
                  try {
                    if (val == true) {
                      onLoading(context);
                      await FirebaseHelper().removeData(
                        context,
                        collectionId: LogSymptomConstant.logSymptomCollection,
                        docId: logSymptom.id!,
                      );
                      showToast("Successfully Deleted");
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  } catch (ex) {
                    showToast("Error deleting the symptom", color: Colors.red);
                  }
                },
              )
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
