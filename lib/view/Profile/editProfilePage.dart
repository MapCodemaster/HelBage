import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'profile.dart';
import 'package:helbage/viewmodel/editProfileModel.dart';

class EditProfilePage extends StatefulWidget{
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>{
  User user = UserPreferences.myUser;
  

  Widget buildUpdateButton() => ButtonWidget(
  text: 'Save',
  onClicked: () {
    Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=> ProfilePage()),
              );
  },
  );
  
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: buildAppBar(context),
    body: ListView(
      padding: EdgeInsets.symmetric(horizontal: 32),
        physics: const BouncingScrollPhysics(),
        children: [
          Profile(
            imagePath: user.imagePath,
            isEdit: true,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          // Can put under modify file
          TextFieldWidget(
            label: 'Full name',
            text: user.name,
            onChanged: (name){},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Gender',
            text: user.gender,
            onChanged: (gender){},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Address',
            text: user.Address,
            maxLines: 5,
            onChanged: (Address){},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'State',
            text: user.state,
            onChanged: (state){},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'City',
            text: user.city,
            onChanged: (city){},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Postcode',
            text: user.postcode,
            onChanged: (postcode){},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Home No',
            text: user.homeNo,
            onChanged: (homeNo){},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Phone No',
            text: user.phoneNo,
            onChanged: (pboneNo){},
          ),
          const SizedBox(height: 24),
          Center(child: buildUpdateButton()),
        ],
      ),
  );


// Can put it into an independent AppBar file
AppBar buildAppBar(BuildContext context) {
    const icon = CupertinoIcons.moon_stars;
    
        return AppBar(
        leading: const BackButton(),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(icon),
            onPressed: (){},
          )
        ],
      );}

}
