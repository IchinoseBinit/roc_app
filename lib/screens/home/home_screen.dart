import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:roc_app/providers/user_provider.dart';
import 'package:roc_app/screens/forms/add_doctor_screen.dart';
import 'package:roc_app/screens/forms/add_educational_resources_screen.dart';
import 'package:roc_app/screens/forms/log_symptoms_screen.dart';
import 'package:roc_app/screens/upload_medical_report_screen.dart';
import 'package:roc_app/utils/curved_button.dart';
import 'package:roc_app/utils/file_compressor.dart';
import 'package:roc_app/utils/firebase_helper.dart';
import 'package:roc_app/utils/image_picker.dart';
import 'package:roc_app/utils/util.dart';
import 'package:roc_app/widgets/custom_loading_indicator.dart';
import '/constants/constants.dart';
import '/screens/forms/add_blood_mark_screen.dart';
import '/utils/navigate.dart';
import '/widgets/body_template.dart';
import '/widgets/header_template.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: SafeArea(
        child: BodyTemplate(
          child: Column(
            children: [
              const HeaderTemplate(
                needBackButton: false,
              ),
              SizedBox(
                height: 24.h,
              ),
              Text(
                "How is your pain ${user.name} today?",
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 24.h,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 200.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        100.r,
                      ),
                      child: user.image == null && user.tempImage == null
                          ? Icon(
                              Icons.person,
                              size: 200.h,
                              color: Theme.of(context).primaryColor,
                            )
                          : Image.memory(
                              base64Decode(user.image ?? user.tempImage!),
                              fit: BoxFit.cover,
                              height: 200.h,
                              width: 200.h,
                            ),
                    ),
                  ),
                  Positioned(
                    bottom: 10.h,
                    right: -10,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey.shade400,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () async {
                          final val = await CustomImagePicker()
                              .showBottomSheet(context);
                          if (val != null) {
                            Provider.of<UserProvider>(context, listen: false)
                                .updateUserImage(context, val);
                          }
                        },
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Text(
                "Let's check in your symptoms",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
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
                SizedBox(
                  height: 40.h,
                ),
                CurvedButton(
                  title: "Upload Medical Report",
                  onTap: () =>
                      navigate(context, const UploadMedicalReportScreen()),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
