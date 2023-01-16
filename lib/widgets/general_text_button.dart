import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GeneralTextButton extends StatelessWidget {
  final String title;
  final Color? bgColor;
  final Color? fgColor;
  final Color? prefixColor;
  final Color? borderColor;
  final double? borderSize;
  final double? imageH;
  final bool isSmallText;
  final IconData? prefixIcon;
  final VoidCallback? onPressed;
  final String? prefixImage;
  final double? borderRadius;
  final double? height;
  final double? marginH;

  const GeneralTextButton({
    Key? key,
    this.isSmallText = false,
    required this.title,
    this.borderSize,
    this.borderColor,
    this.bgColor,
    this.fgColor,
    this.onPressed,
    this.borderRadius,
    this.height,
    this.marginH,
    this.prefixImage,
    this.prefixColor,
    this.imageH,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: marginH ?? 0,
      ),
      height: height ?? 48.h,
      child: OutlinedButton(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          backgroundColor:
              MaterialStateProperty.all(bgColor ?? Colors.transparent),
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(
              color: borderColor ?? Colors.blue.shade700,
              width: borderSize ?? 1,
            ),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 6),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefixIcon != null)
              Icon(
                prefixIcon,
                color: prefixColor ?? Theme.of(context).primaryColor,
                size: imageH ?? 24,
              ),
            if (prefixImage != null)
              Image.asset(
                prefixImage!,
                height: imageH ?? 24,
                color: prefixColor,
              ),
            if (prefixImage != null || prefixIcon != null)
              const SizedBox(
                width: 5,
              ),
            Text(
              title,
              style: isSmallText
                  ? Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: fgColor ?? Colors.blue.shade700,
                      fontWeight: FontWeight.w600)
                  : Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: fgColor ?? Colors.blue.shade700,
                      fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
