import 'package:flutter/cupertino.dart';
import 'package:helbage/app/route.locator.dart';
import 'package:helbage/services/FirebaseServices/FirebaseAuth.dart';
import 'package:helbage/view/main/ResidentMainScreen.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:helbage/app/route.router.dart';
import 'package:helbage/app/route.locator.dart';

class ForgetPasswordViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  FirebaseAuthService auth = FirebaseAuthService();

  FirebaseAuthService get _auth => auth;
  void ResetPassword(
      TextEditingController _email, GlobalKey<FormState> _formkey) {
    if (!_formkey.currentState!.validate()) {
    } else {
      auth.resetPassword(_email.text);
      NaviageToHome();
    }
  }

  void NaviageToHome() {
    _navigationService.navigateTo(Routes.homeScreen);
  }

  void NavigateToRegister() {
    _navigationService.navigateTo(Routes.userRegister);
  }

  void NavigateToLogin() {
    _navigationService.navigateTo(Routes.userLogin);
  }
}
