import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/constants/constants.dart';
import '/widgets/body_template.dart';
import '/widgets/header_template.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  static const aboutText =
      '''Rare Ovarian Cancer Incorporated (ROC Inc.) was set up to help raise money for much needed research for Rare Ovarian Cancers.

Ovarian cancer is not just an old person’s disease. That’s a common misconception. Ovarian cancer doesn’t discriminate with age be it a child, adolescent or adult.
Through research we can improve the way that Rare Ovarian Cancers can be treated and managed.

Our Initiatives such as #RockForROC are designed to raise awareness for this important cause.

Donate today and paint a rock to spread the word.

Support Awareness and Research for Rare Ovarian Cancer
''';

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
              Text(
                aboutText,
                style: Theme.of(context).textTheme.bodyText1,
              ),
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
