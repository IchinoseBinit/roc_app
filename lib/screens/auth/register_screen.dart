import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roc_app/components/password_field.dart';
import 'package:roc_app/screens/auth/login_screen.dart';
import 'package:roc_app/screens/auth/verify_register_screen.dart';

import '/constants/constants.dart';
import '/utils/navigate.dart';
import '/utils/validation_mixin.dart';
import '/widgets/general_alert_dialog.dart';
import '/widgets/general_elevated_button.dart';
import '/widgets/general_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final confirmPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => navigateReplacement(context, LoginScreen()),
      child: Scaffold(
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
                      onPressed: () =>
                          navigateReplacement(context, LoginScreen()),
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
                      PasswordField(
                        controller: passwordController,
                        onChanged: () {
                          setState(() {});
                        },
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      PasswordField(
                        isConfirmPassword: true,
                        focusNode: confirmPasswordFocusNode,
                        controller: confirmPasswordController,
                        confirmVal: passwordController.text,
                        onChanged: () {
                          setState(() {});
                        },
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
          await credential.user!.sendEmailVerification();
          Navigator.pop(context);
          navigate(
            context,
            const VerifyRegisterScreen(),
          );
          // navigate(context, NavigationScreen());
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
