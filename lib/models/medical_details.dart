class MedicalDetails {
  late String uuid;
  late String image;

  MedicalDetails({required this.uuid, required this.image});

  MedicalDetails.fromJson(Map obj) {
    uuid = obj["uuid"];
    image = obj["image"];
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map["uuid"] = uuid;
    map["image"] = image;
    return map;
  }
}
