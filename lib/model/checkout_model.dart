class CheckoutModel {
  late String location, telefone, totalPrice, date;

  CheckoutModel({
    required this.location,
    required this.telefone,
    required this.totalPrice,
    required this.date,
  });

  CheckoutModel.fromJson(Map<dynamic, dynamic> map) {
    location = map['location'];
    telefone = map['telefone'];
    totalPrice = map['totalPrice'];
    date = map['date'];
  }

  toJson() {
    return {
      'location': location,
      'telefone': telefone,
      'totalPrice': totalPrice,
      'date': date,
    };
  }
}
