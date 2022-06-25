import 'package:helbage/app/route.locator.dart';
import 'package:helbage/model/tagModel.dart';
import 'package:helbage/model/vehicleModel.dart';
import 'package:helbage/services/FirebaseServices/storage_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ViewVehicleModel extends BaseViewModel{
  
  final _navigationService = locator<NavigationService>();
  final stor = locator<storage_service>();
  List<VehicleModel> vList = [];

  @override
  ViewVehicleModel(){
    fetchVehicle();
  }

  void fetchVehicle(){
    var listener =
        stor.readCollectionAsStream("vehicle").listen((event) {});
    listener.onData((data) {
      vList = data.docs.map((e) => VehicleModel.fromJson(e.data())).toList();
      notifyListeners();
      // listener.cancel();
    });
  }

}

