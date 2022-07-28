import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecom_food/Controllers/Popular_Product_detail.dart';
import 'package:ecom_food/Controllers/Recommended_Product_Controller.dart';
import 'package:ecom_food/Page/Food/Popular_Food_Detail.dart';
import 'package:ecom_food/Routes/Route_helper.dart';
import 'package:ecom_food/Widgets/App_Column.dart';
import 'package:ecom_food/Widgets/Icon_and_text_Widget.dart';
import 'package:ecom_food/Widgets/big_text.dart';
import 'package:ecom_food/Widgets/small_text.dart';
import 'package:ecom_food/models/products_model.dart';
import 'package:ecom_food/utils/app_cnstants.dart';
import 'package:ecom_food/utils/colors.dart';
import 'package:ecom_food/utils/dimensions.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.9);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;
  @override
  void initstate() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
        print("current value" + _currPageValue.toString());
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("current height is" + MediaQuery.of(context).size.width.toString());
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? Container(
            height: Dimensions.pageView,
            child: PageView.builder(
              controller: pageController,
              physics: BouncingScrollPhysics(),
              itemCount: popularProducts.PopularProductList.length,
              onPageChanged: (page) {
                setState(() {
                  _currPageValue = page.toDouble();
                });
              },
              itemBuilder: (context, position) {
                return _buildPageItem(position,
                    popularProducts.PopularProductList[position]);
              },
            ),
          )
              : CircularProgressIndicator(
            color: AppColors.mainColor,
          );
        }),
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.PopularProductList.isNotEmpty
                ? popularProducts.PopularProductList.length
                : 2,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        SizedBox(height: Dimensions.height30),
        Container(
            margin: EdgeInsets.only(left: Dimensions.height30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BigText(text: "Recommended"),
                SizedBox(
                  width: Dimensions.height10,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 3),
                  child: BigText(text: ".", color: Colors.black26),
                ),
                SizedBox(width: Dimensions.height10),
                Container(
                  margin: EdgeInsets.only(bottom: 2),
                  child: SmallText(
                    text: "Food Pairing",
                  ),
                )
              ],
            )),
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recommendedProduct.recommendedProductList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getRecommendedFood(index));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.height20,
                        right: Dimensions.height20,
                        bottom: Dimensions.height10),
                    child: Row(
                      children: [
                        Container(
                          width: Dimensions.imageWidth,
                          height: Dimensions.imageWidth,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(Dimensions.height20),
                            color: Colors.white38,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(AppConstants.BaseUrl +
                                  "/uploads/" +
                                  recommendedProduct
                                      .recommendedProductList[index].img!),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: Dimensions.textWidth,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(Dimensions.height20),
                                bottomRight:
                                Radius.circular(Dimensions.height20),
                              ),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding:
                              EdgeInsets.only(left: Dimensions.height10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(
                                      text: recommendedProduct
                                          .recommendedProductList[index].name!),
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  SmallText(
                                      text: "With Chinese Characteristics"),
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconAndTextWidget(
                                          icon: Icons.circle_sharp,
                                          text: "Normal",
                                          iconColor: AppColors.iconColor1),
                                      IconAndTextWidget(
                                          icon: Icons.location_on,
                                          text: "1.7Km",
                                          iconColor: AppColors.mainColor),
                                      IconAndTextWidget(
                                          icon: Icons.access_time_rounded,
                                          text: "32min",
                                          iconColor: AppColors.iconColor2),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        }),
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = new Matrix4.identity();

    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.height10, right: Dimensions.height10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.height30),
                color: index.isEven ? Color(0xFF69c5df) : Color(0xff9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      AppConstants.BaseUrl + "/uploads/" + popularProduct.img!),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.height30,
                  right: Dimensions.height30,
                  bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.height20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    )
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height15,
                    left: Dimensions.height15,
                    right: Dimensions.height15),
                child: AppColumn(text: popularProduct.name!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
