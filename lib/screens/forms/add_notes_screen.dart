import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roc_app/constants/constants.dart';
import 'package:roc_app/models/educational_resources.dart';
import 'package:roc_app/models/notes.dart';
import 'package:roc_app/utils/firebase_helper.dart';
import 'package:roc_app/utils/show_toast_message.dart';
import 'package:roc_app/utils/util.dart';
import 'package:roc_app/widgets/custom_loading_indicator.dart';
import 'package:roc_app/widgets/general_alert_dialog.dart';

import '/utils/validation_mixin.dart';
import '/widgets/body_template.dart';
import '/widgets/general_elevated_button.dart';
import '/widgets/general_text_field.dart';
import '/widgets/header_template.dart';

class AddNotesScreen extends StatelessWidget {
  AddNotesScreen({
    super.key,
    this.note,
  });

  final Note? note;

  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (note != null) {
      messageController.text = note!.message;
    }
    return Scaffold(
      body: SafeArea(
        child: BodyTemplate(
          child: Column(
            children: [
              const HeaderTemplate(headerText: "Add Notes"),
              SizedBox(
                height: 24.h,
              ),
              GeneralTextField(
                labelText: "Note",
                controller: messageController,
                obscureText: false,
                maxLines: 5,
                textInputType: TextInputType.multiline,
                validate: (v) => ValidationMixin().validate(v, title: "Note"),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 24.h,
              ),
              GeneralElevatedButton(
                title: "Save",
                onPressed: () async {
                  try {
                    onLoading(context);
                    Map<String, dynamic> map;
                    if (note == null) {
                      map = Note(
                        message: getText(messageController),
                        userId: getUserId(),
                      ).toJson();
                      await FirebaseHelper().addData(
                        context,
                        map: map,
                        collectionId: NoteConstant.notes,
                      );
                    } else {
                      map = Note(
                        message: getText(messageController),
                        userId: note!.userId,
                        id: note!.id,
                      ).toJson();
                      await FirebaseHelper().updateData(
                        context,
                        map: map,
                        collectionId: NoteConstant.notes,
                        docId: note!.id!,
                      );
                    }

                    showToast(
                        "Note ${note == null ? 'added' : 'updated'} successfully");
                    Navigator.pop(context);
                    Navigator.pop(context);
                  } catch (ex) {
                    Navigator.pop(context);
                    await GeneralAlertDialog()
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
