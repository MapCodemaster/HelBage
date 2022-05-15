import 'package:helbage/model/userModel.dart';
import 'package:helbage/view/Profile/EditProfileScreen.dart';
import 'package:stacked/stacked.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:helbage/app/route.locator.dart';
import 'package:helbage/services/FirebaseServices/auth_service.dart';
import 'package:helbage/services/FirebaseServices/storage_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:helbage/app/route.router.dart';
import 'package:helbage/services/FirebaseServices/storage_service.dart';
import 'package:helbage/services/FirebaseServices/FirebaseStorage.dart';

class AccountBodyInfoPartViewModel extends StreamViewModel<UserModel> {
  final storageService = locator<storage_service>();
  final _auth = locator<AuthService>();
  final navigate = locator<NavigationService>();
  @override
  Stream<UserModel> get stream => fetchUserInfo();
  Stream<UserModel> fetchUserInfo() {
    return storageService
        .readDocumentAsStream("user", _auth.getUID())
        .map((event) => UserModel.fromJson(event.data()));
  }
}
