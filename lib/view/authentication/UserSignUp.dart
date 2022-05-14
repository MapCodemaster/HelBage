// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:helbage/shared/styles.dart';
import 'package:helbage/shared/validation.dart';
import 'package:stacked/stacked.dart';
import 'package:helbage/viewmodel/SignUpViewModel.dart';

class UserSignUp extends StatefulWidget {
  const UserSignUp({Key? key}) : super(key: key);
  @override
  State<UserSignUp> createState() => _UserSignUp();
}

class _UserSignUp extends State<UserSignUp> {
  @override
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Validation validateFields = Validation();
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();
  TextEditingController _homeField = TextEditingController();
  TextEditingController _phoneField = TextEditingController();
  TextEditingController _nameField = TextEditingController();
  TextEditingController _genderField = TextEditingController();
  TextEditingController _addressField = TextEditingController();
  TextEditingController _stateField = TextEditingController();
  TextEditingController _postcodeField = TextEditingController();
  TextEditingController _cityField = TextEditingController();
  String dropdownValue = "Male";

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.nonReactive(
        viewModelBuilder: () => SignUpViewModel(),
        builder: (context, model, child) => Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
                child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        Container(
                            child: Center(
                          child: Image.asset('assets/images/profile.png',
                              width: MediaQuery.of(context).size.height / 4,
                              height: MediaQuery.of(context).size.height / 4),
                        )),
                        TextinputForm("Email", Colors.black, Colors.white,
                            _emailField, validateFields.validateEmail),
                        TextinputForm("Password", Colors.black, Colors.white,
                            _passwordField),
                        TextinputForm(
                            "Name", Colors.black, Colors.white, _nameField),
                        Container(
                            padding: EdgeInsets.only(top: 10),
                            width: MediaQuery.of(context).size.width -
                                MediaQuery.of(context).size.width / 5,
                            child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  enabledBorder: inputFieldDefaultBorderStyle,
                                  focusedBorder: inputFieldFocusedBorderStyle,
                                ),
                                hint: Text("gender"),
                                items: [
                                  DropdownMenuItem(
                                    child: Text("Male"),
                                    value: "Male",
                                  ),
                                  DropdownMenuItem(
                                    child: Text("Female"),
                                    value: "Female",
                                  ),
                                  DropdownMenuItem(
                                      child: Text("Other"), value: "Other"),
                                ],
                                onChanged: (val) => {
                                      setState(
                                          () => dropdownValue = val as String)
                                    })),
                        TextinputForm("Phone Number", Colors.black,
                            Colors.white, _phoneField),
                        TextinputForm("Address", Colors.black, Colors.white,
                            _addressField),
                        TextinputForm(
                            "City", Colors.black, Colors.white, _cityField),
                        TextinputForm(
                            "State", Colors.black, Colors.white, _stateField),
                        TextinputForm("Postcode", Colors.black, Colors.white,
                            _postcodeField),
                        TextinputForm(
                            "Home No", Colors.black, Colors.white, _homeField),
                        Container(
                            padding: EdgeInsets.only(top: 20),
                            width: MediaQuery.of(context).size.width / 2,
                            child: Center(
                                child: ElevatedButton(
                                    onPressed: () async {
                                      bool check = await model.signUp(
                                          _formkey,
                                          _emailField,
                                          _passwordField,
                                          _nameField,
                                          _phoneField,
                                          _addressField,
                                          _cityField,
                                          _stateField,
                                          _postcodeField,
                                          _homeField,
                                          dropdownValue);

                                      if (check) {
                                        model.NaviageToMain();
                                      }
                                    },
                                    child: Text("Sign Up"))))
                      ],
                    )))));
  }
}

class TextinputForm extends StatelessWidget {
  String placeholder = "placeholder";
  Color borderColor = Colors.black;
  Color backgroundColor = Colors.white;
  TextEditingController? controller = null;
  dynamic validator = null;
  TextinputForm(placeholder, borderColor, backgroundColor, controller,
      [this.validator]) {
    this.placeholder = placeholder;
    this.borderColor = borderColor;
    this.backgroundColor = backgroundColor;
    this.controller = controller;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width -
            MediaQuery.of(context).size.width / 5,
        child: TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
              labelText: this.placeholder,
              fillColor: backgroundColor,
              filled: true,
              enabledBorder: inputFieldDefaultBorderStyle,
              focusedBorder: inputFieldFocusedBorderStyle,
              hintText: placeholder),
        ));
  }
}
