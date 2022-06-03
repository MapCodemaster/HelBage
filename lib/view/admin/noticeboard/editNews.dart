import 'dart:io';

import 'package:flutter/material.dart';
import 'package:helbage/model/userModel.dart';
import 'package:helbage/shared/buttons.dart';
import 'package:helbage/shared/color.dart';
import 'package:helbage/shared/dropdownbuttonfield.dart';
import 'package:helbage/shared/validation.dart';
import 'package:helbage/viewmodel/Profile/EditProfileScreenViewModel.dart';
import 'package:helbage/viewmodel/admin/noticeboard/editNewsScreenViewModel.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

class EditNewsScreen extends StatefulWidget {
  const EditNewsScreen({Key? key}) : super(key: key);

  @override
  State<EditNewsScreen> createState() => _EditNewsScreenState();
}

class _EditNewsScreenState extends State<EditNewsScreen> {
  GlobalKey<FormState> _profileform = GlobalKey<FormState>();
  @override
  XFile? _selectedFile;
  bool _loading = false;

  Widget build(BuildContext context) {
    return ViewModelBuilder<EditNewsScreenViewModel>.reactive(
        viewModelBuilder: () => EditNewsScreenViewModel(),
        builder: (context, model, child) {
          if (!model.dataReady) {
            return Center(
              child: Text("There is no data yet"),
            );
          } else {
            TextEditingController url =
                TextEditingController(text: model.data!.url.toString());

            return Form(
                key: _profileform,
                child: Scaffold(
                    appBar: AppBar(
                      elevation: 0,
                      backgroundColor: logoColor,
                      centerTitle: true,
                      title: Text("Edit Detail"),
                    ),
                    body: _loading
                        ? Center(child: CircularProgressIndicator())
                        : SingleChildScrollView(
                            child: Column(children: [
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 5, 30, 10),
                                child: TextFormField(
                                  validator: Validation().validateForEmpty,
                                  controller: url,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 3),
                                      labelStyle: TextStyle(
                                          fontSize: 20,
                                          color: logoColor,
                                          fontWeight: FontWeight.bold),
                                      labelText: "Url Detail",
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      hintStyle: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(27, 10, 27, 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        if (!_profileform.currentState!
                                            .validate()) {
                                        } else {
                                          setState(() {
                                            _loading = true;
                                          });
                                          await model
                                              .edit(url)
                                              .whenComplete(() {
                                            setState(() {
                                              _loading = false;
                                            });
                                          });
                                        }
                                      },
                                      child: Text(
                                        "Update",
                                        style: TextStyle(
                                            fontSize: 14,
                                            letterSpacing: 1.5,
                                            color: Colors.black),
                                      ),
                                      style: ButtonStyle(
                                          elevation:
                                              MaterialStateProperty.resolveWith(
                                                  (states) => 2),
                                          backgroundColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Colors.white),
                                          padding: MaterialStateProperty.all(
                                            EdgeInsets.symmetric(
                                                horizontal: 40),
                                          ),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)))),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await model.delete();
                                      },
                                      child: Text(
                                        "Delete",
                                        style: TextStyle(
                                            fontSize: 14,
                                            letterSpacing: 1.5,
                                            color: Colors.black),
                                      ),
                                      style: ButtonStyle(
                                          elevation:
                                              MaterialStateProperty.resolveWith(
                                                  (states) => 2),
                                          backgroundColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Colors.white),
                                          padding: MaterialStateProperty.all(
                                            EdgeInsets.symmetric(
                                                horizontal: 40),
                                          ),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)))),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        setState(() {});
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                            fontSize: 14,
                                            letterSpacing: 1.5,
                                            color: Colors.black),
                                      ),
                                      style: ButtonStyle(
                                          elevation:
                                              MaterialStateProperty.resolveWith(
                                                  (states) => 2),
                                          backgroundColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Colors.white),
                                          padding: MaterialStateProperty.all(
                                            EdgeInsets.symmetric(
                                                horizontal: 40),
                                          ),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)
                                                          )
                                                          )
                                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          )
                          )
                          );
          }
        }
        );
  }
}
