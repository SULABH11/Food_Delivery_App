import 'package:ecom_food/Controllers/Popular_Product_detail.dart';
import 'package:ecom_food/Controllers/Recommended_Product_Controller.dart';
import 'package:ecom_food/Controllers/cart_controller.dart';
import 'package:ecom_food/data/api/api_client.dart';
import 'package:ecom_food/data/repository/cart_repo.dart';
import 'package:ecom_food/data/repository/popular_product_repo.dart';
import 'package:ecom_food/utils/app_cnstants.dart';
import 'package:get/get.dart';

import '../data/repository/Recommended_Product_Repo.dart';

Future<void> init() async {
  //apiClient
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BaseUrl));
  //repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo());
  //controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
          () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}

