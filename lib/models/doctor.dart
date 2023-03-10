class Doctor {
  late String name;
  String? id;
  String? userId;
  late String phone;
  late String email;
  late String address;
  late String qualification;
  late String experience;
  late String review;

  Doctor({
    required this.userId,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.qualification,
    required this.experience,
    required this.review,
  });

  Doctor.fromMap(Map obj, [this.id]) {
    userId = obj["userId"] ?? "";
    name = obj["name"];
    phone = obj["phone"] ?? "";
    email = obj["email"] ?? "";
    address = obj["address"];
    qualification = obj["qualification"];
    experience = obj["experience"];
    review = obj["review"];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["userId"] = userId;
    map["name"] = name;
    map["phone"] = phone;
    map["email"] = email;
    if (id != null) map["id"] = id;
    map["address"] = address;
    map["qualification"] = qualification;
    map["experience"] = experience;
    map["review"] = review;
    return map;
  }
}
