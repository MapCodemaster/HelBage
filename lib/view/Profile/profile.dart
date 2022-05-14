import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:helbage/services/FirebaseServices/FirebaseStorage.dart';

import 'editProfilePage.dart';


class ProfilePage extends StatefulWidget{
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=> EditProfilePage()),
              );
            },
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 24),
          buildGender(user),
          const SizedBox(height: 24),
          buildAddress(user),
          const SizedBox(height: 24),
          buildHomeNo(user),
          const SizedBox(height: 24),
          buildPhoneNo(user),
          const SizedBox(height: 24)
        ],
      ),
    );
  }

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

  Widget buildName(FirebaseStor fire) => Column(
  children: [
    Text(
      user.name,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
    ),
  ],
);

  Widget buildAddress(User user) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 48),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Address',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
            Text(
              user.Address,
              style: const TextStyle(fontSize: 16, height: 1.4)
            ),
            const SizedBox(height: 24),
            const Text(
            'State',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
            Text(
              user.state,
              style: const TextStyle(fontSize: 16, height: 1.4)
            ),
            const SizedBox(height: 24),
            const Text(
            'City',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
            Text(
              user.city,
              style: const TextStyle(fontSize: 16, height: 1.4)
            ),
            const SizedBox(height: 24),
            const Text(
            'PostCode',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
            Text(
              user.postcode,
              style: const TextStyle(fontSize: 16, height: 1.4)
            ),
            const SizedBox(height: 24),
        ],
      )
  );  

  Widget buildGender(User user) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 48),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Gender',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
            Text(
              user.gender,
              style: const TextStyle(fontSize: 16, height: 1.4)
            )
        ],
      )
  );

  Widget buildHomeNo(User user) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 48),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Home No',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
            Text(
              user.homeNo,
              style: const TextStyle(fontSize: 16, height: 1.4)
            )
        ],
      )
  );

  Widget buildPhoneNo(User user) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 48),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Phone No',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
            Text(
              user.phoneNo,
              style: const TextStyle(fontSize: 16, height: 1.4)
            )
        ],
      )
  );
}

// Button 
class ButtonWidget extends StatelessWidget{
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      shape: const StadiumBorder(),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
    ),
    child: Text(text),
    onPressed: onClicked,
  );
}

class ProfileWidget extends StatelessWidget{
  final String imagePath;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.onClicked,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    
    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditButton(color),)
          ],
      ) 
      
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
        image: image,
        fit: BoxFit.cover,
        width: 128,
        height: 128,
        child: InkWell(onTap: onClicked),
        ),
      )
    );
  }

  Widget buildEditButton(Color color) => buildCircle(
    color: Colors.white, // white circle shape of edit button
    all: 3,
    child: buildCircle(
      color: color,
      all: 8, 
      child: const Icon(
          Icons.edit,
          color: Colors.white,
          size: 20,
      ),
    ),
  ); 

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) => ClipOval(
    child: Container(
        child: child,
        padding: EdgeInsets.all(all),
        color: color,
      ),
  );
}