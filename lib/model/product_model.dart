class ProductModel {
  late String name, image, price, productId, category;

  ProductModel({
    required this.name,
    required this.image,
    required this.price,
    required this.productId,
    required this.category,
  });

  ProductModel.fromJson(Map<String, dynamic> map) {
    name = map['name'] ?? ' ';
    image = map['image'] ?? ' ';
    price = map['price'] ?? ' ';
    productId = map['productId'] ?? ' ';
    category = map['category'] ?? ' ';
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'productId': productId,
      'category': category,
    };
  }
}
