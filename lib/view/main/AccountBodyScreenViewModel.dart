import 'package:helbage/app/_route.dart';
import 'package:helbage/services/FirebaseServices/_services.dart';
import 'package:helbage/view/Profile/_profile.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

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
