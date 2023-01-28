import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roc_app/models/blood_mark.dart';
import 'package:roc_app/models/symptom.dart';
import 'package:roc_app/screens/forms/blood_mark/add_blood_mark_screen.dart';
import 'package:roc_app/screens/forms/add_symptoms_screen.dart';
import 'package:roc_app/screens/graphs/blood_mark_graph_screen.dart';
import 'package:roc_app/utils/navigate.dart';
import 'package:roc_app/widgets/general_elevated_button.dart';

import '/constants/constants.dart';
import '/utils/firebase_helper.dart';
import '/utils/util.dart';
import '/widgets/body_template.dart';
import '/widgets/header_template.dart';

class SymptomsListScreen extends StatefulWidget {
  const SymptomsListScreen({super.key});

  @override
  State<SymptomsListScreen> createState() => _SymptomsListScreenState();
}

class _SymptomsListScreenState extends State<SymptomsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: isAdmin(context)
          ? null
          : Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: GeneralElevatedButton(
                marginH: 16.h,
                title: "Add Symptom",
                onPressed: () => navigate(context, AddSymptomsScreen()),
              ),
            ),
      body: SafeArea(
        child: BodyTemplate(
          child: Column(
            children: [
              const HeaderTemplate(
                headerText: "List of Symptoms",
              ),
              SizedBox(
                height: 24.h,
              ),
              StreamBuilder(
                stream: FirebaseHelper().getStreamWithWhere(
                  collectionId: SymptomConstant.symptomCollection,
                  whereId: UserConstants.userId,
                  whereValue: getUserId(),
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator.adaptive();
                  }
                  final data = snapshot.data;
                  if (data?.docs != null && data!.docs.isNotEmpty) {
                    final symptoms = data.docs
                        .map((e) => Symptom.fromMap(e.data()))
                        .toList();

                    return ListView.separated(
                      itemBuilder: (_, index) => InkWell(
                        onTap: () => Navigator.pop(context, symptoms[index]),
                        child: Card(
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
                                symptoms[index].symptom,
                              ),
                              subtitle: Text(
                                "Rate: ${symptoms[index].rate}",
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 18.h,
                              ),
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (_, __) => SizedBox(
                        height: 8.h,
                      ),
                      itemCount: symptoms.length,
                      shrinkWrap: true,
                      primary: false,
                    );
                  }
                  return const Center(
                    child: Text("No Symptoms saved till now"),
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
