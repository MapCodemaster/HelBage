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

OutlineButton froyoOutlineBtn(String text, onPressed) {
  return OutlineButton(
    onPressed: onPressed,
    child: Text(text),
    textColor: primaryColor,
    highlightedBorderColor: highlightColor,
    borderSide: BorderSide(color: primaryColor),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  );
}

txtButton(String label, onPressed, Color color, double widthSize,
    double heightSize, TextStyle txtStyle) {
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
  );
}
