import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'package:helbage/shared/_shared.dart';
import 'package:helbage/view/admin/Schedule/_schedule.dart';
import 'package:helbage/view/resident/schedule/_schedule.dart';

import 'package:stacked/stacked.dart';

class SingleScheduleView extends StatefulWidget {
  dynamic value;
  final isAdmin;
  SingleScheduleView({Key? key, required this.value, required this.isAdmin})
      : super(key: key);
  @override
  State<SingleScheduleView> createState() => _SingleScheduleView();
}

class _SingleScheduleView extends State<SingleScheduleView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SingleScheduleViewModel>.nonReactive(
        viewModelBuilder: () => SingleScheduleViewModel(),
        builder: (context, model, child) {
          print(model.reminder.status);
          return Scaffold(
              appBar: widget.isAdmin == null || widget.isAdmin == true
                  ? AppBar(
                      backgroundColor: logoColor,
                      title: Text(widget.value.pathName),
                      actions: [
                        IconButton(
                            onPressed: () {
                              model.delete(widget.value);
                            },
                            icon: Icon(Icons.delete)),
                        IconButton(
                            onPressed: () {
                              model.edit(widget.value);
                            },
                            icon: Icon(Icons.edit))
                      ],
                    )
                  : AppBar(
                      backgroundColor: logoColor,
                      title: Text(widget.value.pathName),
                      actions: [
                        IconButton(
                            onPressed: () async {
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ScheduleReminderDialog(
                                      reminder: model.reminder,
                                      schedule: widget.value,
                                    );
                                  });
                              setState(() {});
                            },
                            icon: Icon(Icons.notifications))
                      ],
                    ),
              body: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //upper part(Path Info)
                    Row(
                      children: [
                        Image.asset('assets/images/cover.png',
                            width: MediaQuery.of(context).size.height / 4,
                            height: MediaQuery.of(context).size.height / 4),
                        Expanded(
                            child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              child: Text(widget.value.pathName +
                                  " (Vehicle: " +
                                  widget.value.getPath().vehicle +
                                  ")"),
                            ),
                            Container(
                                margin: EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(widget.value.getPath().startLocation),
                                    Icon(Icons.arrow_forward_outlined),
                                    Text(widget.value.getPath().endLocation),
                                  ],
                                )),
                          ],
                        )),
                      ],
                    ),

                    //End of upper part

                    //Bottom Part (Locations)
                    SingleChildScrollView(
                        child: Container(
                            margin: EdgeInsets.all(40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: buildPathList(
                                  widget.value.getPath().location_List,
                                  widget.value.getPath().duration_List),
                            )))
                  ],
                ),
              ));
        });
  }
}

List<Widget> buildPathList(locationList, durationList) {
  List<Widget> tempPathList = new List.empty(growable: true);
  //build header
  tempPathList.add(Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(margin: EdgeInsets.only(top: 10), child: Text("Location")),
      Container(child: Text("Expected Time (minute)"))
    ],
  ));
  for (int i = 0; i < locationList.length; i++) {
    tempPathList.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            margin: EdgeInsets.only(top: 10), child: Text(locationList[i])),
        Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(durationList[i].toString()))
      ],
    ));
  }
  return tempPathList;
}
