import 'package:helbage/app/_route.dart';
import 'package:helbage/constant/_constant.dart';
import 'package:helbage/model/_model.dart';
import 'package:helbage/services/FirebaseServices/_services.dart';
import 'package:helbage/view/admin/Schedule/_schedule.dart';
import 'package:helbage/view/resident/schedule/scheduleActiveReminderList.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class viewScheduleViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final auth = locator<AuthService>();
  final stor = locator<storage_service>();
  final datapassing = locator<DataPassingService>();
  var listener;
  //Stream<QuerySnapshot<Map<String, dynamic>>>? listener;

  String negeri = "";
  Map<String, scheduleModel> scheduleList = new Map();
  bool status = false;
  viewScheduleViewModel() {
    status = true;
    notifyListeners();
    //fetchSchedule();
  }
  void setNegeri(String state) {
    negeri = state;
  }

  void fetchSchedule() {
    status = false;
    scheduleList.clear();
    setScheduleList(this.negeri.toString());
  }

  void setScheduleList(String state) async {
    var db = await stor.readCollectionAsStream("schedule/" + state + "/Path");

    MalaysiaState s = getState(state);
    if (db.length != 0) {
      listener = db.listen((event) {});
      listener.onData((event) {
        event.docs.forEach((element) {
          try {
            scheduleList[element.id] = new scheduleModel(
                s,
                new pathModel.fromFireStore(
                    startTimeString: element['StartTime'],
                    locationList: element['locationList'],
                    durationList: element['durationList'],
                    vehicle: element['vehicle'],
                    endTimeString: element['EndTime']),
                element.id);
          } catch (e) {}
        });
        notifyListeners();
      });
    }
    await Future.delayed(Duration(seconds: 1));
    status = true;
    notifyListeners();

    //listener.cancel();
  }

  bool getStatus() {
    return status;
  }

  void checkPrint(scheduleItem, isAdmin) {
    // _navigationService.navigateTo(Routes.singleScheduleView,
    //     arguments: scheduleItem);
    // //pass to router.router.dart
    datapassing.assign(scheduleItem);
    _navigationService.navigateToView(SingleScheduleView(
      value: scheduleItem,
      isAdmin: isAdmin,
    ));
  }

  void navigateToActiveReminder() {
    _navigationService.navigateToView(ScheduleActiveReminderList());
  }

  void addSchedule() {
    _navigationService.navigateTo(Routes.createSchedule);
  }

  @override
  void dispose() {
    print("Widget Dispose");
    listener?.cancel();
  }
}
