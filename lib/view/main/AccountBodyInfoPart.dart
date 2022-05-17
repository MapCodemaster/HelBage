import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helbage/model/userModel.dart';
import 'package:helbage/shared/buttons.dart';
import 'package:helbage/shared/color.dart';
import 'package:helbage/viewmodel/main/AccountBodyInfoPartViewModel.dart';

import 'package:stacked/stacked.dart';

class AccountBodyInfoPart extends StatefulWidget {
  const AccountBodyInfoPart({Key? key}) : super(key: key);

  @override
  State<AccountBodyInfoPart> createState() => _AccountBodyInfoPartState();
}

class _AccountBodyInfoPartState extends State<AccountBodyInfoPart> {
  @override
  getImage(String url) {
    if (url == "null" || url == null) {
      return AssetImage("assets/images/person icon.png");
    } else {
      return NetworkImage(url);
    }
  }

  Widget build(BuildContext context) {
    return ViewModelBuilder<AccountBodyInfoPartViewModel>.reactive(
        viewModelBuilder: () => AccountBodyInfoPartViewModel(),
        builder: ((context, model, child) {
          if (!model.dataReady) {
            return Center(
              child: Text("There is no data yet"),
            );
          } else {
            return SizedBox(
              height: 240, // 240
              child: Stack(
                children: <Widget>[
                  ClipPath(
                    clipper: CustomShape(),
                    child: Container(
                      height: 150, //150
                      color: logoColor,
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 10), //10
                          height: 140, //140
                          width: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 5, //8
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: getImage(model.data!.profilePictureURL),
                            ),
                          ),
                        ),
                        Text(
                          model.data!.name,
                          style: TextStyle(
                            fontSize: 22, // 22
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 5), //5
                        Text(
                          model.data!.email,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF8492A2),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          model.data!.userType == "User" ? "Resident" : "Admin",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: logoColor,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        }));
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
