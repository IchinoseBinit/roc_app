import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final navigatorKey = GlobalKey<NavigatorState>();

const Color baseColor = Color(0xFFF69B11);
const Color primaryColor = Color(0XFFC6E0E9);

const double padding = 16.0;
final double radius = 8.r;

const basePadding =
    EdgeInsets.symmetric(horizontal: padding, vertical: padding * 1.5);

const tokenKey = "token";

const nepaliValue = "nepali";

// Secure Storage Login Credentials
const phoneKey = "phone";
const passwordKey = "password";

class ImageConstants {
  static const _basePath = "assets/images";
  static const logo = "$_basePath/logo.png";
  static const logoWithName = "$_basePath/logo_with_name.png";
  static const hospital = "$_basePath/hospital.png";

  static const notificationIcon = "notification";
}

class UserConstants {
  static const userCollection = "user";
  static const userId = "uuid";
  static const apiKey = "b9ac8db19381c1b4c97e33a3540d1954";
}

class BloodMarkConstant {
  static const bloodMarkCollection = "blood-mark";
}

class EducationalResourceConstant {
  static const resource = "resource";
}

class NoteConstant {
  static const notes = "notes";
  static const userId = "userId";
}

class ContactUsConstant {
  static const contactUsCollection = "contact-us";
}

class DoctorConstant {
  static const doctorCollection = "doctor";
  static const commentCollection = "doctor-comment";
}

class DonationConstant {
  static const donationCollection = "donation";
}

class SymptomConstant {
  static const symptomCollection = "symptom";
}

class LogSymptomConstant {
  static const logSymptomCollection = "log-symptom";
  static const userId = "userId";
}

class MedicalDetailsConstant {
  static const detailsCollection = "medical-details";
}

class BookAppointmentConstant {
  static const appointment = "appointment";
}

class FilterOptionConstant {
  static const filterList = [
    "Available",
    "Completed",
  ];
}
