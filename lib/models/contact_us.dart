class ContactUs {
  late String name;
  late String email;
  late String subject;
  late String message;

  ContactUs({
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
  });

  ContactUs.fromMap(Map obj) {
    name = obj["name"];
    email = obj["email"];
    subject = obj["subject"];
    message = obj["message"];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["name"] = name;
    map["amount"] = email;
    map["cardNumber"] = subject;
    map["date"] = message;
    return map;
  }
}
