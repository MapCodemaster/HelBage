import 'package:helbage/app/_route.dart';
import 'package:helbage/services/FirebaseServices/_services.dart';
import 'package:helbage/view/Profile/_profile.dart';
import 'package:helbage/view/admin/Summary/SummaryView.dart';
import 'package:helbage/view/admin/Vehicle/ViewVehicle.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AccountBodyScreenViewModel extends BaseViewModel {
  final navigate = locator<NavigationService>();
  final auth = locator<AuthService>();
  void NavigateToEditProfile() {
    navigate.navigateToView(EditProfileScreen());
  }

  void NavigateToVehicleView() {
    navigate.navigateToView(ViewVehicle());
  }

  void NavigateToSummary() {
    navigate.navigateToView(SummaryView());
  }

  void SignOut() {
    auth.signOut();
    navigate.pushNamedAndRemoveUntil(Routes.homeScreen);
  }
}
