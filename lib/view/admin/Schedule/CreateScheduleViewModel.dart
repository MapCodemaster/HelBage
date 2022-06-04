import 'package:flutter/material.dart';
import 'package:helbage/app/route.locator.dart';
import 'package:helbage/app/route.router.dart';
import 'package:helbage/model/constant/State.dart';
import 'package:helbage/model/pathModel.dart';
import 'package:helbage/model/scheduleModel.dart';
import 'package:helbage/services/FirebaseServices/auth_service.dart';
import 'package:helbage/services/FirebaseServices/storage_service.dart';
import 'package:helbage/shared/textInputForm.dart';
import 'package:helbage/shared/validation.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CreateScheduleViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final auth = locator<AuthService>();
  final stor = locator<storage_service>();

  List<Row> InputList = new List.empty(growable: true);

  List<List<TextEditingController>> ControllerList = List.empty(growable: true);

  Validation validate = Validation();
  CreateScheduleViewModel() {
    addNewRow();
    addNewRow();
  }

  void addNewRow() {
    ControllerList.add([TextEditingController(), TextEditingController()]);
    InputList.add(
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      TextinputForm(
        "Location",
        Colors.black,
        Colors.white,
        ControllerList.last[0],
        validator: validate.validateForEmpty,
        inputype: TextInputType.text,
        widthRatio: 1.5,
      ),
      TextinputForm(
        "Duration",
        Colors.black,
        Colors.white,
        ControllerList.last[1],
        validator: validate.validateNumOnly,
        inputype: TextInputType.text,
        widthRatio: 1.5,
      ),
    ]));
    /*ControllerList.add(TextEditingController());
    InputList.add(
      TextinputForm(
                "City",
                Colors.black,
                Colors.white,
                ControllerList.last,
                validator: validate.validateForEmpty,
                inputype: TextInputType.text,
              )
    );*/
    notifyListeners();
  }
  Future<bool> create(state,city,_formkey,_timeField) async
  {
    if (!_formkey.currentState!.validate()) {
      return false;
    } else {
      List<String> createLocationList = new List.empty(growable: true);
      List<String> createDurationList = new List.empty(growable: true);
      ControllerList.forEach((element) {
        createLocationList.add(element[0].text);
        createDurationList.add(element[1].text);
      });
    pathModel newPath=new pathModel.fromInput(
      startTimeString: _timeField.text, 
      locationList: createLocationList, 
      durationList: createDurationList);
    scheduleModel schedule=new scheduleModel(getState(state),newPath, city);

    await stor.insertLevel2(collection: "schedule", document: schedule.state, subCollection: "Path", subColDoc: schedule.pathName, data: schedule.getPath().toFirestore());

     _navigationService.navigateTo(Routes.viewSchedule);
    return true;     
    }
    
    

  }

  void quit() {
    _navigationService.navigateTo(Routes.viewSchedule);
  }
  void deleteLastRow()
  {
    if(InputList.length>2)
    {
      ControllerList.removeLast();
      InputList.removeLast();
      notifyListeners();
    }
  }
  MalaysiaState getState(String state)
  {
   
    switch (state)
    {
      case  "Johor": return MalaysiaState.Johor;
      case  "Kedah": return MalaysiaState.Kedah;
      case  "Pahang": return MalaysiaState.Pahang;
      case  "Kelatan": return MalaysiaState.Kelantan;
      case  "Kuala Lumpur": return MalaysiaState.Kuala_Lumpur;
      case  "Malacca": return MalaysiaState.Malacca;
      case  "Negeri Sembilan": return MalaysiaState.Negeri_Sembilan;
      case  "Perak": return MalaysiaState.Perak;
      case  "Perlis": return MalaysiaState.Perlis;
      case  "Sabah": return MalaysiaState.Sabah;
      case  "Sarawak": return MalaysiaState.Sarawak;
      case  "Selangor": return MalaysiaState.Selangor;
      default: return MalaysiaState.Johor;
    }
  }
}
