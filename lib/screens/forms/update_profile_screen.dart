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
}
