import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:food_app/utils/dimensions.dart';

class BigText extends StatelessWidget {
  final String text;
  Color? color;
  double size;
  TextOverflow overflow;
  BigText({
    super.key,
    this.color = const Color(0xFF000000),
    required this.text,
    this.size = 0,
    this.overflow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontSize: size == 0 ? Dimensions.font20 : size,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
