class LogSymptom {
  late String time;
  late String date;
  late String userId;
  late String pelvic;
  late String indigestion;
  late String nausea;
  late String bloating;
  late String weightLoss;

  LogSymptom({
    required this.time,
    required this.date,
    required this.userId,
    required this.pelvic,
    required this.indigestion,
    required this.nausea,
    required this.bloating,
    required this.weightLoss,
  });

  LogSymptom.fromMap(Map obj) {
    time = obj["time"];
    date = obj["date"];
    userId = obj["userId"];
    pelvic = obj["pelvic"];
    indigestion = obj["indigestion"];
    nausea = obj["nausea"];
    bloating = obj["bloating"];
    weightLoss = obj["weightLoss"];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["time"] = time;
    map["date"] = date;
    map["userId"] = userId;
    map["pelvic"] = pelvic;
    map["indigestion"] = indigestion;
    map["nausea"] = nausea;
    map["bloating"] = bloating;
    map["weightLoss"] = weightLoss;
    return map;
  }
}
