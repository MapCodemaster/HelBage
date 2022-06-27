import 'package:flutter/material.dart';
import 'package:helbage/shared/_shared.dart';
import 'package:helbage/view/admin/CollectionPoint/_admin_Collection_Point.dart';
import 'package:helbage/view/admin/Guideline/viewGuidelineView.dart';
import 'package:helbage/view/admin/Schedule/_schedule.dart';
import 'package:helbage/view/admin/noticeboard/_noticeboard.dart';
import 'package:helbage/view/authentication/_authentication.dart';
import 'package:helbage/view/main/_main.dart';
import 'package:stacked/stacked.dart';

class AdminMainScreen extends StatelessWidget {
  final initial;
  const AdminMainScreen({Key? key, this.initial}) : super(key: key);
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainScreenViewModel>.reactive(
        viewModelBuilder: () => MainScreenViewModel(),
        builder: (context, viewModel, child) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              body: getViewForIndex(viewModel.currentIndex),
              bottomNavigationBar: Theme(
                data: Theme.of(context).copyWith(
                    // sets the background color of the `BottomNavigationBar`
                    canvasColor: logoColor,
                    // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                    primaryColor: Colors.white,
                    textTheme: Theme.of(context).textTheme.copyWith(
                        caption: new TextStyle(color: Colors.yellow))),
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
          );
        });
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return NewsList();
      case 1:
        return ViewSchedule(
          isAdmin: true,
        );
      case 2:
        return CollectionList();
      case 3:
        return ViewGuidelineView();

      default:
        return MoreScreen(
          isAdmin: true,
        );
    }
  }
}
