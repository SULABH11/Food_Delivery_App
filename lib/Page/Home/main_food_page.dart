import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecom_food/Widgets/big_text.dart';
import 'package:ecom_food/Widgets/small_text.dart';
import 'package:ecom_food/utils/colors.dart';
import 'package:ecom_food/utils/dimensions.dart';
import 'package:get/get.dart';

import 'food_page_body.dart';

class Mainfoodpage extends StatefulWidget {
  const Mainfoodpage({Key? key}) : super(key: key);

  @override
  State<Mainfoodpage> createState() => _MainfoodpageState();
}

class _MainfoodpageState extends State<Mainfoodpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Container(
                child: Container(
                    margin: EdgeInsets.only(
                        top: Dimensions.height15 * 3, bottom: Dimensions.height15),
                    padding: EdgeInsets.only(
                        left: Dimensions.height20, right: Dimensions.height20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            BigText(text: "India", color: AppColors.mainColor),
                            Row(
                              children: [
                                SmallText(text: "Ghaziabad"),
                                Icon(Icons.arrow_drop_down_rounded),
                              ],
                            ),
                          ],
                        ),
                        Center(
                          child: Container(
                            width: Dimensions.height15 * 3,
                            height: Dimensions.height15 * 3,
                            child: Icon(Icons.search, color: Colors.white),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.mainColor,
                            ),
                          ),
                        )
                      ],
                    ))),
            Expanded(
              child: SingleChildScrollView(
                child: FoodPageBody(),
              ),
            ),
          ],
        ));
  }
}
