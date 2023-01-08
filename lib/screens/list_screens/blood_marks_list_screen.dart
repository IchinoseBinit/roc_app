import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roc_app/models/blood_mark.dart';

import '/constants/constants.dart';
import '/utils/firebase_helper.dart';
import '/utils/util.dart';
import '/widgets/body_template.dart';
import '/widgets/header_template.dart';

class BloodMarkListScreen extends StatelessWidget {
  const BloodMarkListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BodyTemplate(
          child: Column(
            children: [
              const HeaderTemplate(
                headerText: "List of Blood Marks",
              ),
              SizedBox(
                height: 24.h,
              ),
              StreamBuilder(
                stream: FirebaseHelper().getStreamWithWhere(
                  collectionId: BloodMarkConstant.bloodMarkCollection,
                  whereId: UserConstants.userId,
                  whereValue: getUserId(),
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator.adaptive();
                  }
                  final data = snapshot.data;
                  if (data?.docs != null && data!.docs.isNotEmpty) {
                    final bloodMarks = data.docs
                        .map((e) => BloodMark.fromMap(e.data()))
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
                              child: const Icon(
                                Icons.info_outline,
                              ),
                            ),
                            title: Text(
                              bloodMarks[index].date,
                            ),
                            subtitle: Text(
                              "Protien: ${bloodMarks[index].amountOfProtien}",
                            ),
                            trailing: Text(
                                "Range: ${bloodMarks[index].referenceRange.toString()}"),
                          ),
                        ),
                      ),
                      separatorBuilder: (_, __) => SizedBox(
                        height: 8.h,
                      ),
                      itemCount: bloodMarks.length,
                      shrinkWrap: true,
                      primary: false,
                    );
                  }
                  return const Center(
                    child: Text("No Blood Marks saved till now"),
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
