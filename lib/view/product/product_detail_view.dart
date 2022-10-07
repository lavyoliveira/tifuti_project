import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/viewmodel/cart_viewmodel.dart';
import '../../model/cart_model.dart';
import '../../model/product_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../../config/theme.dart';

class ProductDetailView extends StatelessWidget {
  final ProductModel _productModel;

  const ProductDetailView(this._productModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      SizedBox(
                        height: 196,
                        width: double.infinity,
                        child: Image.network(
                          _productModel.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Column(
                      children: [
                        CustomText(
                          text: _productModel.name,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const SizedBox(
                          height: 33,
                        ),
                        const CustomText(
                          text: 'Detalhes',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomText(
                          text: _productModel.description,
                          fontSize: 14,
                          height: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Material(
            elevation: 12,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: 'Preço',
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      CustomText(
                        text: 'R\$${_productModel.price}',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ],
                  ),
                  GetBuilder<CartViewModel>(
                    builder: (controller) => SizedBox(
                      width: 146,
                      child: CustomButton('Carrinho', () {
                        controller.addProduct(
                          CartModel(
                            name: _productModel.name,
                            image: _productModel.image,
                            price: _productModel.price,
                            productId: _productModel.productId,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoundedShapeInfo extends StatelessWidget {
  final String title;
  final Widget content;

  const RoundedShapeInfo({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 160,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: title,
              fontSize: 14,
              alignment: Alignment.center,
            ),
            content,
          ],
        ),
      ),
    );
  }
}
