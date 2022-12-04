import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tifuti_project/config/theme.dart';

import '../services/local_database_cart.dart';
import '../../model/cart_model.dart';

class CartNegocio {
  String productId;
  int quantity;

  CartNegocio({required this.productId, required this.quantity});
}

class CartViewModel extends GetxController {
  List<CartModel> _cartProducts = [];

  List<CartModel> get cartProducts => _cartProducts;

  double _totalPrice = 0;

  double get totalPrice => _totalPrice;

  int _totalQuantity = 0;

  int get totalQuantity => _totalQuantity;

  List _names = [];

  List get names => _names;

  @override
  void onInit() {
    super.onInit();
    getCartProducts();
  }

  getCartProducts() async {
    _cartProducts = await LocalDatabaseCart.db.getAllProducts();
    getTotalPrice();
    getNames();
    update();
  }

  addProduct(CartModel cartModel) async {
    bool isExist = false;
    for (var element in _cartProducts) {
      if (element.productId == cartModel.productId) {
        isExist = true;
      }
    }
    if (!isExist) {
      await LocalDatabaseCart.db.insertProduct(cartModel);
      Get.snackbar(
        'Sucesso',
        'Produto adicionado ao carrinho',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: primaryColor,
        colorText: Colors.white,
      );
      getCartProducts();
    }
  }

  removeProduct(String productId) async {
    await LocalDatabaseCart.db.deleteProduct(productId);
    getCartProducts();
  }

  removeAllProducts() async {
    await LocalDatabaseCart.db.deleteAllProducts();
    getCartProducts();
  }

  getTotalPrice() {
    _totalPrice = 0;
    for (var cartProduct in _cartProducts) {
      _totalPrice += (double.parse(cartProduct.price) * cartProduct.quantity);
    }
  }

  getTotalQuantity() {
    _totalQuantity = 0;
    for (var cartProduct in _cartProducts) {
      _totalQuantity += cartProduct.quantity;
    }
  }

  getNames() {
    _names = [];
    getTotalQuantity();
    for (var cartProduct in _cartProducts) {
      _names.add('Id: ' +
          cartProduct.productId +
          ' Quantidade: ' +
          _totalQuantity.toString());
    }
  }

  increaseQuantity(int index) async {
    _cartProducts[index].quantity++;
    getTotalPrice();
    await LocalDatabaseCart.db.update(_cartProducts[index]);
    update();
  }

  decreaseQuantity(int index) async {
    if (_cartProducts[index].quantity != 0) {
      _cartProducts[index].quantity--;
      getTotalPrice();
      await LocalDatabaseCart.db.update(_cartProducts[index]);
      update();
    }
  }
}
