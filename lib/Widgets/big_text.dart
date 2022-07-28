import 'package:flutter/cupertino.dart';
import 'package:ecom_food/utils/colors.dart';

import '../utils/dimensions.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;

  BigText(
      {Key? key,
        this.color = const Color(0xFF28282B),
        required this.text,
        this.size = 0,
        this.overflow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
          fontFamily: 'Roboto',
          color: color,
          fontSize: size==0?Dimensions.height20:size,
          fontWeight: FontWeight.w400),
    );
  }
}