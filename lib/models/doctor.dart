class Doctor {
  late String name;
  late String address;
  late String qualification;
  late String experience;
  late String review;

  Doctor({
    required this.name,
    required this.address,
    required this.qualification,
    required this.experience,
    required this.review,
  });

  Doctor.fromMap(Map obj) {
    name = obj["name"];
    address = obj["address"];
    qualification = obj["qualification"];
    experience = obj["experience"];
    review = obj["review"];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["name"] = name;
    map["address"] = address;
    map["qualification"] = qualification;
    map["experience"] = experience;
    map["review"] = review;
    return map;
  }
}
