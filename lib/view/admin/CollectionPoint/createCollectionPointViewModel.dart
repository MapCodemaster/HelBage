import 'package:flutter/material.dart';
import 'package:helbage/app/_route.dart';
import 'package:helbage/model/_model.dart';
import 'package:helbage/services/FirebaseServices/_services.dart';
import 'package:helbage/shared/_shared.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart' as GP;

class CreateCollectionPointViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final auth = locator<AuthService>();
  final stor = locator<storage_service>();
  void navigateBack() {
    _navigationService.popRepeated(1);
  }

  Future<bool> createCollectionPoint(String title, String address,
      String? state, GP.GeoPoint? location, GlobalKey<FormState> _key) async {
    if (!_key.currentState!.validate()) {
      print(_key.currentState!.validate());
      return false;
    } else {
      if (state == null) {
        _dialogService.showDialog(title: "State is not selected.");
        return false;
      }
      if (location == null) {
        _dialogService.showDialog(
            title: "Location of collection point is not picked yet.");
        return false;
      }
      CollectionPointModel point = CollectionPointModel(
          title, address, state, location.latitude, location.longitude);
      bool success = false;
      await Future.delayed(Duration(seconds: 2));
      try {
        success = await stor.add("point", point.toJson());
      } catch (e) {}

      if (success) {
        navigateBack();
        return true;
      } else {
        _dialogService.showDialog(title: "Failed to add");
        return false;
      }
    }
  }
}
