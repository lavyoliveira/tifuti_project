import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../domain/viewmodel/cart_viewmodel.dart';
import '../../domain/viewmodel/checkout_viewmodel.dart';
import '../widgets/custom_button.dart';
import '../../config/theme.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textFormField.dart';
import 'package:group_button/group_button.dart';

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
                        Column(
                          children: [
                            SizedBox(
                              width: 320,
                              child: ListTile(
                                title: TextFormField(
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                  ),
                                  controller: controller.locationTEC,
                                  decoration: const InputDecoration(
                                    hintText: 'Rua Fernandes, 324, Itajubá',
                                    hintStyle: TextStyle(
                                      color: hintColor,
                                      fontSize: 13,
                                    ),
                                  ),
                                  maxLines: null,
                                  onChanged: (val) =>
                                      controller.setLocation(val),
                                ),
                                trailing: IconButton(
                                  tooltip: "Use sua localização atual",
                                  icon: const Icon(
                                    Icons.location_on,
                                    size: 25.0,
                                    color: primaryColor,
                                  ),
                                  iconSize: 30.0,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  onPressed: () => controller.getLocation(),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(right: 50),
                              child: CustomTextFormField(
                                hintText: '35987654344',
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
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Text('Tipos de pagamento'),
                        SizedBox(height: 10),
                        RadioButtons(),
                        SizedBox(height: 40),
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

enum Payment { pix, presencial }

class RadioButtons extends StatelessWidget {
  RadioButtons({super.key});

  Payment? payment = Payment.pix;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutViewModel>(
      init: Get.find<CheckoutViewModel>(),
      builder: (controller) => Center(
          child: GroupButton(
        options: GroupButtonOptions(
            selectedColor: primaryColor,
            borderRadius: BorderRadius.circular(10)),
        onSelected: (value, index, isSelected) =>
            controller.setPayment('${value}'),
        isRadio: true,
        buttons: [
          "pix",
          "pessoalmente",
        ],
      )),
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
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: 'total: ',
                fontSize: 14,
                color: Colors.grey,
              ),
              CustomText(
                text: 'R\$${controller.totalPrice.toString()}',
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
