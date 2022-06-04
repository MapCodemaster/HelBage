import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helbage/app/route.locator.dart';
import 'package:helbage/app/route.router.dart';
import 'package:helbage/model/newsModel.dart';
import 'package:helbage/services/FirebaseServices/DataPassingService.dart';
import 'package:helbage/services/FirebaseServices/storage_service.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class EditNewsScreenViewModel extends StreamViewModel<NewsModel> {
  final navigate = locator<NavigationService>();
  final storageService = locator<storage_service>();
  final datapassing = locator<DataPassingService>();
  @override
  Stream<NewsModel> get stream => fetchNews();
  Stream<NewsModel> fetchNews() {
    NewsModel passedObject = datapassing.passAsNewsModel();
    return storageService
        .readDocumentAsStream("news", passedObject.documentID)
        .map((event) => NewsModel.fromJson(event.data(), event.id));
  }

  Future<void> edit(
    TextEditingController url,
  ) async {
    NewsModel passedObject = datapassing.passAsNewsModel();
    final data = {'url': url.text, 'datetime': DateTime.now()};
    await storageService.update(passedObject.documentID, "news", data);
  }

  Future<void> delete() async {
    NewsModel passedObject = datapassing.passAsNewsModel();

    await storageService.delete(passedObject.documentID, "news");

    navigate.pushNamedAndRemoveUntil(Routes.adminMainScreen);
  }
}
