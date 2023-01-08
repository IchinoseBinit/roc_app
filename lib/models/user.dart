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

  User({
    required this.uuid,
    required this.name,
    required this.email,
    required this.address,
    required this.image,
    required this.photoUrl,
    this.isAdmin = false,
    required this.phoneNumber,
  });

  User.fromJson(Map obj) {
    uuid = obj["uuid"];
    name = obj["name"];
    email = obj["email"];
    image = obj["image"];
    photoUrl = obj["photoUrl"];
    address = obj["address"];
    phoneNumber = obj["phoneNumber"];
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

    return map;
  }
}
