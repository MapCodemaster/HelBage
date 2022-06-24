import 'package:helbage/app/_route.dart';
import 'package:helbage/constant/_constant.dart';
import 'package:helbage/model/_model.dart';
import 'package:helbage/services/FirebaseServices/_services.dart';
import 'package:helbage/shared/_shared.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class EditScheduleViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final stor = locator<storage_service>();
  scheduleModel originalschedule;
  List<Row> InputList = new List.empty(growable: true);
  List<List<TextEditingController>> ControllerList = List.empty(growable: true);
  List oriLocationList;
  List oriDurationList;
  Validation validate = Validation();
  bool setup = false;

  EditScheduleViewModel(
      {required this.oriLocationList,
      required this.oriDurationList,
      required this.originalschedule}) {
    //oriLocationList = originalschedule.getPath().location_List;
    //oriDurationList = originalschedule.getPath().durationList;
    // for (int i = 0; i < locationList.length; i++) {
    //   addNewRow(locationList[i], durationList[i]);
    // }
  }

  // void addNewRow(location, duration) {
  //   ControllerList.add([
  //     TextEditingController(text: location),
  //     TextEditingController(text: duration.toString())
  //   ]);
  //   InputList.add(
  //       Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
  //     TextinputForm(
  //       "Location",
  //       Colors.black,
  //       Colors.white,
  //       ControllerList.last[0],
  //       validator: validate.validateForEmpty,
  //       inputype: TextInputType.text,
  //       widthRatio: 1.5,
  //       readonly: false,
  //     ),
  //     TextinputForm(
  //       "Duration",
  //       Colors.black,
  //       Colors.white,
  //       ControllerList.last[1],
  //       validator: validate.validateNumOnly,
  //       inputype: TextInputType.text,
  //       widthRatio: 1.5,
  //       readonly: false,
  //     ),
  //   ]));

  //   notifyListeners();
  // }

  void deleteLastRow() {
    if (InputList.length > 2) {
      ControllerList.removeLast();
      InputList.removeLast();
      notifyListeners();
    }
  }

  Future<bool> create(state, city, _formkey, _timeField, platno) async {
    if (!_formkey.currentState!.validate()) {
      if (platno == null) {
        _dialogService.showDialog(title: "Vehicle is not assigned");
      }

      return false;
    } else {
      List<String> createLocationList = new List.empty(growable: true);
      List<String> createDurationList = new List.empty(growable: true);
      ControllerList.forEach((element) {
        createLocationList.add(element[0].text);
        createDurationList.add(element[1].text);
      });

      MalaysiaState s = getState(state);

      pathModel newPath = new pathModel.fromInput(
          startTimeString: _timeField.text,
          locationList: createLocationList,
          durationList: createDurationList,
          vehicle: platno);
      scheduleModel schedule = new scheduleModel(s, newPath, city);
      await stor.delete(
        originalschedule.pathName,
        "schedule/" + originalschedule.state + "/Path",
      );
      await stor.insertLevel2(
          collection: "schedule",
          document: schedule.state,
          subCollection: "Path",
          subColDoc: schedule.pathName,
          data: schedule.getPath().toFirestore());

      notifyListeners();
      _navigationService.popRepeated(2);
      return true;
    }
  }

  MalaysiaState getState(String state) {
    switch (state) {
      case "Johor":
        return MalaysiaState.Johor;
      case "Kedah":
        return MalaysiaState.Kedah;
      case "Pahang":
        return MalaysiaState.Pahang;
      case "Kelatan":
        return MalaysiaState.Kelantan;
      case "Kuala Lumpur":
        return MalaysiaState.Kuala_Lumpur;
      case "Malacca":
        return MalaysiaState.Malacca;
      case "Negeri Sembilan":
        return MalaysiaState.Negeri_Sembilan;
      case "Perak":
        return MalaysiaState.Perak;
      case "Perlis":
        return MalaysiaState.Perlis;
      case "Sabah":
        return MalaysiaState.Sabah;
      case "Sarawak":
        return MalaysiaState.Sarawak;
      case "Selangor":
        return MalaysiaState.Selangor;
      default:
        return MalaysiaState.Johor;
    }
  }
}
