import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:roc_app/constants/constants.dart';
import 'package:roc_app/models/doctor.dart';
import 'package:roc_app/models/doctor_comments.dart';
import 'package:roc_app/providers/user_provider.dart';
import 'package:roc_app/screens/forms/add_doctor_screen.dart';
import 'package:roc_app/screens/forms/book_appointment_screen.dart';
import 'package:roc_app/utils/firebase_helper.dart';
import 'package:roc_app/utils/show_toast_message.dart';
import 'package:roc_app/utils/util.dart';
import 'package:roc_app/utils/validation_mixin.dart';
import 'package:roc_app/widgets/custom_loading_indicator.dart';
import 'package:roc_app/widgets/general_alert_dialog.dart';
import 'package:roc_app/widgets/general_elevated_button.dart';
import 'package:roc_app/widgets/general_text_field.dart';

import '/screens/doctor_details_screen.dart';
import '/utils/navigate.dart';
import '/widgets/body_template.dart';
import '/widgets/header_template.dart';

class DoctorListScreen extends StatelessWidget {
  const DoctorListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: isAdmin(context)
          ? Padding(
              padding: const EdgeInsets.only(
                bottom: 16,
              ),
              child: GeneralElevatedButton(
                onPressed: () => navigate(context, AddDoctorScreen()),
                title: "Add Doctors",
                marginH: 16,
              ),
            )
          : null,
      body: SafeArea(
        child: BodyTemplate(
          child: Column(
            children: [
              const HeaderTemplate(
                headerText: "List of Doctors",
                needBackButton: false,
              ),
              SizedBox(
                height: 24.h,
              ),
              StreamBuilder(
                stream: FirebaseHelper()
                    .getStream(collectionId: DoctorConstant.doctorCollection),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator.adaptive();
                  }
                  final data = snapshot.data;
                  if (data?.docs == null) {
                    return const Center(
                      child: Text("No Doctors"),
                    );
                  }
                  final doctors = data!.docs
                      .map((e) => Doctor.fromMap(e.data(), e.id))
                      .toList();
                  return ListView.separated(
                    itemBuilder: (_, index) => Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 8.h,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            child: const Icon(
                              Icons.person_outlined,
                            ),
                          ),
                          title: Text(
                            doctors[index].name,
                          ),
                          subtitle: Text(
                            doctors[index].qualification,
                          ),
                          trailing: InkWell(
                            onTap: () async {
                              final commentController = TextEditingController();
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(24.r),
                                    topRight: Radius.circular(24.r),
                                  ),
                                ),
                                builder: (context) => Padding(
                                  padding: EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    top: 16,
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Write a comment",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            icon: Icon(
                                              Icons.close_outlined,
                                              size: 24.h,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 16.h,
                                      ),
                                      GeneralTextField(
                                        labelText: "Comment",
                                        obscureText: false,
                                        textInputType: TextInputType.multiline,
                                        validate: (v) => ValidationMixin()
                                            .validate(v, title: "Comment"),
                                        textInputAction:
                                            TextInputAction.newline,
                                        maxLines: 5,
                                      ),
                                      SizedBox(
                                        height: 24.h,
                                      ),
                                      GeneralElevatedButton(
                                        title: "Submit",
                                        onPressed: () async {
                                          try {
                                            onLoading(context);
                                            final doctorComment =
                                                DoctorComments(
                                              doctor: doctors[index],
                                              user: Provider.of<UserProvider>(
                                                      context,
                                                      listen: false)
                                                  .user,
                                              comment:
                                                  getText(commentController),
                                              dateTime: DateTime.now(),
                                            ).toJson();
                                            await FirebaseHelper().addData(
                                              context,
                                              map: doctorComment,
                                              collectionId: DoctorConstant
                                                  .commentCollection,
                                            );
                                            showToast("Commented Successfully");
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          } catch (ex) {
                                            Navigator.pop(context);
                                            GeneralAlertDialog()
                                                .customAlertDialog(
                                                    context, ex.toString());
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: 16.h,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            //  => navigate(
                            //   context,
                            //   BookAppointmentScreen(
                            //     doctor: doctors[index],
                            //   ),
                            // ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.comment_outlined,
                                ),
                                Text("Comment")
                              ],
                            ),
                          ),
                          onTap: () => navigate(
                              context,
                              DoctorDetailsScreen(
                                doctor: doctors[index],
                              )),
                        ),
                      ),
                    ),
                    separatorBuilder: (_, __) => SizedBox(
                      height: 8.h,
                    ),
                    itemCount: doctors.length,
                    shrinkWrap: true,
                    primary: false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
