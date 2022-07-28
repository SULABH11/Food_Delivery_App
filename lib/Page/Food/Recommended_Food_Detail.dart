import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecom_food/Controllers/Recommended_Product_Controller.dart';
import 'package:ecom_food/Widgets/Expandable_Text_Widget.dart';
import 'package:ecom_food/Widgets/app_icon.dart';
import 'package:ecom_food/Widgets/big_text.dart';
import 'package:ecom_food/utils/app_cnstants.dart';
import 'package:ecom_food/utils/colors.dart';
import 'package:ecom_food/utils/dimensions.dart';
import 'package:get/get.dart';

import '../../Controllers/Popular_Product_detail.dart';
import '../../Controllers/cart_controller.dart';
import '../../Routes/Route_helper.dart';

class RecommendedFoodDetail extends StatelessWidget {
  int pageId;
  RecommendedFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
    Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            bottom: PreferredSize(
              child: Container(
                child: Center(
                  child: BigText(
                    text: product.name!,
                    size: Dimensions.height20,
                    color: AppColors.mainBlackColor,
                  ),
                ),
                padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.height20),
                      topRight: Radius.circular(Dimensions.height20),
                    ),
                    color: Colors.pinkAccent),
              ),
              preferredSize: Size.fromHeight(20),
            ),
            pinned: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                ),
                GetBuilder<PopularProductController>(
                  builder: (controller) {
                    return Stack(children: [
                      AppIcon(icon: Icons.add_shopping_cart_outlined),
                      Get.find<PopularProductController>().totalItems >= 1
                          ? Positioned(
                        right: 0,
                        top: 0,
                        child: AppIcon(
                          icon: Icons.circle,
                          size: 20,
                          backgroundColor: Colors.transparent,
                          IconColor: AppColors.mainColor,
                        ),
                      )
                          : Container(),
                      Get.find<PopularProductController>().totalItems >= 1
                          ? Positioned(
                          right: 3,
                          top: 3,
                          child: BigText(
                              text: Get.find<PopularProductController>()
                                  .totalItems
                                  .toString(),
                              size: 12,
                              color: Colors.white))
                          : Container()
                    ]);
                  },
                )
              ],
            ),
            expandedHeight: 300,
            backgroundColor: AppColors.mainColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BaseUrl + "/uploads/" + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(children: [
              SizedBox(
                height: Dimensions.height20,
              ),
              Container(
                child: ExpandableTextWidget(text: product.description!),
                margin: EdgeInsets.only(
                    left: Dimensions.height20, right: Dimensions.height20),
              )
            ]),
          ),
        ],
      ),
      bottomNavigationBar:
      GetBuilder<PopularProductController>(builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: Dimensions.height20,
                  right: Dimensions.height20,
                  bottom: Dimensions.height10,
                  top: Dimensions.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.setQuantity(false);
                    },
                    child: AppIcon(
                      icon: Icons.remove,
                      backgroundColor: AppColors.mainColor,
                      Iconsize: Dimensions.height30,
                    ),
                  ),
                  BigText(
                      text: "\$ ${product.price}" +
                          " X" +
                          " ${controller.incartItems}",
                      color: AppColors.mainBlackColor,
                      size: Dimensions.height24),
                  GestureDetector(
                    onTap: () {
                      controller.setQuantity(true);
                    },
                    child: AppIcon(
                      icon: Icons.add,
                      backgroundColor: AppColors.mainColor,
                      Iconsize: Dimensions.height30,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height10,
                  bottom: Dimensions.height10,
                  left: Dimensions.height10,
                  right: Dimensions.height20),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        left: Dimensions.height10,
                        right: Dimensions.height10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.height20),
                      color: Colors.white10,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: AppColors.mainColor,
                          size: Dimensions.height15 * 2.5,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        left: Dimensions.height10,
                        right: Dimensions.height10),
                    child: GestureDetector(
                      onTap: () {
                        controller.addItem(product);
                      },
                      child: BigText(
                        text: "\$ ${product.price!} | Add to Cart ",
                        color: Colors.white,
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(Dimensions.height20),
                        color: AppColors.mainColor),
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
