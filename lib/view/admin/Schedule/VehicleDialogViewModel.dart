import 'package:helbage/app/_route.dart';

import 'package:helbage/model/_model.dart';
import 'package:helbage/services/FirebaseServices/_services.dart';
import 'package:helbage/shared/_shared.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class VehicleDialogViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final auth = locator<AuthService>();
  final _storageService = locator<storage_service>();
  final _snackBar = locator<SnackbarService>();
  List<VehicleModel> vList = [];
  VehicleDialogViewModel() {
    fetchVehicle();
  }
  void fetchVehicle() {
    var listener =
        _storageService.readCollectionAsStream("vehicle").listen((event) {});
    listener.onData((data) {
      vList = data.docs.map((e) => VehicleModel.fromJson(e.data())).toList();
      notifyListeners();
      // listener.cancel();
    });
  }

  void deleteVehicle(String _platno) async {
    DialogResponse? response = await _dialogService.showConfirmationDialog(
        title: "Are you sure to delete this vehicle?");
    if (response!.confirmed) {
      bool yes = await _storageService.delete(
        _platno,
        "vehicle",
      );
    }
  }

  Future<void> addVehicle(TextEditingController _platno) async {
    bool validity = true;
    vList.forEach((element) {
      if (element.platNo == _platno.text) {
        validity = false;
      }
    });

    if (!validity) {
      _dialogService.showDialog(
          title: "Duplicated Plat Number",
          description:
              "The plat number added already existed in the system. Please try with other plat number.");
    } else {
      if (_platno.text.length != 0) {
        var data = {"platNo": _platno.text};

        await _storageService
            .insert(_platno.text, "vehicle", data)
            .whenComplete(() {
          _snackBar.showSnackbar(
            message: "Added Successfully",
          );
        });
      } else {
        _dialogService.showDialog(
            title: "Empty input",
            description: "The plat number cannot be empty");
      }
      ;
    }
  }

  void navigatePop() {
    _navigationService.popRepeated(1);
  }

  void navigateAssign(String? platno) {
    _navigationService.back(result: platno);
  }
}
