import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roc_app/constants/constants.dart';
import 'package:roc_app/utils/firebase_helper.dart';
import 'package:roc_app/utils/show_toast_message.dart';
import 'package:roc_app/utils/util.dart';
import 'package:roc_app/utils/validation_mixin.dart';
import 'package:roc_app/widgets/body_template.dart';
import 'package:roc_app/widgets/custom_loading_indicator.dart';
import 'package:roc_app/widgets/general_alert_dialog.dart';
import 'package:roc_app/widgets/general_elevated_button.dart';
import 'package:roc_app/widgets/general_text_field.dart';
import 'package:roc_app/widgets/header_template.dart';

class AboutUsFormScreen extends StatelessWidget {
  AboutUsFormScreen({super.key});

  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BodyTemplate(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const HeaderTemplate(headerText: "About Us Form"),
                SizedBox(
                  height: 24.h,
                ),
                StreamBuilder(
                    stream: FirebaseHelper().getStream(
                      collectionId: "about",
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator.adaptive();
                      }
                      final data = snapshot.data;
                      if (data != null && data.docs.isNotEmpty) {
                        if (descriptionController.text.isEmpty) {
                          descriptionController.text =
                              data.docs.first["description"] ?? aboutText;
                        }
                        return GeneralTextField(
                          labelText: "Description",
                          obscureText: false,
                          maxLines: 15,
                          textInputType: TextInputType.multiline,
                          validate: (value) => ValidationMixin()
                              .validate(value, title: "Description"),
                          textInputAction: TextInputAction.newline,
                          controller: descriptionController,
                        );
                      }

                      if (descriptionController.text.isEmpty) {
                        descriptionController.text = aboutText;
                      }
                      return GeneralTextField(
                        labelText: "Description",
                        obscureText: false,
                        maxLines: 15,
                        textInputType: TextInputType.multiline,
                        validate: (value) => ValidationMixin()
                            .validate(value, title: "Description"),
                        textInputAction: TextInputAction.newline,
                        controller: descriptionController,
                      );
                    }),
                SizedBox(
                  height: 24.h,
                ),
                GeneralElevatedButton(
                    title: "Save",
                    onPressed: () async {
                      try {
                        onLoading(context);
                        await FirebaseHelper().addOrUpdateContent(
                          context,
                          map: {
                            "description": getText(descriptionController),
                            "uuid": "admin",
                          },
                          collectionId: "about",
                          whereId: "uuid",
                          whereValue: "admin",
                        );
                        Navigator.pop(context);
                        Navigator.pop(context);
                        showToast("Added description");
                      } catch (ex) {
                        Navigator.pop(context);
                        GeneralAlertDialog()
                            .customAlertDialog(context, ex.toString());
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
