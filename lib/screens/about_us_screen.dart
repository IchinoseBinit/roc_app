import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roc_app/utils/firebase_helper.dart';
import '/constants/constants.dart';
import '/widgets/body_template.dart';
import '/widgets/header_template.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BodyTemplate(
          child: Column(
            children: [
              const HeaderTemplate(headerText: "About Us"),
              SizedBox(
                height: 24.h,
              ),
              Image.asset(
                ImageConstants.logoWithName,
                height: 144.h,
                width: 280.w,
              ),
              SizedBox(
                height: 12.h,
              ),
              StreamBuilder(
                  stream: FirebaseHelper().getStream(
                    collectionId: "about",
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator.adaptive();
                    }
                    final data = snapshot.data;
                    if (data != null && data.docs.isNotEmpty) {
                      return Text(
                        data.docs.first["description"] ?? aboutText,
                        style: Theme.of(context).textTheme.bodyText1,
                      );
                    }

                    return Text(
                      aboutText,
                      style: Theme.of(context).textTheme.bodyText1,
                    );
                  }),
              SizedBox(
                height: 24.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.facebook_outlined,
                    size: 20.h,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
