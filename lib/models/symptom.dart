class Symptom {
  late String symptom;
  late String date;
  late int rate;

  Symptom({
    required this.symptom,
    required this.date,
    required this.rate,
  });

  Symptom.fromMap(Map obj) {
    symptom = obj["symptom"];
    date = obj["date"];
    rate = obj["rate"];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["rate"] = rate;
    map["symptom"] = symptom;
    map["date"] = date;
    return map;
  }
}
