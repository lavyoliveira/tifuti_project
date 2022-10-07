import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../model/product_model.dart';
import '../product/product_detail_view.dart';
import '../widgets/custom_text.dart';
import '../../config/theme.dart';

class CategoryProductsView extends StatelessWidget {
  final String categoryName;
  final List<ProductModel> products;

  const CategoryProductsView(
      {Key? key, required this.categoryName, required this.products})
      : super(key: key);

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
                  CustomText(
                    text: categoryName,
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
            child: Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, bottom: 24),
              child: GridView.builder(
                padding: const EdgeInsets.all(0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 15,
                  mainAxisExtent: 320,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(
                        () => ProductDetailView(products[index]),
                      );
                    },
                    child: SizedBox(
                      width: 164,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              color: Colors.white,
                            ),
                            height: 240,
                            width: 164,
                            child: Image.network(
                              products[index].image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          CustomText(
                            text: products[index].name,
                            fontSize: 16,
                          ),
                          CustomText(
                            text: products[index].description,
                            fontSize: 12,
                            color: Colors.grey,
                            maxLines: 1,
                          ),
                          CustomText(
                            text: '\$${products[index].price}',
                            fontSize: 16,
                            color: primaryColor,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
