import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view/profile/profile_view.dart';
import '../../view/cart/cart_view.dart';
import '../../view/home/home_view.dart';

class ControlViewModel extends GetxController {
  Widget _currentScreen = const HomeView();
  int _navigatorIndex = 0;

  Widget get currentScreen => _currentScreen;

  int get navigatorIndex => _navigatorIndex;

  changeCurrentScreen(int index) {
    _navigatorIndex = index;
    switch (index) {
      case 0:
        _currentScreen = const HomeView();
        break;
      case 1:
        _currentScreen = const CartView();
        break;
      case 2:
        _currentScreen = const ProfileView();
        break;
    }
    update();
  }
}
