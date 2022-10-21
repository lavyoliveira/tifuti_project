import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tifuti_project/config/theme.dart';
import 'package:unicons/unicons.dart';

import '../../domain/viewmodel/selectImage_viewmodel.dart';
import '../../domain/viewmodel/profile_viewmodel.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textFormField.dart';
import '../widgets/custom_button.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  EditProfileViewState createState() => EditProfileViewState();
}

class EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 130,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
                  const CustomText(
                    text: 'editar perfil',
                    fontSize: 20,
                    alignment: Alignment.bottomCenter,
                    fontWeight: FontWeight.bold,
                  ),
                  Container(
                    width: 24,
                  ),
                ],
              ),
            ),
          ),
          GetBuilder<SelectImageViewModel>(
            init: SelectImageViewModel(),
            builder: (controller) => Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 16, left: 16, bottom: 24),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundImage: const AssetImage(
                                    'assets/images/profile_pic.png'),
                                foregroundImage: controller.imageFile != null
                                    ? FileImage(controller.imageFile!)
                                    : null,
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              Expanded(
                                child: Container(
                                  width: 205,
                                  height: 44,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: primaryColor),
                                    onPressed: () {
                                      Get.dialog(
                                        AlertDialog(
                                          title: const CustomText(
                                            text: 'escolha',
                                            fontSize: 20,
                                            color: primaryColor,
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Divider(
                                                height: 1,
                                              ),
                                              ListTile(
                                                onTap: () async {
                                                  try {
                                                    await controller
                                                        .cameraImage();
                                                    Get.back();
                                                  } catch (error) {
                                                    Get.back();
                                                  }
                                                },
                                                title: const CustomText(
                                                  text: 'câmera',
                                                ),
                                                leading: const Icon(
                                                  UniconsLine.camera,
                                                  color: primaryColor,
                                                ),
                                              ),
                                              const Divider(
                                                height: 1,
                                              ),
                                              ListTile(
                                                onTap: () async {
                                                  try {
                                                    await controller
                                                        .galleryImage();
                                                    Get.back();
                                                  } catch (error) {
                                                    Get.back();
                                                  }
                                                },
                                                title: const CustomText(
                                                  text: 'galeria',
                                                ),
                                                leading: const Icon(
                                                  UniconsLine.images,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(UniconsLine.image, size: 25)
                                          ],
                                        ),
                                        const SizedBox(width: 5),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text('trocar imagem',
                                                style: TextStyle(fontSize: 14)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextFormField(
                            icon: UniconsLine.user_square,
                            hintText:
                                Get.find<ProfileViewModel>().currentUser!.name,
                            initialValue:
                                Get.find<ProfileViewModel>().currentUser!.name,
                            validatorFn: (value) {
                              if (value!.isEmpty || value.length < 4) {
                                return 'Por favor, insira um nome válido';
                              }
                              return null;
                            },
                            onSavedFn: (value) {
                              Get.find<ProfileViewModel>().name = value;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Column(
                            children: [
                              CustomTextFormField(
                                icon: UniconsLine.envelope,
                                hintText: Get.find<ProfileViewModel>()
                                    .currentUser!
                                    .email,
                                initialValue: Get.find<ProfileViewModel>()
                                    .currentUser!
                                    .email,
                                keyboardType: TextInputType.emailAddress,
                                validatorFn: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor, insira um nome válido';
                                  }
                                  return null;
                                },
                                onSavedFn: (value) {
                                  Get.find<ProfileViewModel>().email = value;
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomTextFormField(
                                icon: UniconsLine.lock,
                                hintText: '**************',
                                obscureText: true,
                                validatorFn: (value) {
                                  if (value!.isEmpty || value.length < 8) {
                                    return 'Por favor, insira uma senha válida com mais de 8 caracteres.';
                                  }
                                  return null;
                                },
                                onSavedFn: (value) {
                                  Get.find<ProfileViewModel>().password = value;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          _isLoading
                              ? const CircularProgressIndicator()
                              : CustomButton(
                                  'Salvar alterações',
                                  () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      try {
                                        await controller
                                            .uploadImageToFirebase();
                                        Get.find<ProfileViewModel>().picUrl =
                                            controller.picUrl;
                                      } catch (e) {
                                        Get.find<ProfileViewModel>().picUrl =
                                            Get.find<ProfileViewModel>()
                                                .currentUser!
                                                .pic;
                                      }
                                      _formKey.currentState!.save();
                                      await Get.find<ProfileViewModel>()
                                          .updateCurrentUser();
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }
                                  },
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
