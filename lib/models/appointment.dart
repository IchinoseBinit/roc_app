import 'package:roc_app/models/doctor.dart';
import 'package:roc_app/models/user.dart';

class Appointment {
  String? id;
  late String time;
  late String date;
  late String userId;
  late Doctor doctor;
  late bool isChecked;
  String? remarks;

  Appointment({
    required this.time,
    required this.date,
    required this.userId,
    required this.doctor,
    this.isChecked = false,
    this.remarks,
  });

  Appointment.fromMap(Map obj, [this.id]) {
    time = obj["time"];
    date = obj["date"];
    userId = obj["userId"];
    doctor = Doctor.fromMap(obj["doctor"]);
    isChecked = obj["isChecked"] ?? false;
    remarks = obj["remarks"];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (id != null) map["id"] = id;
    map["time"] = time;
    map["date"] = date;
    map["userId"] = userId;
    map["doctor"] = doctor.toJson();
    map["isChecked"] = isChecked;
    map["remarks"] = remarks;
    return map;
  }
}
