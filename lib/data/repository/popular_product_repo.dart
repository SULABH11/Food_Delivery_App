import 'package:ecom_food/data/api/api_client.dart';
import 'package:ecom_food/utils/app_cnstants.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get.dart';
class PopularProductRepo extends GetxService{
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});
  Future<Response> getPopularProductList() async
  {
    return await apiClient.getData(AppConstants.PopularProductUri);
  }
}