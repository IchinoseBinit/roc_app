import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roc_app/constants/constants.dart';
import 'package:roc_app/utils/file_compressor.dart';
import 'package:roc_app/widgets/custom_loading_indicator.dart';

class CustomImagePicker {
  Future<String?> showBottomSheet(BuildContext context) async {
    final imagePicker = ImagePicker();

    return await showModalBottomSheet<String>(
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
                      onLoading(context);
                      final int sizeInBytes = await xFile.length();
                      final double sizeInMb = sizeInBytes / 1000000;
                      late String image;
                      if (sizeInMb > 1.0) {
                        final compressedFile = await compressFile(xFile);
                        if (compressedFile != null) {
                          image = base64Encode(compressedFile);
                        }
                      } else {
                        final unit8list = await xFile.readAsBytes();
                        image = base64Encode(unit8list);
                      }
                      Navigator.pop(context, image);
                    }
                  },
                  iconData: Icons.camera_outlined,
                  label: "Camera",
                ),
                buildChooseOptions(
                  context,
                  func: () async {
                    final xFile = await imagePicker.pickImage(
                        source: ImageSource.gallery);
                    if (xFile != null) {
                      final int sizeInBytes = await xFile.length();
                      final double sizeInMb = sizeInBytes / 1000000;
                      late String image;
                      if (sizeInMb > 1.0) {
                        final compressedFile = await compressFile(xFile);
                        if (compressedFile != null) {
                          image = base64Encode(compressedFile);
                        }
                      } else {
                        final unit8list = await xFile.readAsBytes();
                        image = base64Encode(unit8list);
                      }

                      Navigator.pop(context, image);
                    }
                  },
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
