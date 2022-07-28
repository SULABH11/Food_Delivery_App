import 'package:flutter/cupertino.dart';
import 'package:ecom_food/utils/dimensions.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color IconColor;
  final double size;
  final double Iconsize;
  const AppIcon(
      {Key? key,
        required this.icon,
        this.backgroundColor = const Color(0xFFfcf4e4),
        this.IconColor = const Color(0xFF756d54),
        this.size = 40,  this.Iconsize=24})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2),
          color: backgroundColor),
      child: Icon(icon, color: IconColor, size: Iconsize),
    );
  }
}
