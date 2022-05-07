import 'package:flutter/cupertino.dart';
import 'package:helbage/app/route.locator.dart';
import 'package:helbage/services/FirebaseServices/FirebaseAuth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:helbage/app/route.router.dart';
import 'package:helbage/app/route.locator.dart';

class HomeScreenViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void NavigateToLogin() {
    _navigationService.navigateTo(Routes.userLogin);
  }

  void NavigateToRegister() {
    _navigationService.navigateTo(Routes.userRegister);
  }
}
