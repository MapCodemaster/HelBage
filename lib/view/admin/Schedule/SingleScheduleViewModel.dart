import 'package:helbage/app/_route.dart';
import 'package:helbage/model/reminderModel.dart';
import 'package:helbage/model/scheduleModel.dart';

import 'package:helbage/services/FirebaseServices/_services.dart';
import 'package:helbage/view/admin/Schedule/_schedule.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SingleScheduleViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final auth = locator<AuthService>();
  final stor = locator<storage_service>();
  final datapassing = locator<DataPassingService>();
  ReminderModel reminder =
      ReminderModel(userID: "", schedule: "", status: false, docID: "");
  SingleScheduleViewModel() {
    fetchReminderInfo();
  }
  void fetchReminderInfo() async {
    var temp = datapassing.passObject() as scheduleModel;
    var path = "schedule/" + temp.state + "/Path/" + temp.pathName;
    var listener = stor.readCollectionAsStream("reminder").listen((event) {});
    listener.onData((data) {
      var listReminder =
          data.docs.map((e) => ReminderModel.fromJson(e.data())).toList();
      listReminder.forEach((element) {
        if (element.userID == auth.getUID() && element.schedule == path) {
          reminder = element;
        }
      });

      notifyListeners();
    });
  }

  Future<void> delete(schedule) async {
    String previouspath = _navigationService.previousRoute;
    bool isDelete = await stor.delete(
      schedule.pathName,
      "schedule/" + schedule.state + "/Path",
    );
    List<ReminderModel> reminderList = [];
    stor.readCollectionAsFuture("reminder").then((value) {
      reminderList = value.docs
          .map((e) => ReminderModel.fromJson(e.data()))
          .toList()
          .where((element) =>
              element.schedule ==
              "schedule/" + schedule.state + "/Path/" + schedule.pathName)
          .toList();
      reminderList.forEach((element) {
        stor.delete(element.docID, "reminder");
      });
    });

    _navigationService.back();
    notifyListeners();
  }

  void edit(schedule) {
    _navigationService.navigateToView(EditScheduleView(schedule: schedule));
  }
}
