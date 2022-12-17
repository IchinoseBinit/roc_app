import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '/constants/constants.dart';
import '/models/firebase_user.dart';
import '/providers/user_provider.dart';
import '/screens/register_screen.dart';
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
      appBar: AppBar(
        title: const Text("Login"),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: basePadding,
        child: SingleChildScrollView(
          child: AutofillGroup(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset(
                    ImageConstants.logoWithName,
                    width: .4.sw,
                    height: .25.sh,
                  ),
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
                  GeneralTextField(
                    labelText: "Password",
                    autoFillHints: const [AutofillHints.password],
                    obscureText: true,
                    controller: passwordController,
                    textInputType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    validate: (value) =>
                        ValidationMixin().validatePassword(value!),
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
        final firestore = FirebaseFirestore.instance;
        final data = await firestore
            .collection(UserConstants.userCollection)
            .where(UserConstants.userId, isEqualTo: user.uid)
            .get();
        var map = {};
        if (data.docs.isEmpty) {
          map = FirebaseUser(
            displayName: user.displayName,
            email: user.email,
            photoUrl: user.photoURL,
            uuid: user.uid,
          ).toJson();
        } else {
          map = data.docs.first.data();
        }
        Provider.of<UserProvider>(context, listen: false).setUser(map);
      }
      Navigator.pop(context);
      // TODO: Navigated
    } on FirebaseAuthException catch (ex) {
      Navigator.pop(context);
      var message = "";
      if (ex.code == "wrong-password") {
        message = "The password is incorrect";
      } else if (ex.code == "user-not-found") {
        message = "The user is not registered";
      }
      await GeneralAlertDialog().customAlertDialog(context, message);
    } catch (ex) {
      Navigator.pop(context);
      await GeneralAlertDialog().customAlertDialog(context, ex.toString());
    }
  }
}
