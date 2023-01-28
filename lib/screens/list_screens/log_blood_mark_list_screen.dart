import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roc_app/models/log_blood_mark.dart';
import 'package:roc_app/screens/graphs/blood_mark_graph_screen.dart';
import 'package:roc_app/screens/list_screens/log_blood_mark_detail_screen.dart';
import 'package:roc_app/utils/navigate.dart';
import 'package:roc_app/widgets/general_elevated_button.dart';

import '/constants/constants.dart';
import '/utils/firebase_helper.dart';
import '/utils/util.dart';
import '/widgets/body_template.dart';
import '/widgets/header_template.dart';

class LogBloodMarkListScreen extends StatefulWidget {
  const LogBloodMarkListScreen({super.key});

  @override
  State<LogBloodMarkListScreen> createState() => _LogBloodMarkListScreenState();
}

class _LogBloodMarkListScreenState extends State<LogBloodMarkListScreen> {
  List<LogBloodMark> loggedBloodMarks = [];

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
                      marks: loggedBloodMarks,
                    )),
              ),
            ),
      body: SafeArea(
        child: BodyTemplate(
          child: Column(
            children: [
              const HeaderTemplate(
                headerText: "List of Logs",
              ),
              SizedBox(
                height: 24.h,
              ),
              StreamBuilder(
                stream: isAdmin(context)
                    ? FirebaseHelper().getStream(
                        collectionId: LogBloodMarkConstant.collection)
                    : FirebaseHelper().getStreamWithWhere(
                        collectionId: LogBloodMarkConstant.collection,
                        whereId: LogBloodMarkConstant.userId,
                        whereValue: getUserId(),
                      ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator.adaptive();
                  }
                  final data = snapshot.data;
                  if (data?.docs != null && data!.docs.isNotEmpty) {
                    loggedBloodMarks = data.docs
                        .map((e) => LogBloodMark.fromMap(e.data(), e.id))
                        .toList()
                      ..sort((a, b) {
                        return DateTime.parse(b.dateTime.split(" ").first)
                            .compareTo(
                                DateTime.parse(a.dateTime.split(" ").first));
                      });
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
                            onTap: () => navigate(
                              context,
                              LogBloodMarkDetailScreen(
                                logBloodMark: loggedBloodMarks[index],
                              ),
                            ),
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey.shade300,
                              child: const Icon(
                                Icons.info_outline,
                              ),
                            ),
                            title: Text(
                              loggedBloodMarks[index].dateTime,
                            ),
                            subtitle: Text(
                              loggedBloodMarks[index]
                                      .bloodMark
                                      ?.name
                                      .toString() ??
                                  "",
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                      ),
                      separatorBuilder: (_, __) => SizedBox(
                        height: 8.h,
                      ),
                      itemCount: loggedBloodMarks.length,
                      shrinkWrap: true,
                      primary: false,
                    );
                  }
                  return const Center(
                    child: Text("No blood mark logged till now"),
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
