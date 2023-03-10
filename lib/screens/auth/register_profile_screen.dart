import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:roc_app/utils/firebase_helper.dart';
import 'package:roc_app/utils/show_toast_message.dart';
import 'package:roc_app/utils/util.dart';

import '/constants/constants.dart';
import '/providers/user_provider.dart';
import '/screens/auth/login_screen.dart';
import '/utils/navigate.dart';
import '/utils/validation_mixin.dart';
import '/widgets/body_template.dart';
import '/widgets/general_alert_dialog.dart';
import '/widgets/general_elevated_button.dart';
import '/widgets/general_text_field.dart';

class RegisterProfileScreen extends StatelessWidget {
  RegisterProfileScreen({
    Key? key,
    required this.uuid,
    required this.email,
  }) : super(key: key);

  final String uuid;
  final String email;

  // final String imageUrl;
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final cancerTypeController = TextEditingController();
  final diagonisedDateController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final adminKeyController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyTemplate(
          padding: EdgeInsets.zero,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50.r),
                    ),
                  ),
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    top: 32.w,
                    bottom: 16.w,
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 20.h,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Log Tracker",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Image.asset(
                            ImageConstants.logo,
                            width: .25.sw,
                            height: .15.sh,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: basePadding,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        "Fill your Information",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                        height: 16.h,
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
                        validate: (value) => ValidationMixin()
                            .validate(value!, title: "address"),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      GeneralTextField(
                        labelText: "Phone Number",
                        obscureText: false,
                        controller: phoneController,
                        maxLength: 10,
                        textInputType: const TextInputType.numberWithOptions(
                            decimal: false),
                        textInputAction: TextInputAction.done,
                        validate: (value) => ValidationMixin()
                            .validate(value!, title: "Phone Number"),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      GeneralTextField(
                        labelText: "Cancer Type",
                        obscureText: false,
                        controller: cancerTypeController,
                        // maxLength: 10,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        validate: (value) => ValidationMixin()
                            .validate(value!, title: "Cancer Type"),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      GeneralTextField(
                        labelText: "Date Of Birth",
                        controller: dateOfBirthController,
                        obscureText: false,
                        textInputType: TextInputType.none,
                        readonly: true,
                        suffixIcon: Icons.calendar_month_outlined,
                        suffixIconColor: Theme.of(context).primaryColor,
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.tryParse(
                                    diagonisedDateController.text) ??
                                DateTime.now(),
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 360 * 100)),
                            lastDate: DateTime.now(),
                          );
                          if (date != null) {
                            dateOfBirthController.text =
                                DateFormat("yyyy-MM-dd").format(date);
                          }
                        },
                        validate: (v) =>
                            ValidationMixin().validate(v, title: "Date"),
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      GeneralTextField(
                        labelText: "Diagonised Date",
                        controller: diagonisedDateController,
                        obscureText: false,
                        textInputType: TextInputType.none,
                        readonly: true,
                        suffixIcon: Icons.calendar_month_outlined,
                        suffixIconColor: Theme.of(context).primaryColor,
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.tryParse(
                                    diagonisedDateController.text) ??
                                DateTime.now(),
                            firstDate:
                                DateTime.tryParse(dateOfBirthController.text) ??
                                    DateTime.now()
                                        .subtract(const Duration(days: 360)),
                            lastDate: DateTime.now(),
                          );
                          if (date != null) {
                            diagonisedDateController.text =
                                DateFormat("yyyy-MM-dd").format(date);
                          }
                        },
                        validate: (v) =>
                            ValidationMixin().validate(v, title: "Date"),
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      const Text(
                        "Note: Put the key only if you are an admin user. Leave empty if you are a normal user",
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      GeneralTextField(
                        labelText: "Admin Verification Key",
                        obscureText: false,
                        hintText: "Enter the key of 3 characters",
                        controller: adminKeyController,
                        maxLength: 3,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        validate: (value) {},
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      GeneralElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            try {
                              final map = Provider.of<UserProvider>(context,
                                      listen: false)
                                  .createUser(
                                uuid: uuid,
                                email: email,
                                name: nameController.text,
                                address: addressController.text,
                                phoneNumber: phoneController.text,
                                isAdmin: adminKeyController.text == "roc",
                                cancerType: getText(cancerTypeController),
                                diagonisedDate:
                                    getText(diagonisedDateController),
                                dateOfBirth: getText(dateOfBirthController),
                              );
                              await FirebaseHelper().addOrUpdateContent(
                                context,
                                collectionId: UserConstants.userCollection,
                                whereId: UserConstants.userId,
                                whereValue: uuid,
                                map: map,
                              );
                              showToast("Successfully registered");
                              // ignore: use_build_context_synchronously
                              navigateAndRemoveAll(context, LoginScreen());
                            } catch (ex) {
                              GeneralAlertDialog()
                                  .customAlertDialog(context, ex.toString());
                            }
                          }
                        },
                        title: "Save",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
