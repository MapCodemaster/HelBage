import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helbage/shared/styles.dart';
import 'package:helbage/shared/color.dart';
import 'package:helbage/shared/buttons.dart';
import 'package:helbage/view/admin/Schedule/ViewSchedule.dart';
import 'package:helbage/view/admin/noticeboard/newsList.dart';
import 'package:helbage/view/authentication/UserLogin.dart';

import 'package:helbage/view/authentication/UserSignUp.dart';
import 'package:helbage/view/main/MoreScreen.dart';
import 'package:helbage/viewmodel/main/MainScreenViewModel.dart';
import 'package:stacked/stacked.dart';

class AdminMainScreen extends StatelessWidget {
  final initial;
  const AdminMainScreen({Key? key, this.initial}) : super(key: key);
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainScreenViewModel>.reactive(
      builder: (context, viewModel, child) => WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: getViewForIndex(viewModel.currentIndex),
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
                // sets the background color of the `BottomNavigationBar`
                canvasColor: logoColor,
                // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                primaryColor: Colors.white,
                textTheme: Theme.of(context)
                    .textTheme
                    .copyWith(caption: new TextStyle(color: Colors.yellow))),
            child: BottomNavigationBar(
              fixedColor: Colors.yellow,
              type: BottomNavigationBarType.shifting,
              currentIndex: viewModel.currentIndex,
              onTap: viewModel.setIndex,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.newspaper), label: "Noticeboard"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_month), label: "Schedule"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.fmd_good), label: "Collection\nPoint"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.recycling),
                    label: "Recycling\nGuidelines"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.more_horiz_rounded), label: "More"),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => MainScreenViewModel(),
    );
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return NewsList();
      case 1:
        return ViewSchedule();
      case 2:
        return UserLogin();
      case 3:
        return UserLogin();

      default:
        return MoreScreen();
    }
  }
}
