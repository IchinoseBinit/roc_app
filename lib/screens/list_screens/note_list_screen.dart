import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roc_app/models/notes.dart';
import 'package:roc_app/screens/forms/add_notes_screen.dart';
import 'package:roc_app/screens/list_screens/log_symptom_detail_screen.dart';
import 'package:roc_app/utils/navigate.dart';
import 'package:roc_app/widgets/general_elevated_button.dart';

import '/constants/constants.dart';
import '/models/log_symptom.dart';
import '/utils/firebase_helper.dart';
import '/utils/util.dart';
import '/widgets/body_template.dart';
import '/widgets/header_template.dart';

class NoteListScreen extends StatelessWidget {
  const NoteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: isAdmin(context)
          ? null
          : Padding(
              padding: const EdgeInsets.only(
                bottom: 16,
              ),
              child: GeneralElevatedButton(
                onPressed: () => navigate(context, AddNotesScreen()),
                title: "Add Notes",
                marginH: 16,
              ),
            ),
      body: SafeArea(
        child: BodyTemplate(
          child: Column(
            children: [
              const HeaderTemplate(
                headerText: "List of Notes",
              ),
              SizedBox(
                height: 24.h,
              ),
              StreamBuilder(
                stream: FirebaseHelper().getStreamWithWhere(
                  collectionId: NoteConstant.notes,
                  whereId: NoteConstant.userId,
                  whereValue: getUserId(),
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator.adaptive();
                  }
                  final data = snapshot.data;
                  if (data?.docs != null && data!.docs.isNotEmpty) {
                    final notes = data.docs
                        .map((e) => Note.fromMap(e.data(), e.id))
                        .toList();
                    return ListView.separated(
                      itemBuilder: (_, index) => InkWell(
                        onTap: () => navigate(
                          context,
                          AddNotesScreen(
                            note: notes[index],
                          ),
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                              16.h,
                            ),
                            child: Text(
                              notes[index].message,
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (_, __) => SizedBox(
                        height: 16.h,
                      ),
                      itemCount: notes.length,
                      shrinkWrap: true,
                      primary: false,
                    );
                  }
                  return const Center(
                    child: Text("No notes saved till now"),
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
