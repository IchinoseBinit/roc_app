import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roc_app/constants/constants.dart';
import 'package:roc_app/models/donation.dart';
import 'package:roc_app/utils/firebase_helper.dart';

import '/widgets/body_template.dart';
import '/widgets/header_template.dart';

class DonationListScreen extends StatelessWidget {
  const DonationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BodyTemplate(
          child: Column(
            children: [
              const HeaderTemplate(
                headerText: "List of Donations",
                needBackButton: false,
              ),
              SizedBox(
                height: 24.h,
              ),
              StreamBuilder(
                stream: FirebaseHelper().getStream(
                    collectionId: DonationConstant.donationCollection),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator.adaptive();
                  }
                  final data = snapshot.data;
                  if (data?.docs == null && data!.docs.isNotEmpty) {
                    final donations = data.docs
                        .map((e) => Donation.fromMap(e.data()))
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
                              donations[index].name,
                            ),
                            subtitle: Text(
                              donations[index].amount.toStringAsFixed(2),
                            ),
                            trailing: Text(
                              donations[index].date,
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (_, __) => SizedBox(
                        height: 8.h,
                      ),
                      itemCount: donations.length,
                      shrinkWrap: true,
                      primary: false,
                    );
                  }
                  return const Center(
                    child: Text("No Donation made till now"),
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
