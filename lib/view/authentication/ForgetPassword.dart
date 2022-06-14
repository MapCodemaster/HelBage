import 'package:flutter/material.dart';
import 'package:helbage/shared/_shared.dart';
import 'package:helbage/view/authentication/_authentication.dart';
import 'package:stacked/stacked.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();

  Validation validateFields = Validation();

  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgetPasswordViewModel>.nonReactive(
        viewModelBuilder: () => ForgetPasswordViewModel(),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: white,
              title: TextButton(
                onPressed: () {
                  model.NavigateToLogin();
                },
                child: Text('Sign In', style: contrastText),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    model.NavigateToRegister();
                  },
                  child: Text('Sign Up', style: contrastText),
                )
              ],
            ),
            body: Form(
              key: _formkey,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 18, right: 18),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Forget Password', style: h3),
                            Text('Let\'s reset your password',
                                style: taglineText),
                            fryoEmailInput('Email Address',
                                controller: _email,
                                validator: validateFields.validateEmail),
                          ],
                        ),
                        Positioned(
                            bottom: 15,
                            right: 20,
                            child: txtButton("Submit", () {
                              model.ResetPassword(_email, _formkey);
                            },
                                primaryColor,
                                150,
                                20,
                                TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)))
                      ],
                    ),
                    height: 200,
                    width: double.infinity,
                    decoration: authPlateDecoration,
                  ),
                ],
              ),
            )));
  }
}
