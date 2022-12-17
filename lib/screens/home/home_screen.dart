import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              Container(
                height: 235.h,
                width: 235.h,
                color: Colors.grey.shade300,
              ),
              SizedBox(
                height: 40.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  getButton(
                    context,
                    title: "Log Symptoms",
                    onTap: () {},
                  ),
                  getButton(
                    context,
                    title: "Blood Marker",
                    onTap: () => navigate(context, AddBloodMarkScreen()),
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              getButton(context, title: "Upload Medical Report", onTap: () {})
            ],
          ),
        ),
      ),
    );
  }

  Widget getButton(BuildContext context,
      {required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(40.r),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
