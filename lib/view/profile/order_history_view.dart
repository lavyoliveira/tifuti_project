import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../core/viewmodel/checkout_viewmodel.dart';
import '../widgets/custom_text.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 130.h,
            child: Padding(
              padding: EdgeInsets.only(bottom: 24.h, left: 16.w, right: 16.w),
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
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(16.h),
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
