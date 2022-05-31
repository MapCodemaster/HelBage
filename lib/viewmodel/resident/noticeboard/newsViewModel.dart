import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helbage/app/route.locator.dart';
import 'package:helbage/model/newsModel.dart';
import 'package:helbage/services/FirebaseServices/storage_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NewsViewModel extends StreamViewModel<List<NewsModel>> {
  final navigate = locator<NavigationService>();
  final storageService = locator<storage_service>();
  @override
  Stream<List<NewsModel>> get stream => fetchNews();
  Stream<List<NewsModel>> fetchNews() {
    
    return storageService.readCollectionAsStream("news").map((event) =>
        event.docs.map((e) => NewsModel.fromJson(e.data())).toList());
  }

  Future<bool> launch(String _url) async {
    try {
      launchUrl(Uri.parse(_url));
      return true;
    } catch (e) {
      return false;
    }
  }
}
