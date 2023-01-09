import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:roc_app/constants/constants.dart';
import 'package:roc_app/models/medical_details.dart';
import 'package:roc_app/utils/firebase_helper.dart';
import 'package:roc_app/utils/image_picker.dart';
import 'package:roc_app/utils/show_toast_message.dart';
import 'package:roc_app/utils/util.dart';
import 'package:roc_app/widgets/body_template.dart';
import 'package:roc_app/widgets/custom_loading_indicator.dart';
import 'package:roc_app/widgets/general_alert_dialog.dart';
import 'package:roc_app/widgets/general_elevated_button.dart';
import 'package:roc_app/widgets/header_template.dart';

class UploadMedicalReportScreen extends StatefulWidget {
  const UploadMedicalReportScreen({super.key});

  @override
  State<UploadMedicalReportScreen> createState() =>
      _UploadMedicalReportScreenState();
}

class _UploadMedicalReportScreenState extends State<UploadMedicalReportScreen> {
  String? imageData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BodyTemplate(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderTemplate(headerText: "Upload Medical Report"),
              SizedBox(
                height: 24.h,
              ),
              GestureDetector(
                onTap: () async {
                  final val =
                      await CustomImagePicker().showBottomSheet(context);
                  if (val != null) {
                    imageData = val;
                    setState(() {});
                  }
                },
                child: Center(
                  child: Container(
                    height: imageData == null ? 200.h : 300.h,
                    width: imageData == null ? 1.sw : .5.sw,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: imageData == null
                        ? const Icon(
                            Icons.add,
                            size: 48,
                            color: Colors.black,
                          )
                        : Image.memory(
                            base64Decode(
                              imageData!,
                            ),
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              GeneralElevatedButton(
                title: "Upload",
                onPressed: () async {
                  try {
                    onLoading(context);
                    Map<String, dynamic> map;
                    if (imageData != null) {
                      map = MedicalDetails(
                        uuid: getUserId(),
                        image: imageData!,
                      ).toMap();
                      await FirebaseHelper().addData(
                        context,
                        map: map,
                        collectionId: MedicalDetailsConstant.detailsCollection,
                      );
                      showToast("Medical report added successfully");
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  } catch (ex) {
                    GeneralAlertDialog()
                        .customAlertDialog(context, ex.toString());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
