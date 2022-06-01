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

class viewScheduleViewModel extends BaseViewModel{
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final auth = locator<AuthService>();
  final stor = locator<storage_service>();
 
  Map<String,scheduleModel> scheduleList=new Map();
  bool status=false;
  /*
  Stream<Map<String,scheduleModel>> get stream => fetchNews();
  Stream<Map<String,scheduleModel>> fetchNews() {
    stor.readDocumentAsStream("schedule/Johor/Path","Johor").map((event) {
      scheduleList[event.id]=new scheduleModel(
          MalaysiaState.Johor, 
          new pathModel.fromFireStore(
            startTimeString:event['StartTime'],
            locationList: event['location'],
            vehicle:event['vehicle'],
            endTimeString: event['EndTime']

            ));
    });
    
    return scheduleList;
  }
  */
  viewScheduleViewModel (){
    status=false;
    
    setScheduleList("Johor");
    
  }

  void setScheduleList(String state)
  {
    var listener=stor.readCollectionAsStream("schedule/"+state+"/Path")
    .listen((event) {});
    listener.onData((event){
      event.docs.forEach((element) { 
        try{
        scheduleList[element.id]=new scheduleModel(
          MalaysiaState.Johor, 
          new pathModel.fromFireStore(
            startTimeString:element['StartTime'],
            locationList: element['locationList'],
            durationList: element['durationList'],
            vehicle:element['vehicle'],
            endTimeString: element['EndTime']),element.id);
        }catch(e)
        {
        }
      });

       status=true;
       notifyListeners();
       //listener.cancel();
    }
       );
     //cancel update listner
     
  }
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
  bool getStatus()
  {
    return status;
  }
  void checkPrint(scheduleItem)
  {
    
    _navigationService.navigateTo(Routes.singleScheduleView,arguments: scheduleItem);//pass to router.router.dart
  }
  void addSchedule()
  {
    _navigationService.navigateTo(Routes.createSchedule);
  }
  void quit()
  {
    _navigationService.navigateTo(Routes.viewSchedule);
  }
  void navigate(int index)
  {
    print("call navigate");
    switch (index) {
      case 0: _navigationService.navigateTo(Routes.adminMainScreen);break;
      case 1:_navigationService.navigateTo(Routes.adminMainScreen);break;
      case 2:_navigationService.navigateTo(Routes.adminMainScreen);break;
      case 3:_navigationService.navigateTo(Routes.adminMainScreen);break;
      case 4:_navigationService.navigateTo(Routes.adminMainScreen);break;
      default:_navigationService.navigateTo(Routes.adminMainScreen);break;
    }
  }
  
}