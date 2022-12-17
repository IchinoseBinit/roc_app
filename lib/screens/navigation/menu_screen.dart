import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                  onTap: () => navigate(context, DonationScreen()),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Card(
                child: ListTile(
                  title: const Text("About Us"),
                  onTap: () => navigate(context, const AboutUsScreen()),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Card(
                child: ListTile(
                  title: const Text("Contact Us"),
                  onTap: () => navigate(context, ContactUsScreen()),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Card(
                child: ListTile(
                  title: const Text("Blood Mark"),
                  onTap: () => navigate(context, AddBloodMarkScreen()),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
