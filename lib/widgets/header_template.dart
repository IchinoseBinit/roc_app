import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/constants/constants.dart';

class HeaderTemplate extends StatelessWidget {
  const HeaderTemplate(
      {super.key, required this.headerText, this.needBackButton = true});

  final String headerText;
  final bool needBackButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: needBackButton
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            if (needBackButton)
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 20.h,
                ),
              ),
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                ImageConstants.logo,
                height: 75.h,
                width: 75.h,
              ),
            ),
            if (needBackButton)
              SizedBox(
                width: 55.w,
              ),
          ],
        ),
        SizedBox(
          height: 40.h,
        ),
        Center(
          child: Text(
            headerText,
            style: Theme.of(context).textTheme.headline1,
          ),
        )
      ],
    );
  }
}
