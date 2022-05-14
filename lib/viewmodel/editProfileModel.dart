import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Profile extends StatelessWidget{
  final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;

  const Profile({
    Key? key,
    required this.imagePath,
    this.isEdit = false,
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
      child: Icon(
          isEdit ?Icons.add_a_photo: Icons.edit,
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

class TextFieldWidget extends StatefulWidget{
  final String label;
  final String text;
  final ValueChanged<String> onChanged;
  final int maxLines;

  const TextFieldWidget({
    Key? key,
    required this.label,
    required this.onChanged,
    required this.text,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget>{

  late final TextEditingController controller;
  @override
  void initState(){
    super.initState();

    controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose(){
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        widget.label,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 8),
      TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        maxLines: widget.maxLines,
      ),
    ],
  );

  

}