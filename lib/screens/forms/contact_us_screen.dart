import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/utils/validation_mixin.dart';
import '/widgets/body_template.dart';
import '/widgets/general_elevated_button.dart';
import '/widgets/general_text_field.dart';
import '/widgets/header_template.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({super.key});
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BodyTemplate(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderTemplate(headerText: "Contact Us"),
              SizedBox(
                height: 24.h,
              ),
              GeneralTextField(
                labelText: "Name",
                controller: nameController,
                obscureText: false,
                textInputType: TextInputType.name,
                validate: (v) => ValidationMixin().validate(v, title: "Name"),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 12.h,
              ),
              GeneralTextField(
                labelText: "Email Address",
                controller: emailController,
                obscureText: false,
                textInputType: TextInputType.emailAddress,
                validate: (v) =>
                    ValidationMixin().validate(v, title: "Email Address"),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 12.h,
              ),
              GeneralTextField(
                labelText: "Subject",
                controller: subjectController,
                obscureText: false,
                textInputType: TextInputType.text,
                validate: (v) =>
                    ValidationMixin().validate(v, title: "Subject"),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 12.h,
              ),
              GeneralTextField(
                labelText: "Message",
                controller: messageController,
                obscureText: false,
                maxLines: 5,
                textInputType: TextInputType.multiline,
                validate: (v) =>
                    ValidationMixin().validate(v, title: "Message"),
                textInputAction: TextInputAction.newline,
              ),
              SizedBox(
                height: 12.h,
              ),
              Text(
                "Note: Your message will be sent to the admin and you will get the reply soon.",
                style: Theme.of(context).textTheme.bodyText2,
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
