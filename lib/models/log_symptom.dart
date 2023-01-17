import 'package:roc_app/models/symptom.dart';

class LogSymptom {
  Symptom? symptom;

  late String dateTime;
  late String userId;
  late String pelvic;
  late String indigestion;
  late String nausea;
  late String bloating;
  late String weightLoss;

  LogSymptom({
    this.symptom,
    required this.dateTime,
    required this.userId,
    required this.pelvic,
    required this.indigestion,
    required this.nausea,
    required this.bloating,
    required this.weightLoss,
  });

  LogSymptom.fromMap(Map obj) {
    if (obj["symptom"] != null) symptom = Symptom.fromMap(obj["symptom"]);
    dateTime = obj["dateTime"];
    userId = obj["userId"];
    pelvic = obj["pelvic"];
    indigestion = obj["indigestion"];
    nausea = obj["nausea"];
    bloating = obj["bloating"];
    weightLoss = obj["weightLoss"];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (symptom != null) map["symptom"] = symptom!.toJson();
    map["dateTime"] = dateTime;
    map["userId"] = userId;
    map["pelvic"] = pelvic;
    map["indigestion"] = indigestion;
    map["nausea"] = nausea;
    map["bloating"] = bloating;
    map["weightLoss"] = weightLoss;
    return map;
  }
}
