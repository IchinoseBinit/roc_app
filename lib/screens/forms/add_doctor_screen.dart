import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/utils/validation_mixin.dart';
import '/widgets/body_template.dart';
import '/widgets/general_elevated_button.dart';
import '/widgets/general_text_field.dart';
import '/widgets/header_template.dart';

class AddDoctorScreen extends StatelessWidget {
  AddDoctorScreen({super.key});

  final fullNameController = TextEditingController();
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
                textInputType: TextInputType.text,
                validate: (v) => ValidationMixin().validate(v, title: "Review"),
                textInputAction: TextInputAction.newline,
              ),
              SizedBox(
                height: 24.h,
              ),
              GeneralElevatedButton(
                title: "Submit",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
