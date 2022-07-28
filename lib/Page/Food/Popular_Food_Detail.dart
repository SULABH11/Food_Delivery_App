import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecom_food/Controllers/Popular_Product_detail.dart';
import 'package:ecom_food/Page/Home/main_food_page.dart';
import 'package:ecom_food/Widgets/App_Column.dart';
import 'package:ecom_food/Widgets/Expandable_Text_Widget.dart';
import 'package:ecom_food/Widgets/app_icon.dart';
import 'package:ecom_food/models/products_model.dart';
import 'package:ecom_food/utils/app_cnstants.dart';
import 'package:ecom_food/utils/dimensions.dart';
import 'package:get/get.dart';

import '../../Controllers/cart_controller.dart';
import '../../Widgets/Icon_and_text_Widget.dart';
import '../../Widgets/big_text.dart';
import '../../Widgets/small_text.dart';
import '../../utils/colors.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  PopularFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
    Get.find<PopularProductController>().PopularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.foodimgwidth,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      AppConstants.BaseUrl + "/uploads/" + product.img!),
                ),
              ),
            ),
          ),
          Positioned(
            top: Dimensions.height15 * 3,
            left: Dimensions.height20,
            right: Dimensions.height20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.to(() => Mainfoodpage());
                    },
                    child: AppIcon(icon: Icons.arrow_back_ios)),
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
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.foodimgwidth - 20,
              child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.height20,
                    right: Dimensions.height20,
                    top: Dimensions.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.height20),
                    topRight: Radius.circular(Dimensions.height20),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    BigText(text: "Introduce"),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpandableTextWidget(text: product.description!),
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
      bottomNavigationBar:
      GetBuilder<PopularProductController>(builder: (popularProduct) {
        return Container(
          height: Dimensions.pageViewTextContainer,
          padding: EdgeInsets.only(
              left: Dimensions.height20,
              right: Dimensions.height20,
              top: Dimensions.height30,
              bottom: Dimensions.height30),
          decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.height20 * 2),
                topRight: Radius.circular(Dimensions.height20 * 2),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.height20,
                    right: Dimensions.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.height20),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        popularProduct.setQuantity(false);
                      },
                      child: Icon(
                        Icons.remove,
                        color: AppColors.signColor,
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.height10 / 2,
                    ),
                    BigText(text: popularProduct.incartItems.toString()),
                    SizedBox(
                      width: Dimensions.height10 / 2,
                    ),
                    GestureDetector(
                      onTap: () {
                        popularProduct.setQuantity(true);
                      },
                      child: Icon(
                        Icons.add,
                        color: AppColors.signColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.height20,
                    right: Dimensions.height20),
                child: GestureDetector(
                  onTap: () {
                    popularProduct.addItem(product);
                  },
                  child: BigText(
                    text: "\$ ${product.price!}| Add to Cart ",
                    color: Colors.white,
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.height20),
                    color: AppColors.mainColor),
              )
            ],
          ),
        );
      }),
    );
  }
}