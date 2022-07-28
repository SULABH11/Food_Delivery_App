import 'package:ecom_food/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';

import '../data/repository/Recommended_Product_Repo.dart';
import '../models/products_model.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList=[];
  List<dynamic> get recommendedProductList => _recommendedProductList;
  bool _isLoaded=false;
  bool get isLoaded =>_isLoaded;
  Future <void> getRecommendedProductList() async{
    Response response=await recommendedProductRepo.getRecommendedProductList();
    if(response.statusCode == 200)
    {
      print("Got products");
      _recommendedProductList=[];
      _recommendedProductList.addAll(Product.fromJson(response.body).products??[]);
      //print(_popularProductList);
      _isLoaded=true;
      update();
    }
    else
    {

    }
  }
}

