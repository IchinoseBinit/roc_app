class Note {
  String? id;
  late String userId;
  late String message;

  Note({
    required this.userId,
    required this.message,
    this.id,
  });

  Note.fromMap(Map obj, [this.id]) {
    userId = obj["userId"];
    message = obj["message"];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (id != null) map["id"] = id;
    map["userId"] = userId;
    map["message"] = message;
    return map;
  }
}
