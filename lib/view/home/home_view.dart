import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../domain/viewmodel/cart_viewmodel.dart';
import '../../domain/viewmodel/checkout_viewmodel.dart';
import '../../domain/viewmodel/home_viewmodel.dart';
import '../../model/cart_model.dart';
import '../../model/product_model.dart';
import '../category/category_products_view.dart';
import '../search/search_view.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../../config/theme.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CheckoutViewModel());
    Get.put(CartViewModel());
    Get.put(HomeViewModel());

    return Scaffold(
      body: GetBuilder<HomeViewModel>(
        init: Get.find<HomeViewModel>(),
        builder: (controller) => controller.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.only(
                        top: 30, bottom: 30, right: 16, left: 16),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.search,
                            color: primaryColor,
                            size: 30,
                          ),
                          title: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'buscar',
                              hintStyle: TextStyle(
                                color: primaryColor,
                                fontSize: 20,
                              ),
                              border: InputBorder.none,
                            ),
                            onFieldSubmitted: (value) {
                              Get.to(() => SearchView(value));
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 44,
                        ),
                        const CustomText(
                          text: 'categorias',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 19,
                        ),
                        const ListViewCategories(),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              text: 'produtos',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => CategoryProductsView(
                                      categoryName: 'Produtos',
                                      products: controller.products,
                                    ));
                              },
                              child: const Text(
                                'ver todos',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: warningColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ListViewProducts(),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 40,
                  );
                },
              ),
      ),
    );
  }
}

class ListViewCategories extends StatelessWidget {
  const ListViewCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      builder: (controller) => SizedBox(
        height: 90,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => CategoryProductsView(
                      categoryName: controller.categories[index].name,
                      products: controller.products
                          .where((product) =>
                              product.category ==
                              controller.categories[index].name.toLowerCase())
                          .toList(),
                    ));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    // elevation: 1,
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        color: Colors.white,
                        border: Border.all(
                          color: backgroundColor,
                          width: 1,
                        ),
                      ),
                      height: 70,
                      width: 70,
                      child: Image.network(
                        controller.categories[index].image,
                        height: double.infinity,
                        width: double.infinity,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                  CustomText(
                    text: controller.categories[index].name,
                    fontSize: 12,
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              width: 40,
            );
          },
        ),
      ),
    );
  }
}

class ListViewProducts extends StatelessWidget {
  ListViewProducts({Key? key}) : super(key: key);

  final cartController = Get.find<CartViewModel>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      builder: (controller) => SizedBox(
        height: 320.h,
        child: GridView.builder(
          // padding: const EdgeInsets.only(bottom: 100),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 15,
          ),
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 50,
                      ),
                      child: Container(color: primaryColor),
                    ),
                  ),
                  ClipRRect(
                    // borderRadius: new BorderRadius.circular(40.0),
                    child: Image.network(controller.products[index].image,
                        height: 120, width: 100),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.only(top: 50, left: 10),
                      child: Text(
                        controller.products[index].name,
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
                        'R\$${controller.products[index].price}',
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
                              name: controller.products[index].name,
                              image: controller.products[index].image,
                              price: controller.products[index].price,
                              productId: controller.products[index].productId,
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
    );
  }
}
