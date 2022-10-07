class CheckoutModel {
  late String rua, cidade, estado, pais, telefone, totalPrice, date;

  CheckoutModel({
    required this.rua,
    required this.cidade,
    required this.estado,
    required this.pais,
    required this.telefone,
    required this.totalPrice,
    required this.date,
  });

  CheckoutModel.fromJson(Map<dynamic, dynamic> map) {
    rua = map['rua'];
    cidade = map['cidade'];
    estado = map['estado'];
    pais = map['pais'];
    telefone = map['telefone'];
    totalPrice = map['totalPrice'];
    date = map['date'];
  }

  toJson() {
    return {
      'rua': rua,
      'cidade': cidade,
      'estado': estado,
      'pais': pais,
      'telefone': telefone,
      'totalPrice': totalPrice,
      'date': date,
    };
  }
}
