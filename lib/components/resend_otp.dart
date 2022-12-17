import 'package:flutter/material.dart';

import '/components/otp_timer.dart';

class ResendOtp extends StatefulWidget {
  const ResendOtp({Key? key, required this.otpResendFunction})
      : super(key: key);

  final Function otpResendFunction;

  @override
  State<ResendOtp> createState() => _ResendOtpState();
}

class _ResendOtpState extends State<ResendOtp> {
  bool canReSendCode = false;
  final canSendEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    canSendEditingController.addListener(() {
      if (canSendEditingController.text == "0") {
        setState(() => canReSendCode = !canReSendCode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: canReSendCode
              ? () {
                  // showDialog(
                  //   context: context,
                  //   builder: (context) {
                  //     return ShowAlertDialogBox(
                  //       func: widget.otpResendFunction,
                  //       secondFunc: () => setState(() {
                  //         canReSendCode = !canReSendCode;
                  //       }),
                  //       title: "OTP sent successfully",
                  //     );
                  //   },
                  // );
                }
              : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Icon(
                Icons.sync,
                size: 18,
              ),
              const Text(
                " Re-send OTP ",
              ),
              if (!canReSendCode)
                const Text(
                  "in (00:",
                  style: TextStyle(color: Colors.red),
                ),
              if (!canReSendCode)
                OtpTimer(
                  editingController: canSendEditingController,
                ),
              if (!canReSendCode)
                const Text(
                  ")",
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        )
      ],
    );
  }
}
