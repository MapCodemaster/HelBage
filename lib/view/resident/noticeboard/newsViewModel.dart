import 'package:flutter/material.dart';
import 'package:helbage/app/_route.dart';
import 'package:helbage/model/_model.dart';
import 'package:helbage/services/FirebaseServices/_services.dart';
import 'package:helbage/view/resident/noticeboard/_resident_Noticeboard.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class NewsViewModel extends StreamViewModel<List<NewsModel>> {
  final navigate = locator<NavigationService>();
  final storageService = locator<storage_service>();
  @override
  Stream<List<NewsModel>> get stream => fetchNews();
  Stream<List<NewsModel>> fetchNews() {
    return storageService.readCollectionAsStream("news").map((event) =>
        event.docs.map((e) => NewsModel.fromJson(e.data(), e.id)).toList());
  }

  Future<bool> launch(String _url) async {
    try {
      launchUrl(Uri.parse(_url));
      return true;
    } catch (e) {
      return false;
    }
  }

  void share(String url) {
    Share.share(url);
  }
}
