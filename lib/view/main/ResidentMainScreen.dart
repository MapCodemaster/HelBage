import 'package:helbage/shared/_shared.dart';
import 'package:helbage/view/admin/Schedule/_schedule.dart';
import 'package:helbage/view/authentication/_authentication.dart';
import 'package:helbage/view/main/_main.dart';
import 'package:helbage/view/resident/CollectionPoint/_resident_Collection_Point.dart';
import 'package:helbage/view/resident/Guideline/viewGuideline.dart';
import 'package:helbage/view/resident/noticeboard/_resident_Noticeboard.dart';
import 'package:stacked/stacked.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class ResidentMainScreen extends StatelessWidget {
  void initState() {}

  Widget build(BuildContext context) {
    return ViewModelBuilder<MainScreenViewModel>.reactive(
      fireOnModelReadyOnce: true,
      onModelReady: (model) {
        model.initializeNotification();
      },
      builder: (context, viewModel, child) {
        // viewModel.initializeNotification();

        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            // appBar: AppBar(
            //   leading: IconButton(
            //       onPressed: () {
            //         viewModel.currentpath();
            //       },
            //       icon: Icon(Icons.abc)),
            // ),
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
        );
      },
      viewModelBuilder: () => MainScreenViewModel(),
    );
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return NoticeBoard();
      case 1:
        return ViewSchedule(
          isAdmin: false,
        );
      case 2:
        return CollectionPointScreen();
      case 3:
        return ViewGuideline();
      default:
        return MoreScreen(
          isAdmin: false,
        );
    }
  }
}
