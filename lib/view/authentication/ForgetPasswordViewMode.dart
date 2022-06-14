import 'package:helbage/app/_route.dart';
import 'package:helbage/shared/_shared.dart';
import 'package:helbage/services/FirebaseServices/_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

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
    _navigationService.pushNamedAndRemoveUntil(Routes.homeScreen);
  }

  void NavigateToRegister() {
    _navigationService.navigateTo(Routes.userSignUp);
  }

  void NavigateToLogin() {
    _navigationService.navigateTo(Routes.userLogin);
  }
}
