import 'dart:developer';

class User {
  late String uuid;
  late String? name;
  late String? email;
  late String? image;
  String? tempImage;
  late String? photoUrl;
  late String? address;
  late bool isAdmin;
  late String phoneNumber;
  late String cancerType;
  late String dateOfBirth;
  late String diagonisedDate;

  User({
    required this.uuid,
    required this.name,
    required this.email,
    required this.address,
    required this.image,
    required this.photoUrl,
    this.isAdmin = false,
    required this.phoneNumber,
    required this.cancerType,
    required this.dateOfBirth,
    required this.diagonisedDate,
  });

  User.fromJson(Map obj) {
    uuid = obj["uuid"];
    name = obj["name"];
    email = obj["email"];
    image = obj["image"];
    photoUrl = obj["photoUrl"];
    address = obj["address"];
    phoneNumber = obj["phoneNumber"];
    cancerType = obj["cancerType"] ?? "";
    diagonisedDate = obj["diagonisedDate"] ?? "";
    dateOfBirth = obj["dateOfBirth"] ?? "";
    isAdmin = obj["isAdmin"] ?? false;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["uuid"] = uuid;
    map["name"] = name;
    map["email"] = email;
    map["image"] = image;
    map["address"] = address;
    map["isAdmin"] = isAdmin;
    map["phoneNumber"] = phoneNumber;
    map["cancerType"] = cancerType;
    map["diagonisedDate"] = diagonisedDate;
    map["dateOfBirth"] = dateOfBirth;

    return map;
  }
}
