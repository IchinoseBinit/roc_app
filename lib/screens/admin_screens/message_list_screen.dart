import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roc_app/constants/constants.dart';
import 'package:roc_app/models/contact_us.dart';
import 'package:roc_app/screens/admin_screens/message_detail_screen.dart';
import 'package:roc_app/utils/firebase_helper.dart';
import 'package:roc_app/utils/navigate.dart';

import '/widgets/body_template.dart';
import '/widgets/header_template.dart';

class MessageListScreen extends StatelessWidget {
  const MessageListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BodyTemplate(
          child: Column(
            children: [
              const HeaderTemplate(
                headerText: "List of Messages",
                needBackButton: false,
              ),
              SizedBox(
                height: 24.h,
              ),
              StreamBuilder(
                stream: FirebaseHelper().getStream(
                    collectionId: ContactUsConstant.contactUsCollection),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator.adaptive();
                  }
                  final data = snapshot.data;
                  if (data?.docs == null && data!.docs.isNotEmpty) {
                    final contactUs = data.docs
                        .map((e) => ContactUs.fromMap(e.data()))
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
                                contactUs[index].name,
                              ),
                              subtitle: Text(
                                contactUs[index].message,
                              ),
                              trailing: IconButton(
                                onPressed: () => navigate(
                                  context,
                                  MessageDetailsScreen(
                                    contactUs: contactUs[index],
                                  ),
                                ),
                                icon: const Icon(Icons.arrow_forward_ios),
                              )),
                        ),
                      ),
                      separatorBuilder: (_, __) => SizedBox(
                        height: 8.h,
                      ),
                      itemCount: contactUs.length,
                      shrinkWrap: true,
                      primary: false,
                    );
                  }
                  return const Center(
                    child: Text("No messages till now"),
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
