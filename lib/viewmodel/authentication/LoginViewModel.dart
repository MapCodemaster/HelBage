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

class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final storageService = locator<storage_service>();
  final auth = locator<AuthService>();

  Future<bool> login(GlobalKey<FormState> _formkey, TextEditingController email,
      TextEditingController password) async {
    Future.delayed(Duration(seconds: 5));
    if (!_formkey.currentState!.validate()) {
      return false;
    } else {
      dynamic result = await auth.signIn(email.text, password.text);

      if (result == null) {
        _dialogService.showDialog(
            title: "Login Error",
            description: "Invalid Credentials",
            dialogPlatform: DialogPlatform.Material);
        return false;
      } else {
        return true;
      }
    }
  }

  void NaviageToMain() async {
    DocumentSnapshot snapshotc =
        await storageService.read("user", auth.getUID());
    var temp = snapshotc.data() as Map;
    if (temp["userType"].toString() == "User") {
      print("resident");
      _navigationService.navigateTo(Routes.residentMainScreen);
    } else {
      _navigationService.navigateTo(Routes.adminMainScreen);
    }
  }

  void NavigateToRegister() {
    _navigationService.navigateTo(Routes.userSignUp);
  }

  void NavigateToForgetPassword() {
    _navigationService.navigateTo(Routes.forgetPassword);
  }
}
