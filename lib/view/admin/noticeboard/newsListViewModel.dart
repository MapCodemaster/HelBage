import 'package:helbage/app/_route.dart';
import 'package:helbage/model/_model.dart';

import 'package:helbage/services/FirebaseServices/_services.dart';

import 'package:helbage/view/admin/noticeboard/_noticeboard.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NewsListViewModel extends StreamViewModel<List<NewsModel>> {
  final navigate = locator<NavigationService>();
  final storageService = locator<storage_service>();
  final datapassing = locator<DataPassingService>();
  @override
  Stream<List<NewsModel>> get stream => fetchNews();
  Stream<List<NewsModel>> fetchNews() {
    return storageService.readCollectionAsStream("news").map((event) =>
        event.docs.map((e) => NewsModel.fromJson(e.data(), e.id)).toList());
  }

  void navigateToNewsEdit(NewsModel object) {
    datapassing.assignToNewsModel(object);
    navigate.navigateToView(EditNewsScreen());
  }

  void navigateToNewsInsert() {
    navigate.navigateToView(EditNewsPage());
  }
}
