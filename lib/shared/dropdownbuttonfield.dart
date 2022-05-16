import 'package:flutter/material.dart';
import 'package:helbage/shared/color.dart';
import 'package:helbage/shared/styles.dart';

Widget getStateDropDown({onChanged,String? value}) {
  double size = 15;
  return Container(
    height: 55.0,
    width: 400.0,
    child: DropdownButtonFormField(
        value: value,
        isExpanded: true,
        decoration: InputDecoration(
          enabledBorder: inputFieldDefaultBorderStyle,
          focusedBorder: inputFieldFocusedBorderStyle,
        ),
        hint: Text(
          "State",
          style: TextStyle(fontSize: size),
        ),
        items: [
          DropdownMenuItem(
            child: Text("Johor", style: TextStyle(fontSize: size)),
            value: "Johor",
          ),
          DropdownMenuItem(
            child: Text("Kedah", style: TextStyle(fontSize: size)),
            value: "Kedah",
          ),
          DropdownMenuItem(
            child: Text("Kelantan", style: TextStyle(fontSize: size)),
            value: "Kelantan",
          ),
          DropdownMenuItem(
            child: Text("Malacca", style: TextStyle(fontSize: size)),
            value: "Malacca",
          ),
          DropdownMenuItem(
            child: Text("Negeri Sembilan", style: TextStyle(fontSize: size)),
            value: "Negeri Sembilan",
          ),
          DropdownMenuItem(
            child: Text("Pahang", style: TextStyle(fontSize: size)),
            value: "Pahang",
          ),
          DropdownMenuItem(
            child: Text("Penang", style: TextStyle(fontSize: size)),
            value: "Penang",
          ),
          DropdownMenuItem(
            child: Text("Perak", style: TextStyle(fontSize: size)),
            value: "Perak",
          ),
          DropdownMenuItem(
            child: Text("Perlis", style: TextStyle(fontSize: size)),
            value: "Perlis",
          ),
          DropdownMenuItem(
            child: Text("Sabah", style: TextStyle(fontSize: size)),
            value: "Sabah",
          ),
          DropdownMenuItem(
            child: Text("Sarawak", style: TextStyle(fontSize: size)),
            value: "Sarawak",
          ),
          DropdownMenuItem(
            child: Text("Selangor", style: TextStyle(fontSize: size)),
            value: "Selangor",
          ),
          DropdownMenuItem(
            child: Text("Kuala Lumpur", style: TextStyle(fontSize: size)),
            value: "Kuala Lumpur",
          ),
          DropdownMenuItem(
            child: Text("Labuan", style: TextStyle(fontSize: size)),
            value: "Labuan",
          ),
          DropdownMenuItem(
            child: Text("Putrajaya", style: TextStyle(fontSize: size)),
            value: "Putrajaya",
          ),
        ],
        onChanged: onChanged),
  );
}
