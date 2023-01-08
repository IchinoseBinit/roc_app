import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:roc_app/constants/constants.dart';
import 'package:roc_app/models/blood_mark.dart';
import 'package:roc_app/models/educational_resources.dart';
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

class AddEducationalResourcesScreen extends StatelessWidget {
  AddEducationalResourcesScreen({
    super.key,
    this.resource,
  });

  final EducationalResource? resource;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (resource != null) {
      titleController.text = resource!.title;
      descriptionController.text = resource!.description;
    }
    return Scaffold(
      body: SafeArea(
        child: BodyTemplate(
          child: Column(
            children: [
              const HeaderTemplate(headerText: "Add Educational Resources"),
              SizedBox(
                height: 24.h,
              ),
              GeneralTextField(
                labelText: "Title",
                controller: titleController,
                obscureText: false,
                textInputType: TextInputType.text,
                validate: (v) => ValidationMixin().validate(v, title: "Title"),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 12.h,
              ),
              GeneralTextField(
                labelText: "Description",
                controller: descriptionController,
                obscureText: false,
                maxLines: 5,
                textInputType: TextInputType.multiline,
                validate: (v) =>
                    ValidationMixin().validate(v, title: "Description"),
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
                    if (resource == null) {
                      map = EducationalResource(
                        title: getText(titleController),
                        description: getText(descriptionController),
                      ).toJson();
                    } else {
                      map = EducationalResource(
                        title: getText(titleController),
                        description: getText(descriptionController),
                        id: resource!.id,
                      ).toJson();
                    }
                    await FirebaseHelper().addData(
                      context,
                      map: map,
                      collectionId: EducationalResourceConstant.resource,
                    );
                    showToast(
                        "Educational Resource ${resource == null ? 'added' : 'updated'} successfully");
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
