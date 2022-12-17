import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '/utils/show_toast_message.dart';

class ErrorHandler {
  static const errorMessage =
      "Cannot process at the moment. Please try again later.";

  errorHandler(
    BuildContext context,
    Object ex,
  ) {
    print(ex);
    final isFormatException = ex.runtimeType.toString() == "_TypeError";

    if (isFormatException) {
      Navigator.pop(context);
      showToast(ex.toString(), color: baseColor);
    } else {
      Navigator.pop(context);
      showToast(ex.toString(), color: baseColor);
    }
  }
}
