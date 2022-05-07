import 'package:flutter/material.dart';
import 'package:helbage/shared/styles.dart';
import 'package:helbage/shared/color.dart';
import 'package:helbage/shared/inputFields.dart';
import 'package:helbage/viewmodel/LoginViewModel.dart';
import 'package:stacked/stacked.dart';
import 'package:helbage/shared/validation.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({Key? key}) : super(key: key);

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  @override
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  bool loading = false;
  Validation validateFields = Validation();

  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.nonReactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: white,
              title: Text('Sign In',
                  style: TextStyle(
                      color: Colors.grey, fontFamily: 'Poppins', fontSize: 15)),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    model.NavigateToRegister();
                  },
                  child: Text('Sign Up', style: contrastText),
                )
              ],
            ),
            body: loading
                ? Center(
                    child: CircularProgressIndicator(
                    semanticsLabel: "Loading No",
                  ))
                : Form(
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
                                  Text('Welcome Back!', style: h3),
                                  Text('Let\'s authenticate',
                                      style: taglineText),
                                  fryoEmailInput('Email Address',
                                      controller: _email,
                                      validator: validateFields.validateEmail),
                                  fryoPasswordInput('Password',
                                      controller: _pass,
                                      validator:
                                          validateFields.validatePassword),
                                  FlatButton(
                                    onPressed: () {
                                      model.NavigateToForgetPassword();
                                    },
                                    child: Text('Forgot Password?',
                                        style: contrastTextBold),
                                  )
                                ],
                              ),
                              Positioned(
                                bottom: 15,
                                right: -15,
                                child: FlatButton(
                                  onPressed: () async {
                                    setState(() {
                                      loading = true;
                                    });

                                    bool check = await model.login(
                                        _formkey, _email, _pass);
                                    setState(() {
                                      loading = false;
                                    });
                                    if (check) {
                                      model.NaviageToMain();
                                    }
                                  },
                                  color: primaryColor,
                                  padding: EdgeInsets.all(13),
                                  shape: CircleBorder(),
                                  child:
                                      Icon(Icons.arrow_forward, color: white),
                                ),
                              )
                            ],
                          ),
                          height: 300,
                          width: double.infinity,
                          decoration: authPlateDecoration,
                        ),
                      ],
                    ),
                  )));
  }
}
