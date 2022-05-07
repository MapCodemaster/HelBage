import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helbage/shared/styles.dart';
import 'package:helbage/shared/color.dart';
import 'package:helbage/shared/buttons.dart';
import 'package:helbage/view/authentication/UserLogin.dart';
import 'package:helbage/view/authentication/UserRegister.dart';
import 'package:stacked/stacked.dart';
import 'package:helbage/viewmodel/MainScreenViewModel.dart';

class AdminMainScreen extends StatelessWidget {
  const AdminMainScreen({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainScreenViewModel>.reactive(
      builder: (context, viewModel, child) => Scaffold(
        body: getViewForIndex(viewModel.currentIndex),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
              canvasColor: primaryColor,
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
                  icon: Icon(Icons.recycling), label: "Recycling\nGuidelines"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Setting"),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => MainScreenViewModel(),
    );
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return UserRegister();
      case 1:
        return UserLogin();
      case 2:
        return UserLogin();
      case 3:
        return UserLogin();
      case 4:
        return UserLogin();
      default:
        return UserLogin();
    }
  }
}
