import 'package:helbage/app/_route.dart';
import 'package:helbage/constant/_constant.dart';
import 'package:helbage/model/_model.dart';
import 'package:helbage/services/FirebaseServices/_services.dart';
import 'package:helbage/shared/_shared.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CreateScheduleViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final auth = locator<AuthService>();
  final stor = locator<storage_service>();
  bool setup = false;
  List<Row> InputList = new List.empty(growable: true);

  List<List<TextEditingController>> ControllerList = List.empty(growable: true);

  Validation validate = Validation();
  CreateScheduleViewModel() {}

  // void addNewRow() {
  //   ControllerList.add([TextEditingController(), TextEditingController()]);
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
  //   /*ControllerList.add(TextEditingController());
  //   InputList.add(
  //     TextinputForm(
  //               "City",
  //               Colors.black,
  //               Colors.white,
  //               ControllerList.last,
  //               validator: validate.validateForEmpty,
  //               inputype: TextInputType.text,
  //             )
  //   );*/
  //   notifyListeners();
  // }

  Future<bool> create(state, city, _formkey, _timeField, platno) async {
    if (!_formkey.currentState!.validate()) {
      return false;
    } else {
      if (state == null) {
        _dialogService.showDialog(title: "State is not selected");
        return false;
      }
      if (platno == null) {
        _dialogService.showDialog(title: "Vehicle is not assigned");
        return false;
      }

      List<String> createLocationList = new List.empty(growable: true);
      List<String> createDurationList = new List.empty(growable: true);
      ControllerList.forEach((element) {
        createLocationList.add(element[0].text);
        createDurationList.add(element[1].text);
      });
      int index = 0;

      MalaysiaState.values.forEach((element) {
        if (element.name == state) {
          index = element.index;
        }
      });
      MalaysiaState s = getState(state);
      print(s.name);
      pathModel newPath = new pathModel.fromInput(
          startTimeString: _timeField.text,
          locationList: createLocationList,
          durationList: createDurationList,
          vehicle: platno);
      scheduleModel schedule = new scheduleModel(s, newPath, city);
      stor.insertLevel2(
          collection: 'schedule',
          document: schedule.state,
          subCollection: 'Path',
          subColDoc: schedule.pathName,
          data: schedule.getPath().toFirestore());
      notifyListeners();
      _navigationService.back();
      return true;
    }
  }

  void deleteLastRow() {
    if (InputList.length > 2) {
      ControllerList.removeLast();
      InputList.removeLast();
      notifyListeners();
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
