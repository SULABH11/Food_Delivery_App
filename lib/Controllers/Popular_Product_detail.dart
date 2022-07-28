import 'package:flutter/material.dart';
import 'package:ecom_food/Controllers/cart_controller.dart';
import 'package:ecom_food/data/repository/popular_product_repo.dart';
import 'package:ecom_food/utils/colors.dart';
import 'package:get/get.dart';

import '../models/products_model.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get PopularProductList => _popularProductList;
  late CartController _cart;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int get quantity => _quantity;
  int _incartItems = 0;
  int get incartItems => _incartItems + quantity;
  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      print("Got products");
      _popularProductList = [];
      _popularProductList
          .addAll(Product.fromJson(response.body).products ?? []);
      //print(_popularProductList);
      _isLoaded = true;
      update();
    } else {}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if (_incartItems + quantity < 0) {
      Get.snackbar(
        "Item Count",
        "You Can't reduce more",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 0;
    } else if (_incartItems + quantity > 20) {
      Get.snackbar(
        "Item Count",
        "You Can't add more",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );

      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _incartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    if (exist) {
      _incartItems = _cart.getQuantity(product);
    }
  }

  void addItem(ProductModel product) {

    _cart.addItem(product, _quantity);
    _quantity = 0;
    _incartItems=_cart.getQuantity(product);
    update();
  }
  int get totalItems{
    return _cart.totalItems;
  }
}


