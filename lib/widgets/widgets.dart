import 'package:flutter/material.dart';

Widget flexTextWidget({
  required String text,
  double fontSize = 11,
  FontWeight fontWeight = FontWeight.w400,
  Color color = Colors.black,
  BoxFit boxFit = BoxFit.none,
  TextAlign? textAlign,
}) {
  return FittedBox(
    fit: boxFit,
    child: Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        fontFamily: 'Roboto',
      ),
    ),
  );
}
