import 'package:helbage/app/route.locator.dart';
import 'package:helbage/app/route.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/FirebaseServices/auth_service.dart';
import '../../../services/FirebaseServices/storage_service.dart';

class SingleScheduleViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final auth = locator<AuthService>();
  final stor = locator<storage_service>();

  Future<void> delete(schedule) async {
    bool isDelete = await stor.delete(
        "schedule/" + schedule.state + "/Path", schedule.pathName);
    String previouspath = _navigationService.previousRoute;
    _navigationService.pushNamedAndRemoveUntil(previouspath);
  }
<<<<<<< HEAD
  void edit(schedule)
  {
    _navigationService.navigateTo(Routes.editScheduleView,arguments: schedule);
  }
  void quit()
  {
=======

  void edit() {}
  void quit() {
>>>>>>> 04886bbbe6967b13021f07fe96a0c17fd113fef8
    _navigationService.navigateTo(Routes.viewSchedule);
  }
}
