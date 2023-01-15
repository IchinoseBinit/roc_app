class Symptom {
  late String symptom;
  late double rate;

  Symptom({
    required this.symptom,
    required this.rate,
  });

  Symptom.fromMap(Map obj) {
    symptom = obj["symptom"];
    rate = obj["rate"];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["rate"] = rate;
    map["symptom"] = symptom;
    return map;
  }
}
