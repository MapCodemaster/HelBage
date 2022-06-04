// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:helbage/shared/buttons.dart';
import 'package:helbage/shared/dropdownbuttonfield.dart';
import 'package:helbage/shared/styles.dart';
import 'package:helbage/shared/textInputForm.dart';
import 'package:helbage/shared/validation.dart';
import 'package:stacked/stacked.dart';
import 'package:helbage/viewmodel/authentication/SignUpViewModel.dart';
import 'package:helbage/shared/color.dart';

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
  String? dropdownValue = "Male";
  String? state = "Johor";
  Validation validate = Validation();
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.nonReactive(
        viewModelBuilder: () => SignUpViewModel(),
        builder: (context, model, child) => Scaffold(
            backgroundColor: Colors.white,
            body: _loading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            Container(
                                child: Center(
                              child: Image.asset('assets/images/profile.png',
                                  width: MediaQuery.of(context).size.height / 4,
                                  height:
                                      MediaQuery.of(context).size.height / 4),
                            )),
                            TextinputForm(
                              "Email",
                              Colors.black,
                              Colors.white,
                              _emailField,
                              validator: validate.validateEmail,
                              inputype: TextInputType.emailAddress,
                              readonly: false,
                            ),
                            TextinputForm(
                              "Password",
                              Colors.black,
                              Colors.white,
                              _passwordField,
                              validator: validate.validatePassword,
                              inputype: TextInputType.visiblePassword,
                              readonly: false,
                            ),
                            TextinputForm(
                              "Name",
                              Colors.black,
                              Colors.white,
                              _nameField,
                              validator: validate.validateForEmpty,
                              inputype: TextInputType.name,
                              readonly: false,
                            ),
                            Container(
                                padding: EdgeInsets.only(top: 10),
                                width: MediaQuery.of(context).size.width -
                                    MediaQuery.of(context).size.width / 5,
                                child: DropdownButtonFormField(
                                    value: dropdownValue,
                                    decoration: InputDecoration(
                                      enabledBorder:
                                          inputFieldDefaultBorderStyle,
                                      focusedBorder:
                                          inputFieldFocusedBorderStyle,
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
                                    ],
                                    onChanged: (String? val) => {
                                          setState(() {
                                            dropdownValue = val;
                                          })
                                        })),
                            TextinputForm(
                              "Phone Number (Start with 01x-)",
                              Colors.black,
                              Colors.white,
                              _phoneField,
                              validator: validate.validatePhoneNo,
                              inputype: TextInputType.phone,
                              readonly: false,
                            ),
                            TextinputForm(
                              "Address",
                              Colors.black,
                              Colors.white,
                              _addressField,
                              validator: validate.validateForEmpty,
                              inputype: TextInputType.streetAddress,
                              readonly: false,
                            ),
                            TextinputForm(
                              "City",
                              Colors.black,
                              Colors.white,
                              _cityField,
                              validator: validate.validateForEmpty,
                              inputype: TextInputType.text,
                              readonly: false,
                            ),
                            Container(
                                padding: EdgeInsets.only(top: 10),
                                width: MediaQuery.of(context).size.width -
                                    MediaQuery.of(context).size.width / 5,
                                child: getStateDropDown(
                                    onChanged: (String? value) =>
                                        {state = value},
                                    value: state)),
                            TextinputForm(
                              "Postcode",
                              Colors.black,
                              Colors.white,
                              _postcodeField,
                              validator: validate.validatePostcode,
                              inputype: TextInputType.numberWithOptions(),
                              readonly: false,
                            ),
                            TextinputForm(
                              "Home No (Start with 0x- or 0xx-)",
                              Colors.black,
                              Colors.white,
                              _homeField,
                              validator: validate.validateHomeNo,
                              inputype: TextInputType.phone,
                              readonly: false,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            txtButton("Sign Up", () async {
                              setState(() {
                                _loading = true;
                              });
                              bool check = await model
                                  .signUp(
                                      _formkey,
                                      _emailField,
                                      _passwordField,
                                      _nameField,
                                      _phoneField,
                                      _addressField,
                                      _cityField,
                                      state,
                                      _postcodeField,
                                      _homeField,
                                      dropdownValue)
                                  .whenComplete(() {
                                setState(() {
                                  _loading = false;
                                });
                              });
                              if (check) {
                                model.NaviageToMain();
                              }
                            },
                                primaryColor,
                                120,
                                20,
                                TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                radius: 50)
                          ],
                        )))));
  }
}
