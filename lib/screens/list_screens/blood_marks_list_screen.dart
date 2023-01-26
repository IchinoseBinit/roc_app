import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roc_app/models/blood_mark.dart';
import 'package:roc_app/screens/graphs/blood_mark_graph_screen.dart';
import 'package:roc_app/utils/navigate.dart';
import 'package:roc_app/utils/show_toast_message.dart';
import 'package:roc_app/widgets/custom_loading_indicator.dart';
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
                    BloodMarkGraphScreen(
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
                        .map((e) => BloodMark.fromMap(e.data(), e.id))
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
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Range: ${bloodMarkList[index].referenceRange.toString()}",
                                ),
                                Flexible(
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () async {
                                      final val = await showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: const Text("Delete"),
                                          content: const Text(
                                              "Do you want to delete the Blood Mark?"),
                                          actions: [
                                            OutlinedButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, true),
                                              style: OutlinedButton.styleFrom(
                                                side: BorderSide.none,
                                              ),
                                              child: const Text("Yes"),
                                            ),
                                            OutlinedButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, false),
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
                                            collectionId: BloodMarkConstant
                                                .bloodMarkCollection,
                                            docId: bloodMarkList[index].id!,
                                          );
                                          showToast("Successfully Deleted");
                                          Navigator.pop(context);
                                        }
                                      } catch (ex) {
                                        showToast(
                                            "Error deleting the blood mark",
                                            color: Colors.red);
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                )
                              ],
                            ),
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
