class Donation {
  late String name;
  late double amount;
  late int cardNumber;
  late String date;
  late int cvv;

  Donation({
    required this.name,
    required this.amount,
    required this.cardNumber,
    required this.date,
    required this.cvv,
  });

  Donation.fromMap(Map obj) {
    name = obj["name"];
    amount = obj["amount"];
    cardNumber = obj["cardNumber"];
    date = obj["date"];
    cvv = obj["cvv"];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["name"] = name;
    map["amount"] = amount;
    map["cardNumber"] = cardNumber;
    map["date"] = date;
    map["cvv"] = cvv;
    return map;
  }
}
