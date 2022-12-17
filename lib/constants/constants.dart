import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final navigatorKey = GlobalKey<NavigatorState>();

const Color baseColor = Colors.red;
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
  static const logoWithName = "$_basePath/logo_with_name.jpg";
  static const pdfDownload = "$_basePath/pdf_download.png";

  static const notificationIcon = "notification";
}

class UserConstants {
  static const userCollection = "user";
  static const userId = "uuid";
  static const apiKey = "b9ac8db19381c1b4c97e33a3540d1954";
}

class UtilitiesPriceConstant {
  static const utilityPriceCollection = "utilities-price";
  static const userId = "uuid";
}

class FoodConstant {
  static const foodCollection = "food";
  static const isAvailable = "isAvailable";
  static const title = "name";
  static const userId = "uuid";
  static const postedBy = "postedBy";
}

class FoodTruckConstant {
  static const truckCollection = "foodTruck";
}

class RoomRentConstant {
  static const roomRentCollection = "room-rent";
  static const roomId = "roomId";
}

class FilterOptionConstant {
  static const filterList = [
    "Available",
    "Completed",
  ];
}
