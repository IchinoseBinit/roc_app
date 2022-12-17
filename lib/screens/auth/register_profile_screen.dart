import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '/screens/auth/login_screen.dart';
import '/widgets/body_template.dart';

import '/constants/constants.dart';
import '/providers/user_provider.dart';
import '/utils/firebase_helper.dart';
import '/utils/navigate.dart';
import '/utils/validation_mixin.dart';
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
  final isFoodDonorController = TextEditingController();
  final panController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: BodyTemplate(
          child: Form(
        key: formKey,
        child: Column(
          children: [
            // Hero(
            //   tag: "image-url",
            //   child: SizedBox(
            //     height: SizeConfig.height * 16,
            //     width: SizeConfig.height * 16,
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(SizeConfig.height * 8),
            //       child: profileData.image == null
            //           ? Icon(
            //               Icons.person,
            //               size: SizeConfig.height * 15,
            //             )
            //           : Image.memory(
            //               base64Decode(profileData.image!),
            //               fit: BoxFit.cover,
            //             ),
            //     ),
            //   ),
            // ),
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
            // SizedBox(
            //   height: SizeConfig.height * 2,
            // ),
            // IsFoodDonor(
            //   controller: isFoodDonorController,
            //   panController: panController,
            // ),
            SizedBox(
              height: 32.h,
            ),
            GeneralElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  try {
                    // print("hello");
                    // final map =
                    //     Provider.of<UserProvider>(context, listen: false)
                    //         .createUser(
                    //   uuid: uuid,
                    //   email: email,
                    //   name: nameController.text,
                    //   address: addressController.text,
                    //   phoneNumber: phoneController.text,
                    //   panNumber: panController.text.isEmpty
                    //       ? null
                    //       : panController.text,
                    // );
                    // print("hello");
                    // await FirebaseHelper().addOrUpdateContent(
                    //   context,
                    //   collectionId: UserConstants.userCollection,
                    //   whereId: UserConstants.userId,
                    //   whereValue: uuid,
                    //   map: map,
                    // );
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
      )),
    );
  }

  Future<void> showBottomSheet(BuildContext context) async {
    final imagePicker = ImagePicker();

    await showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: basePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Choose a source",
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 16.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildChooseOptions(
                  context,
                  func: () async {
                    final xFile =
                        await imagePicker.pickImage(source: ImageSource.camera);
                    if (xFile != null) {
                      final unit8list = await xFile.readAsBytes();
                      Provider.of<UserProvider>(context, listen: false)
                          .updateUserImage(base64Encode(unit8list));
                    }
                  },
                  iconData: Icons.camera_outlined,
                  label: "Camera",
                ),
                buildChooseOptions(
                  context,
                  func: () {},
                  iconData: Icons.collections_outlined,
                  label: "Gallery",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Column buildChooseOptions(
    BuildContext context, {
    required Function func,
    required IconData iconData,
    required String label,
  }) {
    return Column(
      children: [
        IconButton(
          onPressed: () {
            print("object");
            func();
          },
          color: Theme.of(context).primaryColor,
          iconSize: 48.h,
          icon: Icon(iconData),
        ),
        Text(label),
      ],
    );
  }
}
