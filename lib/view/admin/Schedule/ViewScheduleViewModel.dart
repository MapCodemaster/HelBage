import 'package:helbage/app/route.locator.dart';
import 'package:helbage/app/route.router.dart';
import 'package:helbage/model/constant/State.dart';
import 'package:helbage/model/pathModel.dart';
import 'package:helbage/model/scheduleModel.dart';
import 'package:helbage/services/FirebaseServices/auth_service.dart';
import 'package:helbage/services/FirebaseServices/storage_service.dart';
import 'package:helbage/view/admin/Schedule/SingleScheduleView.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class viewScheduleViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final auth = locator<AuthService>();
  final stor = locator<storage_service>();
  String negeri = "";
  Map<String, scheduleModel> scheduleList = new Map();
  bool status = false;
  viewScheduleViewModel() {
    status=true;
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
    int index = 0;

    MalaysiaState.values.forEach((element) {
      if (element.name == state) {
        index = element.index;
        
      }
    });
    MalaysiaState s = MalaysiaState.values.elementAt(index);
    if (db.length != 0) {
      var listener = db.listen((event) {});
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
        
      });
    }
    await Future.delayed(Duration(seconds: 2));
    status = true;
    notifyListeners();

    //listener.cancel();
  }

  //cancel update listner

  /*void getData()
  {

    //update data when change

    var listener=stor.readDocumentAsStream("schedule/Johor/Path","Johor")
    .listen((event) {});
    listener.onData((event){
        scheduleList[event.id]=new scheduleModel(
          MalaysiaState.Johor,
          new pathModel.fromFireStore(
            startTimeString:event['StartTime'],
            locationList: event['location'],
            vehicle:event['vehicle'],
            endTimeString: event['EndTime']),event.id);
       status=true;
       notifyListeners();
       listener.cancel();
       print(scheduleList);});
     //cancel update listner




  }*/

  bool getStatus() {
    return status;
  }

  void checkPrint(scheduleItem, isAdmin) {
    // _navigationService.navigateTo(Routes.singleScheduleView,
    //     arguments: scheduleItem);
    // //pass to router.router.dart
    _navigationService.navigateToView(SingleScheduleView(
      value: scheduleItem,
      isAdmin: isAdmin,
    ));
  }

  void addSchedule() {
    _navigationService.navigateTo(Routes.createSchedule);
  }
}
