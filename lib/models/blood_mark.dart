class BloodMark {
  late String uuid;
  late String name;
  String? id;
  late double amountOfProtien;
  late double referenceRange;

  BloodMark({
    required this.uuid,
    required this.name,
    required this.amountOfProtien,
    required this.referenceRange,
  });

  BloodMark.fromMap(Map obj, [this.id]) {
    uuid = obj["uuid"];
    name = obj["name"] ?? "";
    amountOfProtien = double.parse(obj["amountOfProtien"].toString());
    referenceRange = double.parse(obj["referenceRange"].toString());
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["uuid"] = uuid;
    map["name"] = name;
    map["amountOfProtien"] = amountOfProtien;
    map["referenceRange"] = referenceRange;
    return map;
  }
}
