import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roc_app/screens/list_screens/log_symptom_detail_screen.dart';
import 'package:roc_app/utils/navigate.dart';

import '/constants/constants.dart';
import '/models/log_symptom.dart';
import '/utils/firebase_helper.dart';
import '/utils/util.dart';
import '/widgets/body_template.dart';
import '/widgets/header_template.dart';

class LogSymptomsListScreen extends StatelessWidget {
  const LogSymptomsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        collectionId: LogSymptomConstant.logSymptomCollection)
                    : FirebaseHelper().getStreamWithWhere(
                        collectionId: LogSymptomConstant.logSymptomCollection,
                        whereId: UserConstants.userId,
                        whereValue: getUserId(),
                      ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator.adaptive();
                  }
                  final data = snapshot.data;
                  if (data?.docs != null && data!.docs.isNotEmpty) {
                    final loggedSymptoms = data.docs
                        .map((e) => LogSymptom.fromMap(e.data()))
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
                              loggedSymptoms[index].date,
                            ),
                            subtitle: Text(
                              loggedSymptoms[index].time,
                            ),
                            trailing: IconButton(
                              onPressed: () => navigate(
                                context,
                                LogSymptomDetailScreen(
                                  logSymptom: loggedSymptoms[index],
                                ),
                              ),
                              icon: const Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (_, __) => SizedBox(
                        height: 8.h,
                      ),
                      itemCount: loggedSymptoms.length,
                      shrinkWrap: true,
                      primary: false,
                    );
                  }
                  return const Center(
                    child: Text("No symptoms logged till now"),
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
