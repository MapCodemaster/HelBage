import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:helbage/app/_route.dart';

import 'package:helbage/services/FirebaseServices/_services.dart';
import 'package:helbage/shared/_shared.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

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
