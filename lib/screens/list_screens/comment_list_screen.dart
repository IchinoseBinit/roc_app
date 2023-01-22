import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:roc_app/models/appointment.dart';
import 'package:roc_app/models/doctor_comments.dart';
import 'package:roc_app/providers/user_provider.dart';
import 'package:roc_app/screens/list_screens/comment_detail_screen.dart';
import 'package:roc_app/utils/navigate.dart';

import '/constants/constants.dart';
import '/utils/firebase_helper.dart';
import '/utils/util.dart';
import '/widgets/body_template.dart';
import '/widgets/header_template.dart';

class CommentListScreen extends StatelessWidget {
  const CommentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BodyTemplate(
          child: Column(
            children: [
              const HeaderTemplate(
                headerText: "List of Comments",
              ),
              SizedBox(
                height: 24.h,
              ),
              StreamBuilder(
                stream: isAdmin(context)
                    ? FirebaseHelper().getStream(
                        collectionId: DoctorConstant.commentCollection)
                    : FirebaseHelper().getStreamWithWhere(
                        collectionId: DoctorConstant.commentCollection,
                        whereId: "user.uuid",
                        whereValue: getUserId(),
                        // whereValue:
                        // Provider.of<UserProvider>(context).user.toJson(),
                      ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator.adaptive();
                  }
                  print(snapshot.data?.docs);
                  final data = snapshot.data;
                  if (data?.docs != null && data!.docs.isNotEmpty) {
                    final comments = data.docs
                        .map((e) => DoctorComments.fromMap(
                              e.data(),
                            ))
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
                              comments[index].doctor.name,
                            ),
                            subtitle: Text(
                              "${DateFormat("yyyy-MMM-dd").format(comments[index].dateTime)} ",
                            ),
                            trailing: IconButton(
                              onPressed: () => navigate(
                                context,
                                CommentDetailScreen(
                                  comments: comments[index],
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
                      itemCount: comments.length,
                      shrinkWrap: true,
                      primary: false,
                    );
                  }
                  return const Center(
                    child: Text("No Comments till now"),
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
