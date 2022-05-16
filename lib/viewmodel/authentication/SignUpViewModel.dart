import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:helbage/app/route.locator.dart';
import 'package:helbage/services/FirebaseServices/FirebaseAuth.dart';
import 'package:helbage/services/FirebaseServices/FirebaseStorage.dart';
import 'package:helbage/services/FirebaseServices/auth_service.dart';
import 'package:helbage/services/FirebaseServices/storage_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:helbage/app/route.router.dart';

import '../../model/userModel.dart';

class SignUpViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final auth = locator<AuthService>();
  final stor = locator<storage_service>();
  Future<bool> signUp(
      GlobalKey<FormState> _formkey,
      TextEditingController email,
      TextEditingController password,
      TextEditingController name,
      TextEditingController phone,
      TextEditingController address,
      TextEditingController city,
      String? state,
      TextEditingController postcode,
      TextEditingController home,
      String? gender) async {
    Future.delayed(Duration(seconds: 5));
    if (!_formkey.currentState!.validate()) {
      return false;
    } else {
      dynamic result = await auth.signUp(email.text, password.text);
      print(result);
      if (result != true) {
        _dialogService.showDialog(
            title: "Register Error",
            description: result,
            dialogPlatform: DialogPlatform.Material);
        return false;
      } else {
        
        UserModel newuser=new UserModel(
          email: email.text, 
          name: name.text, 
          userID: auth.getUID(),
          address: address.text, 
          userType:"User",
          city: city.text, 
          postcode: postcode.text, 
          state: state.toString(), 
          gender: gender.toString(), 
          phoneNo: phone.text, 
          homeNo: home.text, 
          profilePictureURL: "https://firebasestorage.googleapis.com/v0/b/helbage.appspot.com/o/image%2FdefaultProfile.png?alt=media&token=b523e2d0-01ae-4bf6-ae43-e7e7f2a74d6e"
        );
        
        bool Insertresult=await stor.insert(auth.getUID(), "user",newuser.toFirestore());
        if (Insertresult != true) {
        _dialogService.showDialog(
            title: "Personal Information Error",
            description: "Error happen in registration, try again later",
            dialogPlatform: DialogPlatform.Material);
          auth.deleteAccount();
        return false;
      }
      else
      return true;
      }
    }
  }

  void NaviageToMain() {
    _navigationService.navigateTo(Routes.residentMainScreen);
  }

  void NavigateToRegister() {
    _navigationService.navigateTo(Routes.userSignUp);
  }

  void NavigateToForgetPassword() {
    _navigationService.navigateTo(Routes.forgetPassword);
  }
}
