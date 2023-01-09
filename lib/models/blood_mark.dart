class BloodMark {
  late String uuid;
  late int amountOfProtien;
  late int referenceRange;
  late String date;

  BloodMark({
    required this.uuid,
    required this.amountOfProtien,
    required this.referenceRange,
    required this.date,
  });

  BloodMark.fromMap(Map obj) {
    uuid = obj["uuid"];
    amountOfProtien = obj["amountOfProtien"];
    referenceRange = obj["referenceRange"];
    date = obj["date"];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["uuid"] = uuid;
    map["amountOfProtien"] = amountOfProtien;
    map["referenceRange"] = referenceRange;
    map["date"] = date;
    return map;
  }
}
