import 'package:helbage/app/_route.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeScreenViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void NavigateToLogin() {
    _navigationService.navigateTo(Routes.userLogin);
  }

  void NavigateToRegister() {
    _navigationService.navigateTo(Routes.userSignUp);
  }
}
