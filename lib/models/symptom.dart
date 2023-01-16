class Symptom {
  late String symptom;
  late String uuid;
  late double rate;

  Symptom({
    required this.symptom,
    required this.rate,
    required this.uuid,
  });

  Symptom.fromMap(Map obj) {
    symptom = obj["symptom"] ?? "";
    rate = obj["rate"] ?? "";
    uuid = obj["uuid"] ?? "";
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["rate"] = rate;
    map["symptom"] = symptom;
    map["uuid"] = uuid;
    return map;
  }
}
