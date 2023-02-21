import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SmillText extends StatelessWidget {
  final String text;
  Color? color;
  double size;
  double height;
  SmillText(
      {super.key,
      this.color = const Color(0xFFccc7c5),
      required this.text,
      this.size = 12,
      this.height = 1.2});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color, fontSize: size, fontFamily: "Poppins", height: height),
    );
  }
}
