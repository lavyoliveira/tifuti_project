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
                    text: 'histórico de compras',
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
            child: GetBuilder<CheckoutViewModel>(
              init: Get.find<CheckoutViewModel>(),
              builder: (controller) => ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Pedido feito em: '),
                              CustomText(
                                text: controller.checkouts[index].date,
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ],
                          ),
                          SizedBox(height: 6),
                          CustomTextProducts(
                            text: 'produtos: ',
                          ),
                          // CustomText(
                          //   text: controller.checkouts[index].estado,
                          // ),
                          SizedBox(height: 18),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('pendente',
                                  style: TextStyle(color: Colors.red)),
                              CustomText(
                                text:
                                    'total: R\$${controller.checkouts[index].totalPrice}',
                                color: primaryColor,
                                fontSize: 14,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 20),
                itemCount: controller.checkouts.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
