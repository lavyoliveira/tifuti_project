import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../domain/viewmodel/cart_viewmodel.dart';
import '../../model/cart_model.dart';
import '../../model/product_model.dart';
import '../product/product_detail_view.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../../config/theme.dart';

class CategoryProductsView extends StatelessWidget {
  final String categoryName;
  final List<ProductModel> products;
  final cartController = Get.find<CartViewModel>();

  CategoryProductsView(
      {Key? key, required this.categoryName, required this.products})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
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
                  CustomText(
                    text: categoryName,
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
            child: GridView.builder(
              padding: const EdgeInsets.only(left: 20, right: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 15,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        child: Container(
                          padding: const EdgeInsets.only(
                            top: 50,
                          ),
                          child: Container(color: primaryColor),
                        ),
                      ),
                      ClipRRect(
                        // borderRadius: new BorderRadius.circular(40.0),
                        child: Image.network(products[index].image,
                            height: 120, width: 100),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.only(top: 50, left: 10),
                          child: Text(
                            products[index].name,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 10, left: 10),
                          child: const Text(
                            'preço',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: const EdgeInsets.only(
                            bottom: 7,
                            right: 10,
                          ),
                          child: Text(
                            'R\$${products[index].price}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          padding: const EdgeInsets.only(right: 10, bottom: 10),
                          width: 50,
                          child: CustomButtonCart(
                            '+',
                            () {
                              cartController.addProduct(
                                CartModel(
                                  name: products[index].name,
                                  image: products[index].image,
                                  price: products[index].price,
                                  productId: products[index].productId,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
