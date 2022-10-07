import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/viewmodel/auth_viewmodel.dart';
import '../../config/theme.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textFormField.dart';
import '../widgets/custom_button.dart';

class LoginView extends GetWidget<AuthViewModel> {
  final _formKey = GlobalKey<FormState>();

  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) => Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 16, left: 16, top: 50, bottom: 30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 81,
                            ),
                            SizedBox(
                              child: Image.asset('assets/images/group.png'),
                              width: 266,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Bem vindo ao ',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Tifuti',
                                  style: GoogleFonts.quicksand(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w900,
                                      color: lightGreenDiffColor),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomTextFormField(
                              icon: Icons.alternate_email,
                              hintText: 'E-mail ID',
                              keyboardType: TextInputType.emailAddress,
                              validatorFn: (value) {
                                if (value!.isEmpty) {
                                  return 'E-mail inválido ou não encontrado!';
                                }
                                return null;
                              },
                              onSavedFn: (value) {
                                controller.email = value;
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomTextFormField(
                              icon: Icons.lock,
                              hintText: 'Senha',
                              obscureText: true,
                              validatorFn: (value) {
                                if (value!.isEmpty) {
                                  return 'Senha está incorreta!';
                                }
                                return null;
                              },
                              onSavedFn: (value) {
                                controller.password = value;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const CustomText(
                              text: 'Esqueceu sua senha?',
                              fontSize: 14,
                              alignment: Alignment.centerRight,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomButtonWhite(
                              'LOGIN',
                              () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  controller.signInWithEmailAndPassword();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    CustomButtonSocial(
                      title: 'Entrar com o Facebook',
                      image: 'facebook',
                      onPressedFn: () {
                        controller.signInWithFacebookAccount();
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButtonSocial(
                      title: 'Entrar com o Google',
                      image: 'google',
                      onPressedFn: () {
                        controller.signInWithGoogleAccount();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButtonSocial extends StatelessWidget {
  final VoidCallback onPressedFn;
  final String image;
  final String title;

  const CustomButtonSocial({
    Key? key,
    required this.onPressedFn,
    required this.image,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          side: const BorderSide(color: Colors.white),
        ),
        onPressed: onPressedFn,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/icons/$image.png',
                fit: BoxFit.cover,
                height: 20,
                width: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: CustomText(
                  text: title,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              Container(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}
