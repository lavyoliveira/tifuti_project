import 'package:get/get.dart';

import '../domain/network_viewmodel.dart';
import '../domain/viewmodel/auth_viewmodel.dart';
import '../domain/viewmodel/cart_viewmodel.dart';
import '../domain/viewmodel/home_viewmodel.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => HomeViewModel());
    Get.put(CartViewModel());
    Get.lazyPut(() => NetworkViewModel());
  }
}
