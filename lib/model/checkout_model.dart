class CheckoutModel {
  late String location, telefone, totalPrice, date, payment;
  late List products;
  late double latitude, longitude;

  CheckoutModel({
    required this.location,
    required this.telefone,
    required this.totalPrice,
    required this.date,
    required this.products,
    required this.latitude,
    required this.longitude,
    required this.payment,
  });

  CheckoutModel.fromJson(Map<dynamic, dynamic> map) {
    location = map['location'];
    telefone = map['telefone'];
    totalPrice = map['totalPrice'];
    date = map['date'];
    products = map['names'];
    latitude = map['latitude'];
    longitude = map['longitude'];
    payment = map['payment'];
  }

  toJson() {
    return {
      'location': location,
      'telefone': telefone,
      'totalPrice': totalPrice,
      'date': date,
      'products': products,
      'latitude': latitude,
      'longitude': longitude,
      'payment': payment,
    };
  }
}
