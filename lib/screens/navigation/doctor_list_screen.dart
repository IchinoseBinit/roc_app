import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/screens/doctor_details_screen.dart';
import '/utils/navigate.dart';
import '/widgets/body_template.dart';
import '/widgets/header_template.dart';

class DoctorListScreen extends StatelessWidget {
  const DoctorListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              ListView.separated(
                itemBuilder: (_, __) => Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 8.h,
                    ),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.blue,
                      ),
                      title: const Text(
                        "Ram Smith",
                      ),
                      subtitle: const Text(
                        "GCT specialist at Crown Princess Mary Cancer Centre Westmead",
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
                      onTap: () =>
                          navigate(context, const DoctorDetailsScreen()),
                    ),
                  ),
                ),
                separatorBuilder: (_, __) => SizedBox(
                  height: 8.h,
                ),
                itemCount: 3,
                shrinkWrap: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
