import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tifuti_project/model/product_model.dart';

import '../services/firestore_checkout.dart';
import '../viewmodel/cart_viewmodel.dart';
import '../../model/checkout_model.dart';

class CheckoutViewModel extends GetxController {
  String? rua, cidade, estado, pais, telefone;

  List<CheckoutModel> _checkouts = [];

  List<CheckoutModel> get checkouts => _checkouts;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  @override
  void onInit() {
    super.onInit();
    _getCheckoutsFromFireStore();
  }

  _getCheckoutsFromFireStore() async {
    _isLoading = true;
    _checkouts = [];
    List<QueryDocumentSnapshot> checkoutsSnapshot =
        await FirestoreCheckout().getOrdersFromFirestore();
    for (var order in checkoutsSnapshot) {
      _checkouts
          .add(CheckoutModel.fromJson(order.data() as Map<String, dynamic>));
    }
    _isLoading = false;
    update();
  }

  addCheckoutToFireStore() async {
    await FirestoreCheckout().addOrderToFirestore(CheckoutModel(
      rua: rua!,
      cidade: cidade!,
      estado: estado!,
      pais: pais!,
      telefone: telefone!,
      totalPrice: Get.find<CartViewModel>().totalPrice.toString(),
      date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
    ));
    Get.find<CartViewModel>().removeAllProducts();
    Get.back();
    _getCheckoutsFromFireStore();
  }
}
