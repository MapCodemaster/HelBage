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

class AccountBodyScreenViewModel extends BaseViewModel {
  final navigate = locator<NavigationService>();
  final auth = locator<AuthService>();
  void NavigateToEditProfile() {
    navigate.navigateToView(EditProfileScreen());
  }

  void SignOut() {
    auth.signOut();
    navigate.pushNamedAndRemoveUntil(Routes.homeScreen);
  }
}
