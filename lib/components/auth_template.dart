import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthTemplate extends StatelessWidget {
  const AuthTemplate({Key? key, required this.title, required this.description})
      : super(key: key);

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(
        //   height: 20.h,
        // ),
        // Image.asset(
        //   ImageConstant.bannerImage,
        //   width: .7.sw,
        // ),
        SizedBox(
          height: 52.h,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headline5,
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}
