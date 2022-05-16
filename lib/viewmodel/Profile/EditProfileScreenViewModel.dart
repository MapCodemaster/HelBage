import 'dart:io';

import 'package:helbage/model/userModel.dart';
import 'package:helbage/services/FirebaseServices/FileStorage.dart';
import 'package:helbage/services/FirebaseServices/FirebaseFileStorage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/cupertino.dart';
import 'package:helbage/app/route.locator.dart';
import 'package:helbage/services/FirebaseServices/auth_service.dart';
import 'package:helbage/services/FirebaseServices/storage_service.dart';
import 'package:stacked_services/stacked_services.dart';

class EditProfileScreenViewModel extends StreamViewModel<UserModel> {
  final storageService = locator<storage_service>();
  final _auth = locator<AuthService>();
  final navigate = locator<NavigationService>();
  final _filestorage = locator<FileStorage>();
  Stream<UserModel> get stream => fetchUserInfo();
  Stream<UserModel> fetchUserInfo() {
    return storageService
        .readDocumentAsStream("user", _auth.getUID())
        .map((event) => UserModel.fromJson(event.data()));
  }

  Future<void> edit(
      TextEditingController phone,
      TextEditingController home,
      TextEditingController address,
      TextEditingController city,
      TextEditingController postcode,
      String? state,
      String picURL,
      {required String imagePath}) async {
    String url = "null";
    if (imagePath != "Empty") {
      File image = File(imagePath);

      url = await _filestorage.uploadToStorage(image);
      print(url);
      if (picURL != "null") {
        _filestorage.deleteFromStorage(picURL);
      }
    } else {
      if (picURL != "null") {
        url = picURL;
      }
    }
    final data = {
      'phoneNo': phone.text,
      'homeNo': home.text,
      'address': address.text,
      'city': city.text,
      'postcode': postcode.text,
      'state': state,
      'profilePictureURL': url
    };
    await storageService.update(_auth.getUID(), "user", data);
  }
}
