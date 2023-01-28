import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:roc_app/models/doctor_comments.dart';
import 'package:roc_app/models/medical_details.dart';
import 'package:roc_app/screens/list_screens/comment_detail_screen.dart';
import 'package:roc_app/utils/navigate.dart';
import 'package:roc_app/utils/util.dart';

import '/constants/constants.dart';
import '/utils/firebase_helper.dart';
import '/widgets/body_template.dart';
import '/widgets/header_template.dart';

class UploadedReportListScreen extends StatelessWidget {
  const UploadedReportListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BodyTemplate(
          child: Column(
            children: [
              const HeaderTemplate(
                headerText: "List of Reports",
              ),
              SizedBox(
                height: 24.h,
              ),
              StreamBuilder(
                stream: FirebaseHelper().getStreamWithWhere(
                  collectionId: MedicalDetailsConstant.detailsCollection,
                  whereId: UserConstants.userId,
                  whereValue: getUserId(),
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator.adaptive();
                  }
                  final data = snapshot.data;
                  if (data?.docs != null && data!.docs.isNotEmpty) {
                    final reports = data.docs
                        .map((e) => MedicalDetails.fromJson(
                              e.data(),
                            ))
                        .toList();
                    return ListView.separated(
                      itemBuilder: (_, index) => Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 8.h,
                          ),
                          child: Column(
                            children: [
                              Image.memory(
                                base64Decode(
                                  reports[index].image,
                                ),
                                width: 1.sw,
                                fit: BoxFit.cover,
                                height: .3.sh,
                              ),
                              // SizedBox(
                              //   height: 16.h,
                              // ),
                            ],
                          ),
                        ),
                      ),
                      separatorBuilder: (_, __) => SizedBox(
                        height: 8.h,
                      ),
                      itemCount: reports.length,
                      shrinkWrap: true,
                      primary: false,
                    );
                  }
                  return const Center(
                    child: Text("No Reports till now"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
