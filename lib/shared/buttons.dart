import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:helbage/shared/color.dart';

TextButton froyoFlatBtn(String text, onPressed) {
  return TextButton(
    onPressed: onPressed,
    child: Text(
      text,
      style: TextStyle(
        color: white,
      ),
    ),
    style: ButtonStyle(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => primaryColor),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)))),
  );
}

OutlinedButton froyoOutlineBtn(String text, onPressed) {
  return OutlinedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: primaryColor),
      ),
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          TextStyle(
            color: primaryColor,
          ),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        side: MaterialStateBorderSide.resolveWith(
          ((states) => BorderSide(color: primaryColor)),
        ),
      ));
}

txtButton(String label, onPressed, Color color, double widthSize,
    double heightSize, TextStyle txtStyle,
    {double? radius}) {
  return ElevatedButton(
    onPressed: onPressed,
    child: Text(
      label,
      textAlign: TextAlign.center,
      style: txtStyle,
    ),
    style: ElevatedButton.styleFrom(
        primary: color,
        fixedSize: Size(widthSize, heightSize),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius == null ? 50 : radius))),
  );
}
