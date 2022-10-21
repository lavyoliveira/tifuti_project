import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../domain/viewmodel/cart_viewmodel.dart';
import '../../domain/viewmodel/home_viewmodel.dart';
import '../../model/cart_model.dart';
import '../../model/product_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../../config/theme.dart';

class SearchView extends StatefulWidget {
  final String? searchValue;

  const SearchView(this.searchValue, {Key? key}) : super(key: key);

  @override
  SearchViewState createState() => SearchViewState();
}

class SearchViewState extends State<SearchView> {
  final cartController = Get.find<CartViewModel>();
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
            child: ListTile(
              leading: const Icon(
                Icons.search,
                color: primaryColor,
                size: 25,
              ),
              title: TextFormField(
                decoration: const InputDecoration(
                  hintStyle: TextStyle(
                    color: primaryColor,
                    fontSize: 20,
                  ),
                  border: InputBorder.none,
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
            child: GridView.builder(
              padding: const EdgeInsets.only(left: 20, right: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 15,
              ),
              itemCount: searchProducts.length,
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
                        child: Image.network(searchProducts[index].image,
                            height: 120, width: 100),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.only(top: 50, left: 10),
                          child: Text(
                            searchProducts[index].name,
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
                            'R\$${searchProducts[index].price}',
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
                                  name: searchProducts[index].name,
                                  image: searchProducts[index].image,
                                  price: searchProducts[index].price,
                                  productId: searchProducts[index].productId,
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
