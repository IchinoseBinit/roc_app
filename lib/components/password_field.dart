import 'package:flutter/material.dart';

import '/utils/validation_mixin.dart';
import '/widgets/general_text_field.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    Key? key,
    required this.controller,
    this.isConfirmPassword = false,
    this.confirmVal = '',
    this.focusNode,
    this.onSave,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController controller;
  final bool isConfirmPassword;
  final String confirmVal;
  final FocusNode? focusNode;
  final VoidCallback? onSave;
  final VoidCallback? onChanged;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isObsecure = true;

  onTap() {
    isObsecure = !isObsecure;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GeneralTextField(
      focusNode: widget.focusNode,
      labelText: widget.isConfirmPassword ? "Confirm Password" : "Password",
      controller: widget.controller,
      obscureText: isObsecure,
      suffixIcon: isObsecure
          ? Icons.visibility_outlined
          : Icons.visibility_off_outlined,
      onSave: (_) {
        if (widget.onSave != null) {
          widget.onSave!();
        }
      },
      onChanged: (_) {
        if (widget.onChanged != null) {
          widget.onChanged!();
        }
      },
      textInputType: TextInputType.text,
      onFieldSubmit: (_) {},
      onClickPsToggle: onTap,
      validate: (val) => ValidationMixin().validatePassword(
        val,
        isConfirmPassword: widget.isConfirmPassword,
        confirmValue: widget.confirmVal,
      ),
      textInputAction: widget.focusNode != null
          ? TextInputAction.done
          : TextInputAction.next,
    );
  }
}
