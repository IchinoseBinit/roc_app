import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:roc_app/components/password_field.dart';
import 'package:roc_app/models/firebase_user.dart';
import 'package:roc_app/providers/user_provider.dart';
import 'package:roc_app/screens/auth/forgot_password_screen.dart';
import 'package:roc_app/screens/auth/register_profile_screen.dart';
import 'package:roc_app/screens/auth/verify_register_screen.dart';
import 'package:roc_app/widgets/body_template.dart';

import '/constants/constants.dart';
import '/screens/auth/register_screen.dart';
import '/screens/navigation/navigation_screen.dart';
import '/utils/navigate.dart';
import '/utils/validation_mixin.dart';
import '/widgets/general_alert_dialog.dart';
import '/widgets/general_elevated_button.dart';
import '/widgets/general_text_button.dart';
import '/widgets/general_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyTemplate(
        padding: EdgeInsets.zero,
        child: AutofillGroup(
          child: Form(
            key: formKey,
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
                    left: 16.w,
                    right: 16.w,
                    top: 32.w,
                    bottom: 16.w,
                  ),
                  alignment: Alignment.center,
                  child: Row(
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
                ),
                Padding(
                  padding: basePadding,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8.h,
                      ),
                      GeneralTextField(
                        labelText: "Email",
                        autoFillHints: const [AutofillHints.email],
                        controller: emailController,
                        textInputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        validate: (value) =>
                            ValidationMixin().validateEmail(value!),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      PasswordField(
                        controller: passwordController,
                      ),
                      SizedBox(height: 8.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () => navigate(
                            context,
                            ForgotPasswordScreen(),
                          ),
                          child: const Text("Forgot Password?"),
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      GeneralElevatedButton(
                        onPressed: () {
                          _submit(
                            context,
                          );
                        },
                        title: "Login",
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      GeneralTextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RegisterScreen(),
                            ),
                          );
                        },
                        title: "Register",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context) async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }
      final firebaseAuth = FirebaseAuth.instance;
      GeneralAlertDialog().customLoadingDialog(context);
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      final user = userCredential.user;
      if (user != null) {
        if (!user.emailVerified) {
          await navigate(context, VerifyRegisterScreen());
        }
        final firestore = FirebaseFirestore.instance;
        final data = await firestore
            .collection(UserConstants.userCollection)
            .where(UserConstants.userId, isEqualTo: user.uid)
            .get();
        var map = {};
        if (data.docs.isEmpty) {
          navigateAndRemoveAll(context,
              RegisterProfileScreen(uuid: user.uid, email: user.email ?? ""));
          return;
        } else {
          map = data.docs.first.data();
        }
        Provider.of<UserProvider>(context, listen: false).setUser(map);

        Navigator.pop(context);
        navigateAndRemoveAll(context, NavigationScreen());
      }
    } on FirebaseAuthException catch (ex) {
      Navigator.pop(context);
      var message = "";
      if (ex.code == "wrong-password") {
        message = "The password is incorrect";
      } else if (ex.code == "user-not-found") {
        message = "The user is not registered";
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
