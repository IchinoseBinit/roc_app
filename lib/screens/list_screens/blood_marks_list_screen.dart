import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roc_app/models/blood_mark.dart';
import 'package:roc_app/screens/graphs/blood_mark_graph_screen.dart';
import 'package:roc_app/utils/navigate.dart';
import 'package:roc_app/widgets/general_elevated_button.dart';

import '/constants/constants.dart';
import '/utils/firebase_helper.dart';
import '/utils/util.dart';
import '/widgets/body_template.dart';
import '/widgets/header_template.dart';

class BloodMarkListScreen extends StatefulWidget {
  const BloodMarkListScreen({super.key});

  @override
  State<BloodMarkListScreen> createState() => _BloodMarkListScreenState();
}

class _BloodMarkListScreenState extends State<BloodMarkListScreen> {
  List<BloodMark> bloodMarkList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: isAdmin(context)
          ? null
          : Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: GeneralElevatedButton(
                marginH: 16.h,
                title: "See Graph",
                onPressed: () => navigate(
                    context,
                    GraphScreen(
                      marks: bloodMarkList,
                    )),
              ),
            ),
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
                    bloodMarkList = data.docs
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
                              bloodMarkList[index].date,
                            ),
                            subtitle: Text(
                              "Protien: ${bloodMarkList[index].amountOfProtien}",
                            ),
                            trailing: Text(
                                "Range: ${bloodMarkList[index].referenceRange.toString()}"),
                          ),
                        ),
                      ),
                      separatorBuilder: (_, __) => SizedBox(
                        height: 8.h,
                      ),
                      itemCount: bloodMarkList.length,
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
