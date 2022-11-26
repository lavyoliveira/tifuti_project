import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../domain/viewmodel/cart_viewmodel.dart';
import '../../domain/viewmodel/checkout_viewmodel.dart';
import '../widgets/custom_button.dart';
import '../../config/theme.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textFormField.dart';

class CheckoutView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  CheckoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 130.h,
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
                    text: 'checkout',
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
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 16, bottom: 24),
                child: Form(
                  key: _formKey,
                  child: GetBuilder<CheckoutViewModel>(
                    init: Get.find<CheckoutViewModel>(),
                    builder: (controller) => Column(
                      children: [
                        const ListViewProducts(),
                        SizedBox(
                          height: 20.h,
                        ),
                        // CustomTextFormField(
                        //   hintText: 'Rua de Pedestre E24',
                        //   validatorFn: (value) {
                        //     if (value!.isEmpty || value.length < 4) {
                        //       return 'Por favor, insira um nome válido de rua.';
                        //     }
                        //     return null;
                        //   },
                        //   onSavedFn: (value) {
                        //     controller.rua = value;
                        //   },
                        // ),
                        // SizedBox(
                        //   height: 20.h,
                        // ),
                        // CustomTextFormField(
                        //   hintText: 'São Paulo',
                        //   validatorFn: (value) {
                        //     if (value!.isEmpty || value.length < 4) {
                        //       return 'Por favor, insira um nome válido de cidade.';
                        //     }
                        //     return null;
                        //   },
                        //   onSavedFn: (value) {
                        //     controller.cidade = value;
                        //   },
                        // ),
                        // SizedBox(
                        //   height: 20.h,
                        // ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: CustomTextFormField(
                        //         hintText: 'São Paulo',
                        //         validatorFn: (value) {
                        //           if (value!.isEmpty || value.length < 4) {
                        //             return 'Por favor, insira um nome válido de estado.';
                        //           }
                        //           return null;
                        //         },
                        //         onSavedFn: (value) {
                        //           controller.estado = value;
                        //         },
                        //       ),
                        //     ),
                        //     const SizedBox(
                        //       width: 36,
                        //     ),
                        //     Expanded(
                        //       child: CustomTextFormField(
                        //         hintText: 'Brasil',
                        //         validatorFn: (value) {
                        //           if (value!.isEmpty || value.length < 4) {
                        //             return 'Por favor, insira um nome válido de país.';
                        //           }
                        //           return null;
                        //         },
                        //         onSavedFn: (value) {
                        //           controller.pais = value;
                        //         },
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        ListTile(
                          title: Container(
                            width: 250.0,
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                              ),
                              controller: controller.locationTEC,
                              decoration: InputDecoration(
                                hintText: 'Rua Fernandes, 324, Itajubá',
                                hintStyle: TextStyle(
                                  color: hintColor,
                                  fontSize: 13,
                                ),
                              ),
                              maxLines: null,
                              onChanged: (val) => controller.setLocation(val),
                            ),
                          ),
                          trailing: IconButton(
                            tooltip: "Use your current location",
                            icon: Icon(
                              Icons.location_on,
                              size: 25.0,
                            ),
                            iconSize: 30.0,
                            color: Theme.of(context).colorScheme.secondary,
                            onPressed: () => controller.getLocation(),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomTextFormField(
                          hintText: 'DDD99999-9999',
                          keyboardType: TextInputType.phone,
                          validatorFn: (value) {
                            if (value!.isEmpty || value.length < 10) {
                              return 'Por favor, insira um número válido.';
                            }
                            return null;
                          },
                          onSavedFn: (value) {
                            controller.telefone = value;
                          },
                        ),
                        SizedBox(
                          height: 38.h,
                        ),
                        CustomButton(
                          'Finalizar',
                          () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              await controller.addCheckoutToFireStore();
                              Get.dialog(
                                AlertDialog(
                                  content: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.check_circle_outline_outlined,
                                          color: primaryColor,
                                          size: 200.h,
                                        ),
                                        const CustomText(
                                          text: 'Pedido enviado.',
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                          alignment: Alignment.center,
                                        ),
                                        SizedBox(
                                          height: 40.h,
                                        ),
                                        CustomButton(
                                          'Finalizado.',
                                          () {
                                            Get.back();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                barrierDismissible: false,
                              );
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
        ],
      ),
    );
  }
}

class ListViewProducts extends StatelessWidget {
  const ListViewProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartViewModel>(
      builder: (controller) => Column(
        children: [
          SizedBox(
            height: 160.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.cartProducts.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          color: Colors.white,
                        ),
                        height: 120,
                        width: 120,
                        child: Image.network(
                          controller.cartProducts[index].image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      CustomText(
                        text: controller.cartProducts[index].name,
                        fontSize: 14,
                        maxLines: 1,
                      ),
                      CustomText(
                        text:
                            '\$${controller.cartProducts[index].price} x ${controller.cartProducts[index].quantity}',
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 15,
                );
              },
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomText(
                text: 'Total: ',
                fontSize: 14,
                color: Colors.grey,
              ),
              CustomText(
                text: '\$${controller.totalPrice.toString()}',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
