import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/theme.dart';
import '../../domain/viewmodel/checkout_viewmodel.dart';
import '../widgets/custom_text.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({Key? key}) : super(key: key);

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
                    text: 'Histórico de compras',
                    fontSize: 20,
                    alignment: Alignment.bottomCenter,
                  ),
                  Container(
                    width: 24,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GetBuilder<CheckoutViewModel>(
              init: Get.find<CheckoutViewModel>(),
              builder: (controller) => ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: controller.checkouts[index].date,
                                  color: Colors.grey,
                                ),
                                CustomText(
                                  text: 'Pendente',
                                  color: Colors.red.shade300,
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey.shade200,
                            ),
                            CustomText(
                              text: controller.checkouts[index].rua,
                            ),
                            CustomText(
                              text: controller.checkouts[index].cidade,
                            ),
                            CustomText(
                              text: controller.checkouts[index].estado,
                            ),
                            CustomText(
                              text: controller.checkouts[index].pais,
                            ),
                            CustomText(
                              text: controller.checkouts[index].telefone,
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey.shade200,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(
                                  text: 'Total faturado',
                                  color: primaryColor,
                                ),
                                CustomText(
                                  text:
                                      '\$${controller.checkouts[index].totalPrice}',
                                  color: primaryColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  thickness: 1,
                  color: Colors.grey.shade200,
                ),
                itemCount: controller.checkouts.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
