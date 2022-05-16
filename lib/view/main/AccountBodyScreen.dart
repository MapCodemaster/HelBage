import 'package:flutter/material.dart';
import 'package:helbage/shared/buttons.dart';
import 'package:helbage/shared/color.dart';
import 'package:helbage/view/main/AccountBodyInfoPart.dart';

import 'package:helbage/viewmodel/main/AccountBodyScreenViewModel.dart';
import 'package:stacked/stacked.dart';

class AccountBodyScreen extends StatefulWidget {
  const AccountBodyScreen({Key? key}) : super(key: key);

  @override
  State<AccountBodyScreen> createState() => _AccountBodyScreenState();
}

class _AccountBodyScreenState extends State<AccountBodyScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AccountBodyScreenViewModel>.nonReactive(
        viewModelBuilder: () => AccountBodyScreenViewModel(),
        builder: ((context, model, child) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                AccountBodyInfoPart(),
                InkWell(
                  onTap: () {
                    model.NavigateToEditProfile();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: SafeArea(
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit,
                            size: 20,
                            color: primaryColor,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "Edit Profile",
                            style: TextStyle(
                              fontSize: 16, //16
                              color: Colors.black,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                txtButton("Sign Out", () {
                  model.SignOut();
                },
                    logoColor,
                    150,
                    30,
                    TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ))
              ],
            ),
          );
        }));
  }
}
