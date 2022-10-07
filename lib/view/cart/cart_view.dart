import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../domain/viewmodel/cart_viewmodel.dart';
import 'checkout_view.dart';
import '../../config/theme.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_button.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CartViewModel>(
        builder: (controller) => controller.cartProducts.isEmpty
            ? const Center(
                child: Text('O carrinho está vazio.'),
              )
            : Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 74, right: 16, left: 16),
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(controller.cartProducts[index].productId),
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 33),
                              child: const Icon(
                                Icons.delete_forever,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                            onDismissed: (direction) {
                              if (direction == DismissDirection.endToStart) {
                                controller.removeProduct(
                                    controller.cartProducts[index].productId);
                              }
                            },
                            child: Row(
                              children: [
                                Image.network(
                                  controller.cartProducts[index].image,
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: controller.cartProducts[index].name,
                                      fontSize: 16,
                                    ),
                                    CustomText(
                                      text:
                                          '\$${controller.cartProducts[index].price}',
                                      fontSize: 16,
                                      color: primaryColor,
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      height: 30,
                                      width: 95,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                        color: Colors.grey.shade300,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              child: const Icon(
                                                Icons.add,
                                                size: 20,
                                              ),
                                              onTap: () {
                                                controller
                                                    .increaseQuantity(index);
                                              },
                                            ),
                                            CustomText(
                                              text: controller
                                                  .cartProducts[index].quantity
                                                  .toString(),
                                              fontSize: 16,
                                              alignment: Alignment.center,
                                            ),
                                            GestureDetector(
                                              child: const Icon(
                                                Icons.remove,
                                                size: 20,
                                              ),
                                              onTap: () {
                                                controller
                                                    .decreaseQuantity(index);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 16,
                        ),
                        itemCount: controller.cartProducts.length,
                      ),
                    ),
                  ),
                  Material(
                    elevation: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 17),
                      height: 84,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                text: 'Total',
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              CustomText(
                                text: '\$${controller.totalPrice.toString()}',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                            width: 146,
                            child: CustomButton(
                              'Checkout',
                              () {
                                Get.to(() => CheckoutView());
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
