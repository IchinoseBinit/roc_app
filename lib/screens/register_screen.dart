import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/screens/register_profile_screen.dart';
import '/utils/navigate.dart';
import '/widgets/general_elevated_button.dart';
import '/constants/constants.dart';
import '/utils/validation_mixin.dart';
import '/widgets/general_alert_dialog.dart';
import '/widgets/general_text_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final confirmPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: basePadding,
        child: SingleChildScrollView(
            child: Form(
          key: formKey,
          child: Column(
            children: [
              Image.asset(
                ImageConstants.logo,
                width: .4.sw,
                height: .25.sh,
              ),
              SizedBox(
                height: 8.h,
              ),
              GeneralTextField(
                labelText: "Email",
                obscureText: false,
                controller: emailController,
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validate: (value) => ValidationMixin().validateEmail(value!),
              ),
              SizedBox(
                height: 16.h,
              ),
              GeneralTextField(
                labelText: "Password",
                obscureText: true,
                controller: passwordController,
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                validate: (value) => ValidationMixin().validatePassword(value!),
              ),
              SizedBox(
                height: 16.h,
              ),
              GeneralTextField(
                labelText: "Confirm Password",
                obscureText: true,
                focusNode: confirmPasswordFocusNode,
                controller: confirmPasswordController,
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                validate: (value) => ValidationMixin().validatePassword(
                  passwordController.text,
                  isConfirmPassword: true,
                  confirmValue: value!,
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              GeneralElevatedButton(
                onPressed: () async {
                  await submit(context);
                },
                title: "Register",
              ),
            ],
          ),
        )),
      ),
    );
  }

  submit(context) async {
    try {
      if (formKey.currentState!.validate()) {
        final firebaseAuth = FirebaseAuth.instance;
        GeneralAlertDialog().customLoadingDialog(context);
        final credential = await firebaseAuth.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        if (credential.user?.uid != null) {
          Navigator.pop(context);
          navigate(
            context,
            RegisterProfileScreen(
              uuid: credential.user!.uid,
              email: credential.user!.email!,
            ),
          );
        }
      }
    } on FirebaseAuthException catch (ex) {
      Navigator.pop(context);
      var message = "";
      if (ex.code == "email-already-in-use") {
        message = "The email address is already used";
      } else if (ex.code == "weak-password") {
        message = "The password is too weak";
      }
      await GeneralAlertDialog().customAlertDialog(context, message);
    } catch (ex) {
      Navigator.pop(context);
      await GeneralAlertDialog().customAlertDialog(context, ex.toString());
    }
  }
}
