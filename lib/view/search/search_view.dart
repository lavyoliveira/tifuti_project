import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../domain/viewmodel/home_viewmodel.dart';
import '../../model/product_model.dart';
import '../widgets/custom_text.dart';
import '../../config/theme.dart';

class SearchView extends StatefulWidget {
  final String? searchValue;

  const SearchView(this.searchValue, {Key? key}) : super(key: key);

  @override
  SearchViewState createState() => SearchViewState();
}

class SearchViewState extends State<SearchView> {
  String? _searchValue;

  @override
  void initState() {
    _searchValue = widget.searchValue!.toLowerCase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> searchProducts = _searchValue == ''
        ? []
        : Get.find<HomeViewModel>()
            .products
            .where(
                (product) => product.name.toLowerCase().contains(_searchValue!))
            .toList();

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
                    text: 'Procurar',
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 49,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(45.r),
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
                initialValue: _searchValue,
                onFieldSubmitted: (value) {
                  setState(() {
                    _searchValue = value.toLowerCase();
                  });
                },
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, bottom: 24),
              child: GetBuilder<HomeViewModel>(
                init: Get.find<HomeViewModel>(),
                builder: (controller) => GridView.builder(
                  padding: const EdgeInsets.all(0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 15,
                    mainAxisExtent: 320,
                  ),
                  itemCount: searchProducts.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
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
                                searchProducts[index].image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            CustomText(
                              text: searchProducts[index].name,
                              fontSize: 16,
                            ),
                            CustomText(
                              text: '\$${searchProducts[index].price}',
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
          ),
        ],
      ),
    );
  }
}
