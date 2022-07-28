import 'package:flutter/material.dart';
import 'package:ecom_food/Controllers/Popular_Product_detail.dart';
import 'package:ecom_food/Page/Food/Popular_Food_Detail.dart';
import 'package:ecom_food/Page/Food/Recommended_Food_Detail.dart';
import 'package:get/get.dart';
import 'package:ecom_food/Helper/dependencies..dart' as dep;
import 'Controllers/Recommended_Product_Controller.dart';
import 'Page/Home/food_page_body.dart';
import 'Page/Home/main_food_page.dart';
import 'Routes/Route_helper.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      home: Mainfoodpage(),
      initialRoute: RouteHelper.initial,
      getPages: RouteHelper.routes,
    );
  }
}
