import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roc_app/models/educational_resources.dart';
import 'package:roc_app/screens/forms/add_educational_resources_screen.dart';
import 'package:roc_app/utils/util.dart';

import '/models/doctor.dart';
import '/screens/forms/book_appointment_screen.dart';
import '/utils/navigate.dart';
import '/widgets/body_template.dart';
import '/widgets/general_elevated_button.dart';
import '/widgets/header_template.dart';

class EducationalResourceDetailsScreen extends StatelessWidget {
  const EducationalResourceDetailsScreen({super.key, required this.resource});

  final EducationalResource resource;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: isAdmin(context)
          ? Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: GeneralElevatedButton(
                title: "Edit",
                marginH: 16,
                onPressed: () => navigate(
                  context,
                  AddEducationalResourcesScreen(
                    resource: resource,
                  ),
                ),
              ),
            )
          : null,
      body: SafeArea(
        child: BodyTemplate(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderTemplate(headerText: resource.title),
              SizedBox(
                height: 24.h,
              ),
              Text(resource.description),
              SizedBox(
                height: 32.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DoctorBody extends StatelessWidget {
  const DoctorBody({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getText(context, title: "Name", value: doctor.name),
        SizedBox(
          height: 16.h,
        ),
        getText(context, title: "Address", value: doctor.address),
        SizedBox(
          height: 16.h,
        ),
        getText(context, title: "Qualification", value: doctor.qualification),
        SizedBox(
          height: 16.h,
        ),
        getText(context, title: "Experience", value: doctor.experience),
      ],
    );
  }

  Widget getText(BuildContext context,
      {required String title, required String value}) {
    return Text.rich(
      TextSpan(
        text: "$title: ",
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontWeight: FontWeight.bold,
            ),
        children: [
          TextSpan(
            text: value,
            style: Theme.of(context).textTheme.bodyText1,
          )
        ],
      ),
    );
  }
}
