import 'package:flutter/material.dart';

Widget flexTextWidget({
  required String text,
  double fontSize = 11,
  FontWeight fontWeight = FontWeight.w400,
  Color color = Colors.black,
  BoxFit boxFit = BoxFit.none
}) {
  return FittedBox(
    fit: boxFit,
    child: Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        fontFamily: 'Roboto',
      ),
    ),
  );
}
