import 'dart:async';

import 'package:flutter/material.dart';

class OtpTimer extends StatefulWidget {
  const OtpTimer({
    Key? key,
    required this.editingController,
  }) : super(key: key);

  final TextEditingController editingController;

  @override
  State<OtpTimer> createState() => OtpTimerState();
}

class OtpTimerState extends State<OtpTimer> {
  late Timer timer;
  int seconds = 60;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds > 1) {
        widget.editingController.text = seconds.toString();
        if (mounted) {
          setState(() => seconds--);
        }
      } else if (seconds == 1) {
        widget.editingController.text = "0";
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sec = seconds.toString().length > 1 ? "$seconds" : "0$seconds";
    return Text(
      sec,
      style: const TextStyle(color: Colors.red),
    );
  }
}
