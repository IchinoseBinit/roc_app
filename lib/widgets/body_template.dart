import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '/widgets/custom_scroll_behaviour.dart';

class BodyTemplate extends StatelessWidget {
  const BodyTemplate({
    Key? key,
    required this.child,
    this.padding,
    this.scrollController,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets? padding;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: MediaQuery.of(context).size.height,
      padding: padding ?? basePadding,
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          controller: scrollController,
          child: child,
        ),
      ),
    );
  }
}
