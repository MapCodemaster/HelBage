import 'package:flutter/material.dart';
import 'package:helbage/app/_route.dart';
import 'package:helbage/model/_model.dart';
import 'package:helbage/services/FirebaseServices/_services.dart';
import 'package:helbage/shared/_shared.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart' as GP;

class EditCollectionPointViewModel
    extends StreamViewModel<CollectionPointModel> {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final auth = locator<AuthService>();
  final stor = locator<storage_service>();
  final datapassing = locator<DataPassingService>();
  Stream<CollectionPointModel> get stream => fetchPoint();
  Stream<CollectionPointModel> fetchPoint() {
    CollectionPointModel point = datapassing.passObject();

    return stor
        .readDocumentAsStream("point", point.id)
        .map((event) => CollectionPointModel.fromJson(event.data(), event.id));
  }

  bool validate(GlobalKey<FormState> _key) {
    if (!_key.currentState!.validate()) {
      return false;
    } else {
      return true;
    }
  }

  get Object {
    CollectionPointModel collectionPoint = datapassing.passObject();
    return collectionPoint;
  }

  Future<bool> editCollectionPoint(
      String title, String address, String? state, GP.GeoPoint location) async {
    CollectionPointModel point = CollectionPointModel(
        title, address, state!, location.latitude, location.longitude);
    bool success = false;
    CollectionPointModel collectionPoint = datapassing.passObject();

    await Future.delayed(Duration(seconds: 2));

    try {
      success = await stor.update(collectionPoint.id, "point", point.toJson());
    } catch (e) {
      print(e);
    }

    if (success) {
      return true;
    } else {
      _dialogService.showDialog(title: "Failed to update");
      return false;
    }
  }
}
