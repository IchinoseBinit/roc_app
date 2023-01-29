import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roc_app/constants/constants.dart';
import 'package:roc_app/screens/auth/register_profile_screen.dart';
import 'package:roc_app/utils/navigate.dart';
import 'package:roc_app/widgets/custom_loading_indicator.dart';
import 'package:roc_app/widgets/general_elevated_button.dart';

class VerifyRegisterScreen extends StatefulWidget {
  const VerifyRegisterScreen({super.key, this.isFromLogin = false});

  final bool isFromLogin;

  @override
  State<VerifyRegisterScreen> createState() => _VerifyRegisterScreenState();
}

class _VerifyRegisterScreenState extends State<VerifyRegisterScreen> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 5), (_) async {
      await FirebaseAuth.instance.currentUser!.reload();
      final user = FirebaseAuth.instance.currentUser!;

      final isEmailVerified = user.emailVerified;
      if (isEmailVerified) {
        timer.cancel();
        if (widget.isFromLogin) {
          Navigator.pop(context);
        } else {
          navigateReplacement(context,
              RegisterProfileScreen(uuid: user.uid, email: user.email!));
        }
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
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
                    child: Column(
                  children: [
                    const Text(
                      "A verification link has been sent to your address. Please click on it to activate.",
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    GeneralElevatedButton(
                      onPressed: () async {
                        await onSubmit(context);
                      },
                      title: "Resend Email",
                    ),
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onSubmit(BuildContext context) async {
    onLoading(context);
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
    Navigator.pop(context);
  }
}
