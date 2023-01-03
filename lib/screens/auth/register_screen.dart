import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/screens/navigation/navigation_screen.dart';
import '/screens/auth/register_profile_screen.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50.r),
                ),
              ),
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).viewPadding.top + 8.w,
                bottom: 16.w,
                right: 16.w,
                left: 16.w,
              ),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 20.h,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Log Tracker",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Image.asset(
                        ImageConstants.logo,
                        width: .25.sw,
                        height: .15.sh,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: basePadding,
              child: SingleChildScrollView(
                  child: Form(
                key: formKey,
                child: Column(
                  children: [
                    GeneralTextField(
                      labelText: "Email",
                      obscureText: false,
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validate: (value) =>
                          ValidationMixin().validateEmail(value!),
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
                      validate: (value) =>
                          ValidationMixin().validatePassword(value!),
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
          ],
        ),
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
          // navigate(
          //   context,
          //   RegisterProfileScreen(
          //     uuid: credential.user!.uid,
          //     email: credential.user!.email!,
          //   ),
          // );
          navigate(context, NavigationScreen());
        }
      }
    } on FirebaseAuthException catch (ex) {
      Navigator.pop(context);
      var message = "";
      if (ex.code == "email-already-in-use") {
        message = "The email address is already used";
      } else if (ex.code == "weak-password") {
        message = "The password is too weak";
      } else {
        message = ex.message ?? "";
      }
      await GeneralAlertDialog().customAlertDialog(context, message);
    } catch (ex) {
      Navigator.pop(context);
      await GeneralAlertDialog().customAlertDialog(context, ex.toString());
    }
  }
}
