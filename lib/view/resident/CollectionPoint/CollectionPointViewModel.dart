import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:helbage/app/_route.dart';
import 'package:helbage/model/collectionPointModel.dart';
import 'package:helbage/services/FirebaseServices/_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CollectionPointViewModel
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

  CollectionPointModel findPoint(
      List<CollectionPointModel>? list, GeoPoint point) {
    CollectionPointModel temp = list![0];
    list.forEach((element) {
      if (element.location.longitude == point.longitude &&
          element.location.latitude == point.latitude) {
        temp = element;
      }
    });
    return temp;
  }
}
