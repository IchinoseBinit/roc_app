class BloodMark {
  late String uuid;
  String? id;
  late double amountOfProtien;
  late double referenceRange;
  late String date;

  BloodMark({
    required this.uuid,
    required this.amountOfProtien,
    required this.referenceRange,
    required this.date,
  });

  BloodMark.fromMap(Map obj, this.id) {
    uuid = obj["uuid"];
    amountOfProtien = double.parse(obj["amountOfProtien"].toString());
    referenceRange = double.parse(obj["referenceRange"].toString());
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
