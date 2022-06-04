import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:helbage/app/route.locator.dart';
import 'package:helbage/services/FirebaseServices/FirebaseAuth.dart';
import 'package:helbage/services/FirebaseServices/FirebaseStorage.dart';
import 'package:helbage/services/FirebaseServices/auth_service.dart';
import 'package:helbage/services/FirebaseServices/storage_service.dart';
import 'package:helbage/view/admin/noticeboard/insertNews.dart';
import 'package:helbage/view/admin/noticeboard/newsList.dart';
import 'package:helbage/view/resident/noticeboard/news.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:helbage/app/route.router.dart';
import 'package:helbage/model/newsModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:helbage/app/route.locator.dart';

class insertNewsViewModel extends BaseViewModel {
  final storageService = locator<storage_service>();
  final _navigationService = locator<NavigationService>();

  Future<bool> insertNews(
    TextEditingController Url,
  ) async {
    Future.delayed(Duration(seconds: 5));

    if (Url.text == "") {
      return false;
    } else {
      storageService.newsSetup(Url.text);

      return true;
    }
  }

  void NavigateToNews() {
    // _navigationService.navigateTo(Routes.News);
    _navigationService.back();
  }
}
