import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tifuti_project/model/product_model.dart';

import '../services/firestore_checkout.dart';
import '../viewmodel/cart_viewmodel.dart';
import '../../model/checkout_model.dart';

class CheckoutViewModel extends GetxController {
  String? location, telefone;

  List<CheckoutModel> _checkouts = [];

  List<CheckoutModel> get checkouts => _checkouts;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  //controllers
  TextEditingController locationTEC = TextEditingController();

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
      location: location!,
      telefone: telefone!,
      totalPrice: Get.find<CartViewModel>().totalPrice.toString(),
      date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
    ));
    Get.find<CartViewModel>().removeAllProducts();
    Get.back();
    _getCheckoutsFromFireStore();
  }

  setLocation(String val) {
    if (kDebugMode) {
      print('SetCountry $val');
    }
    location = val;
  }

  getLocation() async {
    var loading = true;
    LocationPermission permission = await Geolocator.checkPermission();
    if (kDebugMode) {
      print(permission);
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      LocationPermission rPermission = await Geolocator.requestPermission();
      if (kDebugMode) {
        print(rPermission);
      }
      await getLocation();
    } else {
      var position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      var placemark = placemarks[0];
      location =
          "${placemarks[0].street}, ${placemarks[0].name}, ${placemarks[0].country}, ${placemarks[0].locality}";
      locationTEC.text = location!;
      if (kDebugMode) {
        print(location);
      }
    }
    loading = false;
  }
}
