import 'package:flutter/material.dart';
import 'package:helbage/shared/styles.dart';

class TextinputForm extends StatelessWidget {
  double widthRatio = 5;
  String placeholder = "placeholder";
  Color borderColor = Colors.black;
  Color backgroundColor = Colors.white;
  TextEditingController? controller = null;
  dynamic validator = null;
  TextInputType? inputype;
  bool readonly;
  int? maxLines;
  int? minLines;
  TextinputForm(
      this.placeholder, this.borderColor, this.backgroundColor, this.controller,
      {this.validator,
      this.inputype,
      this.widthRatio = 5,
      required this.readonly,
      this.maxLines,
      this.minLines});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width -
            MediaQuery.of(context).size.width / widthRatio,
        child: TextFormField(
          maxLines: maxLines,
          minLines: minLines,
          readOnly: readonly,
          keyboardType: inputype,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
              labelStyle:
                  TextStyle(color: Colors.black, fontFamily: 'AvenirLight'),
              labelText: this.placeholder,
              fillColor: backgroundColor,
              filled: true,
              enabledBorder: inputFieldDefaultBorderStyle,
              focusedBorder: inputFieldFocusedBorderStyle,
              hintText: placeholder),
        ));
  }
}
