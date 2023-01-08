import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roc_app/screens/forms/add_doctor_screen.dart';
import 'package:roc_app/screens/forms/add_educational_resources_screen.dart';
import 'package:roc_app/screens/forms/log_symptoms_screen.dart';
import 'package:roc_app/utils/curved_button.dart';
import 'package:roc_app/utils/util.dart';
import '/constants/constants.dart';
import '/screens/forms/add_blood_mark_screen.dart';
import '/utils/navigate.dart';
import '/widgets/body_template.dart';
import '/widgets/header_template.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BodyTemplate(
          child: Column(
            children: [
              const HeaderTemplate(
                headerText: "Home Screen",
                needBackButton: false,
              ),
              SizedBox(
                height: 24.h,
              ),
              SizedBox(
                height: 235.h,
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(12.r),
                // ),
                child: Image.asset(
                  ImageConstants.hospital,
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              if (isAdmin(context))
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CurvedButton(
                      title: "Add Doctors",
                      onTap: () => navigate(context, AddDoctorScreen()),
                    ),
                    CurvedButton(
                      title: "Add Educational Resources",
                      onTap: () =>
                          navigate(context, AddEducationalResourcesScreen()),
                    ),
                  ],
                )
              else ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CurvedButton(
                      title: "Log Symptoms",
                      onTap: () => navigate(context, LogSymptomsScreen()),
                    ),
                    CurvedButton(
                      title: "Blood Marker",
                      onTap: () => navigate(context, AddBloodMarkScreen()),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 40.h,
                // ),
                // CurvedButton(
                //   title: "Upload Medical Report",
                //   onTap: () {},
                // )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
