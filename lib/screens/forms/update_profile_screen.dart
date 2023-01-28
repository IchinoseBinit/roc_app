import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '/providers/user_provider.dart';
import '/utils/validation_mixin.dart';
import '/widgets/body_template.dart';
import '/widgets/general_elevated_button.dart';
import '/widgets/general_text_field.dart';
import '/widgets/header_template.dart';

class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({super.key});

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;

    nameController.text = user.name ?? "";
    addressController.text = user.address ?? "";
    phoneController.text = user.phoneNumber;
    return Scaffold(
      body: SafeArea(
        child: BodyTemplate(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const HeaderTemplate(headerText: "Update Profile"),
                SizedBox(
                  height: 24.h,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        getText(context,
                            title: "Cancer Type", value: user.cancerType),
                        SizedBox(
                          height: 16.h,
                        ),
                        getText(context,
                            title: "Date Of Birth", value: user.dateOfBirth),
                        SizedBox(
                          height: 16.h,
                        ),
                        getText(context,
                            title: "Diagonised Date",
                            value: user.diagonisedDate),
                        SizedBox(
                          height: 16.h,
                        ),
                      ],
                    ),
                  ),
                ),
                GeneralTextField(
                  labelText: "Name",
                  obscureText: false,
                  controller: nameController,
                  textInputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validate: (value) =>
                      ValidationMixin().validate(value!, title: "name"),
                  // onFieldSubmitted: (_) {},
                ),
                SizedBox(
                  height: 12.h,
                ),
                GeneralTextField(
                  labelText: "Address",
                  obscureText: false,
                  controller: addressController,
                  textInputType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  validate: (value) =>
                      ValidationMixin().validate(value!, title: "address"),
                ),
                SizedBox(
                  height: 12.h,
                ),
                GeneralTextField(
                  labelText: "Phone Number",
                  obscureText: false,
                  controller: phoneController,
                  maxLength: 10,
                  textInputType:
                      const TextInputType.numberWithOptions(decimal: false),
                  textInputAction: TextInputAction.done,
                  validate: (value) =>
                      ValidationMixin().validate(value!, title: "Phone Number"),
                ),
                SizedBox(
                  height: 24.h,
                ),
                GeneralElevatedButton(
                  title: "Update",
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      Provider.of<UserProvider>(context, listen: false)
                          .updateUser(
                        context,
                        name: nameController.text,
                        address: addressController.text,
                        phoneNumber: phoneController.text,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
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
