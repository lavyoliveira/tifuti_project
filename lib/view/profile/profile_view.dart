import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                  padding: const EdgeInsets.only(top: 58, right: 16, left: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 60,
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
                                  fontSize: 26,
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                CustomText(
                                  text: controller.currentUser!.email,
                                  fontSize: 14,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomListTile(
                        icon: Icons.edit,
                        title: 'Editar perfil',
                        onTapFn: () {
                          Get.to(() => const EditProfileView());
                        },
                      ),
                      CustomListTile(
                        icon: Icons.history,
                        title: 'Histórico de compras',
                        onTapFn: () {
                          Get.to(() => const OrderHistoryView());
                        },
                      ),
                      CustomListTile(
                        icon: Icons.logout,
                        title: 'Sair',
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
            fontSize: 18,
          ),
          trailing: title == 'Log Out'
              ? null
              : const Icon(
                  Icons.navigate_next,
                  color: Colors.black,
                ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
