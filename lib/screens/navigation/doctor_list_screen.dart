import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roc_app/constants/constants.dart';
import 'package:roc_app/models/doctor.dart';
import 'package:roc_app/screens/forms/add_doctor_screen.dart';
import 'package:roc_app/utils/firebase_helper.dart';
import 'package:roc_app/utils/util.dart';
import 'package:roc_app/widgets/general_elevated_button.dart';

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
                  final doctors =
                      data!.docs.map((e) => Doctor.fromMap(e.data())).toList();
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
                            onTap: () {},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.calendar_month_outlined,
                                ),
                                Text("Book")
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
