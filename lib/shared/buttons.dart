import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:helbage/shared/color.dart';

FlatButton froyoFlatBtn(String text, onPressed) {
  return FlatButton(
    onPressed: onPressed,
    child: Text(text),
    textColor: white,
    color: primaryColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
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
    {double radius = 50}) {
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
            borderRadius: BorderRadius.circular(radius))),
  );
}
