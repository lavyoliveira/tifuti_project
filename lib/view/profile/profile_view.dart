import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '../../../domain/viewmodel/auth_viewmodel.dart';
import '../../../domain/viewmodel/profile_viewmodel.dart';
import 'edit_profile_view.dart';
import 'order_history_view.dart';
import '../widgets/custom_text.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProfileViewModel>(
        init: ProfileViewModel(),
        builder: (controller) => controller.loading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 100, right: 20, left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: const AssetImage(
                                'assets/images/profile_pic.png'),
                            foregroundImage:
                                controller.currentUser!.pic != 'default'
                                    ? NetworkImage(controller.currentUser!.pic)
                                    : null,
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                CustomText(
                                  text: controller.currentUser!.name,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                CustomText(
                                  text: controller.currentUser!.email,
                                  fontSize: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomListTile(
                        icon: UniconsLine.edit,
                        title: 'editar perfil',
                        onTapFn: () {
                          Get.to(() => const EditProfileView());
                        },
                      ),
                      // CustomListTile(
                      //   icon: UniconsLine.history_alt,
                      //   title: 'histórico de compras',
                      //   onTapFn: () {
                      //     Get.to(() => const OrderHistoryView());
                      //   },
                      // ),
                      CustomListTile(
                        icon: UniconsLine.signout,
                        title: 'sair',
                        onTapFn: () {
                          Get.find<AuthViewModel>().signOut();
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String title;
  final VoidCallback onTapFn;
  final IconData icon;

  const CustomListTile({
    Key? key,
    required this.title,
    required this.onTapFn,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTapFn,
          leading: Icon(icon),
          title: CustomText(
            text: title,
            fontSize: 16,
          ),
          trailing: title == 'Log Out'
              ? null
              : const Icon(
                  Icons.navigate_next,
                  color: Colors.black,
                ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
