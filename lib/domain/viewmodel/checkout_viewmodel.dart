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

  TextEditingController locationTEC = TextEditingController();

  double _latitude = 0.0;

  double get latitude => _latitude;

  double _longitude = 0.0;

  double get longitude => _longitude;

  String _payment = '';

  String get payment => _payment;

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
      products: Get.find<CartViewModel>().names.toList(),
      latitude: _latitude,
      longitude: _longitude,
      payment: _payment,
    ));
    Get.find<CartViewModel>().removeAllProducts();
    Get.back();
    _getCheckoutsFromFireStore();
  }

  setLocation(String val) {
    location = val;
  }

  setPayment(String val) {
    _payment = val;
    print(_payment);
  }

  getLocation() async {
    var loading = true;
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      LocationPermission rPermission = await Geolocator.requestPermission();
      await getLocation();
    } else {
      var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      _latitude = position.latitude;
      print(_latitude);
      _longitude = position.longitude;
      print(_longitude);

      Placemark placemark = placemarks[0];
      location =
          '${placemark.subThoroughfare}, ${placemark.thoroughfare}, ${placemark.subAdministrativeArea}';
      locationTEC.text = location!;
    }
    loading = false;
  }
}
