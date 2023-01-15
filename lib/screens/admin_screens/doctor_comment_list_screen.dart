import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:roc_app/constants/constants.dart';
import 'package:roc_app/models/doctor_comments.dart';
import 'package:roc_app/models/donation.dart';
import 'package:roc_app/utils/firebase_helper.dart';

import '/widgets/body_template.dart';
import '/widgets/header_template.dart';

class DoctorCommentListScreen extends StatelessWidget {
  const DoctorCommentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BodyTemplate(
          child: Column(
            children: [
              const HeaderTemplate(
                headerText: "List of Comments",
              ),
              SizedBox(
                height: 24.h,
              ),
              StreamBuilder(
                stream: FirebaseHelper()
                    .getStream(collectionId: DoctorConstant.commentCollection),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator.adaptive();
                  }
                  final data = snapshot.data;
                  if (data?.docs != null && data!.docs.isNotEmpty) {
                    final doctorComments = data.docs
                        .map((e) => DoctorComments.fromMap(e.data()))
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
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey.shade300,
                              child: doctorComments[index].user.image != null &&
                                      doctorComments[index].user.tempImage ==
                                          null
                                  ? Image.memory(
                                      base64Decode(
                                          doctorComments[index].user.image ??
                                              doctorComments[index]
                                                  .user
                                                  .tempImage!),
                                    )
                                  : const Icon(
                                      Icons.person_outlined,
                                    ),
                            ),
                            title: Text(
                              doctorComments[index].user.name ?? "",
                            ),
                            subtitle: Text(
                              doctorComments[index].comment,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Text(
                              DateFormat("yyyy-MM-dd")
                                  .format(doctorComments[index].dateTime),
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (_, __) => SizedBox(
                        height: 8.h,
                      ),
                      itemCount: doctorComments.length,
                      shrinkWrap: true,
                      primary: false,
                    );
                  }
                  return const Center(
                    child: Text("No comments made till now"),
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
