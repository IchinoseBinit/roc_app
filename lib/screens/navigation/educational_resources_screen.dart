import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/widgets/body_template.dart';
import '/widgets/header_template.dart';

class EducationalResourcesScreen extends StatelessWidget {
  const EducationalResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BodyTemplate(
          child: Column(
            children: [
              const HeaderTemplate(
                headerText: "Educational Resources",
                needBackButton: false,
              ),
              SizedBox(
                height: 24.h,
              ),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  mainAxisSpacing: 32.h,
                  crossAxisSpacing: 16.w,
                ),
                itemCount: 4,
                itemBuilder: (_, index) => Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0XFF4A9DBF).withOpacity(.5),
                      width: 4,
                    ),
                    color: const Color(0XFFF9EDD7),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Introduction to Ovarion Cancer",
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: const Color(0XFF34809F),
                            ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        "A cancer that begins in the female organs that produce eggs(ovaries).",
                        style: Theme.of(context).textTheme.bodyText2,
                      )
                    ],
                  ),
                ),
                shrinkWrap: true,
                primary: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
