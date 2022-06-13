import 'package:helbage/app/route.locator.dart';
import 'package:helbage/model/collectionPointModel.dart';
import 'package:helbage/model/newsModel.dart';
import 'package:helbage/services/FirebaseServices/DataPassingService.dart';
import 'package:helbage/services/FirebaseServices/storage_service.dart';
import 'package:helbage/view/admin/CollectionPoint/createCollectionPointScreen.dart';
import 'package:helbage/view/admin/CollectionPoint/editCollectionPointScreen.dart';
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
    navigate.navigateToView(EditCollectionPointScreen());
  }

  void NavigateToCreatePoint() {
    navigate.navigateToView(createCollectionPointScreen());
  }
}
