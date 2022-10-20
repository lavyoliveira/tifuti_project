import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'theme.dart';
import '../domain/viewmodel/auth_viewmodel.dart';
import '../domain/viewmodel/control_viewmodel.dart';
import '../domain/network_viewmodel.dart';
import '../view/auth/login_view.dart';
import '../view/widgets/custom_text.dart';
import 'package:unicons/unicons.dart';

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
              icon: Icon(UniconsLine.compass, size: 35, color: darkGreenColor),
              activeIcon:
                  Icon(UniconsLine.compass, size: 35, color: primaryColor),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(UniconsLine.shopping_cart,
                  size: 35, color: darkGreenColor),
              activeIcon: Icon(UniconsLine.shopping_cart,
                  size: 35, color: primaryColor),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(UniconsLine.user, size: 35, color: darkGreenColor),
              activeIcon: Icon(UniconsLine.user, size: 35, color: primaryColor),
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
