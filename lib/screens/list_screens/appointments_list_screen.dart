import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roc_app/models/appointment.dart';
import 'package:roc_app/screens/list_screens/appointment_detail_screen.dart';
import 'package:roc_app/screens/list_screens/log_symptom_detail_screen.dart';
import 'package:roc_app/utils/navigate.dart';

import '/constants/constants.dart';
import '/models/log_symptom.dart';
import '/utils/firebase_helper.dart';
import '/utils/util.dart';
import '/widgets/body_template.dart';
import '/widgets/header_template.dart';

class AppointmentsListScreen extends StatelessWidget {
  const AppointmentsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BodyTemplate(
          child: Column(
            children: [
              const HeaderTemplate(
                headerText: "List of Appointments",
              ),
              SizedBox(
                height: 24.h,
              ),
              StreamBuilder(
                stream: isAdmin(context)
                    ? FirebaseHelper().getStream(
                        collectionId: BookAppointmentConstant.appointment)
                    : FirebaseHelper().getStreamWithWhere(
                        collectionId: BookAppointmentConstant.appointment,
                        whereId: UserConstants.userId,
                        whereValue: getUserId(),
                      ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator.adaptive();
                  }
                  final data = snapshot.data;
                  if (data?.docs != null && data!.docs.isNotEmpty) {
                    final appointments = data.docs
                        .map((e) => Appointment.fromMap(e.data(), e.id))
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
                                Icons.local_hospital_outlined,
                              ),
                            ),
                            title: Text(
                              appointments[index].doctor.name,
                            ),
                            subtitle: Text(
                              "${appointments[index].date} ${appointments[index].time}",
                            ),
                            trailing: IconButton(
                              onPressed: () => navigate(
                                context,
                                AppointmentDetailScreen(
                                  appointment: appointments[index],
                                ),
                              ),
                              icon: const Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (_, __) => SizedBox(
                        height: 8.h,
                      ),
                      itemCount: appointments.length,
                      shrinkWrap: true,
                      primary: false,
                    );
                  }
                  return const Center(
                    child: Text("No symptoms logged till now"),
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
