import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecom_food/Widgets/small_text.dart';
import 'package:ecom_food/utils/colors.dart';
import 'package:ecom_food/utils/dimensions.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;
  double TextHeight = Dimensions.screenHeight / 2.63;
  @override
  void initState() {
    super.initState();
    if (widget.text.length > TextHeight) {
      firstHalf = widget.text.substring(0, TextHeight.toInt());
      secondHalf =
          widget.text.substring(TextHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(color: AppColors.paraColor,text: firstHalf)
          : Column(
        children: [
          SmallText(height:1.4,color: AppColors.paraColor,
            text: hiddenText
                ? (firstHalf + "...")
                : (firstHalf + secondHalf),size: Dimensions.height15,),
          InkWell(
            onTap: () {
              setState(() {
                hiddenText = !hiddenText;
              });
            },
            child: Row(
              children: [
                SmallText(
                  text: hiddenText?"Show more":"Show less",
                  color: AppColors.mainColor,
                ),
                Icon(hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up, color: AppColors.mainColor)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
