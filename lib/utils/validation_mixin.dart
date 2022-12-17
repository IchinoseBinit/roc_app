import 'package:flutter/cupertino.dart';

class ValidationMixin {
  validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "Email is required";
    } else if (!regExp.hasMatch(value.trim())) {
      return "Your email address is invalid";
    } else {
      return null;
    }
  }

  String? validatePassword(String value,
      {bool isConfirmPassword = false, String confirmValue = ""}) {
    if (value.trim().isEmpty) {
      return "Password is required";
    }
    if (isConfirmPassword) {
      if (value != confirmValue) {
        return "Your both passwords does not match";
      }
    }
    return null;
  }

  validate(String value, {String? title}) {
    if (value.trim().isEmpty) {
      return title == null
          ? "This field is required"
          : "$title field is required";
    }
    return null;
  }
}
