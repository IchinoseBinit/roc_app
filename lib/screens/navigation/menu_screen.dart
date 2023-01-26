import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:roc_app/providers/user_provider.dart';
import 'package:roc_app/screens/admin_screens/doctor_comment_list_screen.dart';
import 'package:roc_app/screens/admin_screens/donation_list_screen.dart';
import 'package:roc_app/screens/admin_screens/message_list_screen.dart';
import 'package:roc_app/screens/auth/login_screen.dart';
import 'package:roc_app/screens/list_screens/comment_list_screen.dart';
import 'package:roc_app/screens/list_screens/blood_marks_list_screen.dart';
import 'package:roc_app/screens/list_screens/log_symptoms_list_screen.dart';
import 'package:roc_app/screens/list_screens/note_list_screen.dart';
import 'package:roc_app/utils/firebase_helper.dart';
import 'package:roc_app/utils/show_toast_message.dart';
import 'package:roc_app/utils/util.dart';
import 'package:roc_app/widgets/custom_loading_indicator.dart';
import '/screens/about_us_screen.dart';
import '/screens/forms/add_blood_mark_screen.dart';
import '/screens/forms/contact_us_screen.dart';
import '/screens/forms/donation_screen.dart';
import '/utils/navigate.dart';
import '/widgets/body_template.dart';
import '/widgets/header_template.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BodyTemplate(
          child: Column(
            children: [
              const HeaderTemplate(
                headerText: "Menu",
                needBackButton: false,
              ),
              SizedBox(
                height: 24.h,
              ),
              Card(
                child: ListTile(
                  title: const Text("Donation"),
                  onTap: () => navigate(
                      context,
                      isAdmin(context)
                          ? const DonationListScreen()
                          : DonationScreen()),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 18.h,
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Card(
                child: ListTile(
                  title: const Text("About Us"),
                  onTap: () => navigate(context, const AboutUsScreen()),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 18.h,
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Card(
                child: ListTile(
                  title: const Text("Contact Us"),
                  onTap: () => navigate(
                    context,
                    isAdmin(context)
                        ? const MessageListScreen()
                        : ContactUsScreen(),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 18.h,
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Card(
                child: ListTile(
                  title: const Text("Comments"),
                  onTap: () => navigate(
                    context,
                    const CommentListScreen(),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 18.h,
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Card(
                child: ListTile(
                  title: const Text("Logged Symptoms"),
                  onTap: () => navigate(
                    context,
                    const LogSymptomsListScreen(),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 18.h,
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              if (!isAdmin(context)) ...[
                Card(
                  child: ListTile(
                    title: const Text("Blood Marks"),
                    onTap: () => navigate(context, const BloodMarkListScreen()),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18.h,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Card(
                  child: ListTile(
                    title: const Text("Notes"),
                    onTap: () => navigate(context, const NoteListScreen()),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18.h,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
              ],
              SizedBox(
                height: 8.h,
              ),
              Card(
                child: ListTile(
                  trailing: const Icon(
                    Icons.logout_outlined,
                    color: Colors.red,
                  ),
                  title: const Text("Logout"),
                  onTap: () async {
                    onLoading(context);
                    await Provider.of<UserProvider>(context, listen: false)
                        .logout();
                    Navigator.pop(context);
                    showToast("Logged out Successfully");
                    navigateAndRemoveAll(context, LoginScreen());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
