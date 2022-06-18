import 'package:flutter/material.dart';
import 'package:helbage/app/_route.dart';
import 'package:helbage/model/_model.dart';
import 'package:helbage/services/FirebaseServices/_services.dart';
import 'package:helbage/shared/_shared.dart';

import 'package:helbage/view/admin/CollectionPoint/_admin_Collection_Point.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CollectionPointListViewModel
    extends StreamViewModel<List<CollectionPointModel>> {
  final navigate = locator<NavigationService>();
  final storageService = locator<storage_service>();
  final datapassing = locator<DataPassingService>();
  final _dialogService = locator<DialogService>();

  @override
  Stream<List<CollectionPointModel>> get stream => fetchPoints();
  Stream<List<CollectionPointModel>> fetchPoints() {
    return storageService.readCollectionAsStream("point").map((event) => event
        .docs
        .map((e) => CollectionPointModel.fromJson(e.data(), e.id))
        .toList());
  }

  void deletePoint(String id) async {
    DialogResponse? response = await _dialogService.showConfirmationDialog(
        title: "Are you sure to delete this bulky waste collection point?");
    if (response!.confirmed) {
      bool yes = await storageService.delete(
        id,
        "point",
      );
    }
  }

  void NavigateToEditPoint(CollectionPointModel point) {
    datapassing.assignToPointModel(point);
    navigate.navigateToView(EditCollectionPointScreen(
      collectionPoint: point,
    ));
  }

  void NavigateToCreatePoint() {
    navigate.navigateToView(createCollectionPointScreen());
  }
}
