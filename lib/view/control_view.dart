import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../core/viewmodel/auth_viewmodel.dart';
import '../core/viewmodel/control_viewmodel.dart';
import '../core/network_viewmodel.dart';
import 'auth/login_view.dart';
import 'widgets/custom_text.dart';

class ControlView extends StatelessWidget {
  const ControlView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Get.find<AuthViewModel>().user == null
          ? LoginView()
          : Get.find<NetworkViewModel>().connectionStatus.value == 1 ||
                  Get.find<NetworkViewModel>().connectionStatus.value == 2
              ? GetBuilder<ControlViewModel>(
                  init: ControlViewModel(),
                  builder: (controller) => Scaffold(
                    body: controller.currentScreen,
                    bottomNavigationBar: const CustomBottomNavigationBar(),
                  ),
                )
              : const NoInternetConnection();
    });
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 84,
      child: GetBuilder<ControlViewModel>(
        builder: (controller) => BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          backgroundColor: Colors.grey.shade100,
          currentIndex: controller.navigatorIndex,
          onTap: (index) {
            controller.changeCurrentScreen(index);
          },
          items: const [
            BottomNavigationBarItem(
              label: '',
              icon: Icon(Icons.explore, size: 40),
              activeIcon: Icon(Icons.explore, size: 40, color: primaryColor),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(Icons.shopping_cart, size: 40),
              activeIcon:
                  Icon(Icons.shopping_cart, size: 40, color: primaryColor),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(Icons.person, size: 40),
              activeIcon: Icon(Icons.person, size: 40, color: primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(
              height: 30,
            ),
            CustomText(
              text: 'Por favor, cheque sua conexão com a internet.',
              fontSize: 14,
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
