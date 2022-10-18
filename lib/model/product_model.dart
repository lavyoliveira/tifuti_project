class ProductModel {
  late String name, image, price, productId, category;
  late int quantity;

  ProductModel({
    required this.name,
    required this.image,
    required this.price,
    required this.productId,
    required this.category,
    required this.quantity,
  });

  ProductModel.fromJson(Map<dynamic, dynamic> map) {
    name = map['name'];
    image = map['image'];
    price = map['price'];
    productId = map['productId'];
    category = map['category'];
    quantity = map['quantity'];
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'productId': productId,
      'category': category,
      'quantity': quantity,
    };
  }
}
