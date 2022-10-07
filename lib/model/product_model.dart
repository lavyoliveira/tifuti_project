class ProductModel {
  late String name, image, description, size, price, productId, category;

  ProductModel({
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.productId,
    required this.category,
  });

  ProductModel.fromJson(Map<dynamic, dynamic> map) {
    name = map['name'];
    image = map['image'];
    description = map['description'];
    price = map['price'];
    productId = map['productId'];
    category = map['category'];
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'description': description,
      'price': price,
      'productId': productId,
      'category': category,
    };
  }
}
