import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/components/password_field.dart';

class SetPasswordComponent extends StatefulWidget {
  const SetPasswordComponent({
    Key? key,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.passwordFocusNode,
  }) : super(key: key);
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final FocusNode passwordFocusNode;

  @override
  State<SetPasswordComponent> createState() => _SetPasswordComponentState();
}

class _SetPasswordComponentState extends State<SetPasswordComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PasswordField(
          controller: widget.passwordController,
          onSave: () => widget.passwordFocusNode.requestFocus(),
          onChanged: () {
            setState(() {});
          },
        ),
        SizedBox(
          height: 20.h,
        ),
        PasswordField(
          focusNode: widget.passwordFocusNode,
          controller: widget.confirmPasswordController,
          confirmVal: widget.passwordController.text.trim(),
          isConfirmPassword: true,
        ),
      ],
    );
  }
}
