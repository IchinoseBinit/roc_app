import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GeneralAlertDialog {
  customAlertDialog(BuildContext context, String message) async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Ok"),
          )
        ],
      ),
    );
  }

  customLoadingDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            SizedBox(
              width: 10.w,
            ),
            const Text("Loading"),
          ],
        ),
      ),
    );
  }
}
