import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roc_app/constants/constants.dart';
import 'package:roc_app/models/doctor.dart';
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

class AddDoctorScreen extends StatelessWidget {
  AddDoctorScreen({super.key});

  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final qualificationController = TextEditingController();
  final experienceController = TextEditingController();
  final reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BodyTemplate(
          child: Column(
            children: [
              const HeaderTemplate(headerText: "Add Doctor"),
              SizedBox(
                height: 24.h,
              ),
              GeneralTextField(
                labelText: "Full Name",
                controller: fullNameController,
                obscureText: false,
                textInputType: TextInputType.name,
                validate: (v) =>
                    ValidationMixin().validate(v, title: "Full Name"),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 12.h,
              ),
              GeneralTextField(
                labelText: "Phone Number",
                controller: phoneController,
                obscureText: false,
                textInputType: TextInputType.number,
                validate: (v) =>
                    ValidationMixin().validate(v, title: "Phone Number"),
                maxLength: 10,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 12.h,
              ),
              GeneralTextField(
                labelText: "Email",
                controller: emailController,
                obscureText: false,
                textInputType: TextInputType.emailAddress,
                validate: (v) => ValidationMixin().validateEmail(v),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 12.h,
              ),
              GeneralTextField(
                labelText: "Address",
                controller: addressController,
                obscureText: false,
                textInputType: TextInputType.streetAddress,
                validate: (v) =>
                    ValidationMixin().validate(v, title: "Address"),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 12.h,
              ),
              GeneralTextField(
                labelText: "Qualification",
                controller: qualificationController,
                obscureText: false,
                textInputType: TextInputType.text,
                validate: (v) =>
                    ValidationMixin().validate(v, title: "Qualification"),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 12.h,
              ),
              GeneralTextField(
                labelText: "Experience",
                controller: experienceController,
                obscureText: false,
                textInputType: TextInputType.text,
                validate: (v) =>
                    ValidationMixin().validate(v, title: "Experience"),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 12.h,
              ),
              GeneralTextField(
                labelText: "Review",
                controller: reviewController,
                obscureText: false,
                maxLines: 5,
                textInputType: TextInputType.multiline,
                validate: (v) => ValidationMixin().validate(v, title: "Review"),
                textInputAction: TextInputAction.newline,
              ),
              SizedBox(
                height: 24.h,
              ),
              GeneralElevatedButton(
                title: "Submit",
                onPressed: () async {
                  try {
                    onLoading(context);
                    final doctor = Doctor(
                      userId: isAdmin(context) ? null : getUserId(),
                      name: getText(fullNameController),
                      phone: getText(phoneController),
                      email: getText(emailController),
                      address: getText(addressController),
                      qualification: getText(qualificationController),
                      experience: getText(experienceController),
                      review: getText(reviewController),
                    ).toJson();
                    await FirebaseHelper().addData(
                      context,
                      map: doctor,
                      collectionId: DoctorConstant.doctorCollection,
                    );
                    showToast("Doctor added Successfully");
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
