import 'package:intl/intl.dart';
import 'package:roc_app/models/doctor.dart';
import 'package:roc_app/models/user.dart';

class DoctorComments {
  late Doctor doctor;
  late User user;
  late String comment;
  late DateTime dateTime;

  DoctorComments({
    required this.doctor,
    required this.user,
    required this.comment,
    required this.dateTime,
  });

  DoctorComments.fromMap(Map obj) {
    doctor = Doctor.fromMap(obj["doctor"]);
    user = User.fromJson(obj["user"]);
    comment = obj["comment"];
    dateTime = DateTime.parse(obj["dateTime"]);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["doctor"] = doctor.toJson();
    map["user"] = user.toJson();
    map["comment"] = comment;
    map["dateTime"] = DateFormat("yyyy-MM-dd").format(dateTime);
    return map;
  }
}
