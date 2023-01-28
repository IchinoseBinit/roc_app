import 'package:roc_app/models/blood_mark.dart';

class LogBloodMark {
  BloodMark? bloodMark;

  late String dateTime;
  String? id;
  late String userId;
  late String inhibinB;
  late String ca125;
  LogBloodMark({
    this.bloodMark,
    required this.dateTime,
    this.id,
    required this.userId,
    required this.inhibinB,
    required this.ca125,
  });

  LogBloodMark.fromMap(Map obj, this.id) {
    if (obj["bloodMark"] != null) {
      bloodMark = BloodMark.fromMap(obj["bloodMark"]);
    }
    dateTime = obj["dateTime"] ?? "";
    userId = obj["userId"];
    inhibinB = obj["inhibinB"];
    ca125 = obj["ca125"];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (bloodMark != null) map["bloodMark"] = bloodMark!.toJson();
    map["dateTime"] = dateTime;
    map["userId"] = userId;
    map["inhibinB"] = inhibinB;
    map["ca125"] = ca125;
    return map;
  }
}
