import '../constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GeneralTextField extends StatefulWidget {
  final String labelText;
  final String? suffixText;
  final String? hintText;
  final bool isSmallText;
  final bool isDisabled;
  final IconData? suffixIcon;
  final Widget? preferWidget;
  final bool obscureText;
  final bool removePrefixIconDivider;
  final VoidCallback? onClickPsToggle;
  final VoidCallback? onTap;
  final TextInputType textInputType;
  final Function validate;
  final Function? onFieldSubmit;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final Function? onSave;
  final Function? onChanged;
  final TextEditingController? controller;
  final bool readonly;
  final int? maxLength;
  final double? borderRad;
  final Color? fillColor;
  final Color? borderColor;
  final Color? suffixIconColor;
  final bool isNepali;
  final double? suffixIconSize;
  final Iterable<String>? autoFillHints;
  final bool autofocus;
  final bool centerText;
  final Color? hintColor;
  final int maxLines;

  const GeneralTextField({
    Key? key,
    required this.labelText,
    this.suffixIcon,
    this.borderRad,
    this.preferWidget,
    this.suffixText,
    required this.obscureText,
    this.onClickPsToggle,
    required this.textInputType,
    required this.validate,
    this.onFieldSubmit,
    required this.textInputAction,
    this.readonly = false,
    this.focusNode,
    this.onSave,
    this.controller,
    this.onChanged,
    this.removePrefixIconDivider = false,
    this.isSmallText = false,
    this.autofocus = false,
    this.maxLength,
    this.isNepali = false,
    this.maxLines = 1,
    this.hintText,
    this.fillColor,
    this.borderColor,
    this.onTap,
    this.centerText = false,
    this.suffixIconColor,
    this.suffixIconSize,
    this.autoFillHints,
    this.isDisabled = false,
    this.hintColor,
  }) : super(key: key);

  @override
  GeneralTextFieldState createState() => GeneralTextFieldState();
}

class GeneralTextFieldState extends State<GeneralTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(
          height: 4.h,
        ),
        TextFormField(
          enabled: !widget.isDisabled,
          textAlign: widget.centerText ? TextAlign.center : TextAlign.start,
          autofocus: widget.autofocus,
          onChanged: widget.onChanged == null
              ? (_) {}
              : (newValue) => widget.onChanged!(newValue),
          controller: widget.controller,
          onSaved: widget.onSave != null
              ? (newValue) => widget.onSave!(newValue)
              : null,
          focusNode: widget.focusNode,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmit != null
              ? (newValue) => widget.onFieldSubmit!(newValue)
              : null,
          validator: (value) => widget.validate(value),
          keyboardType: widget.textInputType,
          readOnly: widget.readonly,
          onTap: widget.onTap,
          autofillHints: widget.autoFillHints,
          inputFormatters: [
            if (widget.isNepali)
              FilteringTextInputFormatter.deny(RegExp("[0-9a-zA-Z]")),
            FilteringTextInputFormatter.deny(
              RegExp(
                  r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
            ),
            LengthLimitingTextInputFormatter(widget.maxLength),
          ],
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: 14.sp,
              ),
          obscureText: widget.obscureText,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              top: widget.isSmallText ? 0 : 8.h,
              left: widget.preferWidget == null ? 12.w : 0,
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRad ?? radius),
              borderSide: BorderSide(
                color: Theme.of(context).errorColor,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRad ?? radius),
              borderSide: BorderSide(
                color: Theme.of(context).errorColor,
                width: 1,
              ),
            ),
            errorMaxLines: 3,

            // labelText: widget.labelText,
            // labelStyle: TextStyle(
            //   fontSize: widget.isSmallText ? 14.sp : 16.sp,
            //   color: Colors.grey.shade600,
            //   fontWeight: FontWeight.w400,
            // ),
            hintText: widget.hintText,

            hintStyle: TextStyle(
              fontSize: widget.isSmallText ? 12.sp : 14.sp,
              color: widget.hintColor ?? Colors.grey.shade600,
              fontWeight: FontWeight.w400,
            ),
            // suffixText: widget.suffixText,
            // suffixStyle: TextStyle(
            //   color: Colors.grey.shade600,
            //   fontSize: widget.isSmallText ? 14 : 16,
            // ),
            // suffix: widget.suffixText != null
            //     ? Text(
            //         widget.suffixText!,
            //         textAlign: TextAlign.right,
            //       )
            //     : null,
            suffixIcon: widget.suffixText != null
                ? Padding(
                    padding: EdgeInsets.only(top: 14.h),
                    child: Text(
                      widget.suffixText!,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color:
                                widget.suffixIconColor ?? Colors.grey.shade500,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : widget.suffixIcon != null
                    ? IconButton(
                        onPressed: widget.onClickPsToggle,
                        icon: Icon(
                          widget.suffixIcon,
                          color: widget.suffixIconColor ?? Colors.grey.shade400,
                          size: widget.suffixIconSize ?? 18.h,
                        ),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                      )
                    : null,
            prefixIcon: widget.preferWidget == null
                ? null
                : widget.removePrefixIconDivider
                    ? widget.preferWidget
                    : SizedBox(
                        width: 125,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            widget.preferWidget!,
                            Container(
                              height: 30,
                              width: 1,
                              color: Colors.grey.shade300,
                            )
                          ],
                        ),
                      ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRad ?? radius),
              borderSide: BorderSide(
                color: widget.borderColor ?? Colors.transparent,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRad ?? radius),
              borderSide: BorderSide(
                width: 1,
                color: widget.borderColor ?? Colors.transparent,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRad ?? radius),
              borderSide: BorderSide(
                color: widget.borderColor ?? Colors.transparent,
                width: 1,
              ),
            ),
            fillColor:
                widget.isDisabled ? const Color(0xffDEDDDD) : widget.fillColor,
            filled: true,
          ),
        ),
      ],
    );
  }
}
