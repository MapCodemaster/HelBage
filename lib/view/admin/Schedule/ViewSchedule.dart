import 'package:helbage/shared/_shared.dart';
import 'package:helbage/view/admin/Schedule/_schedule.dart';

import 'package:stacked/stacked.dart';

class ViewSchedule extends StatefulWidget {
  final isAdmin;
  const ViewSchedule({Key? key, required this.isAdmin}) : super(key: key);

  @override
  State<ViewSchedule> createState() => _viewSchedule();
}

class _viewSchedule extends State<ViewSchedule> {
  String? state;
  String defaultState = "Johor";
  bool _loading = false;
  @override
  void initState() {
    state = null;
  }

  Widget build(BuildContext context) {
    return ViewModelBuilder<viewScheduleViewModel>.reactive(
        viewModelBuilder: () => viewScheduleViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: widget.isAdmin == true
                ? AppBar(
                    leading: Container(),
                    title: Center(child: Text("Schedule")),
                    backgroundColor: logoColor,
                    actions: [
                      IconButton(
                          onPressed: () {
                            model.addSchedule();
                          },
                          icon: Icon(Icons.add)),
                    ],
                  )
                : AppBar(
                    leading: Container(),
                    title: Center(child: Text("Schedule")),
                    backgroundColor: logoColor,
                  ),
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 200,
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: getStateDropDownEnum(
                            onChangeValue: (dynamic value) {
                              setState(() {
                                state = value;
                                model.negeri = state!;
                                model.fetchSchedule();
                              });
                            },
                            value: state)),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _loading = true;
                          });
                          model.fetchSchedule();
                          setState(() {
                            _loading = false;
                          });
                        },
                        icon: Icon(Icons.refresh))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                state == null
                    ? Center()
                    : _loading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Expanded(
                            child:
                                buildBody(model.status, model, widget.isAdmin)),
              ],
            ),
          );
        });
  }
}

Widget buildBody(schedule, model, isAdmin) {
  if (!schedule) {
    return Center(
      child: CircularProgressIndicator(),
    );
  } else {
    if (model.scheduleList.isEmpty) {
      return Container(
          margin: EdgeInsets.only(top: 10),
          child: Center(child: Text("No schedule in database")));
    }

    return SingleChildScrollView(
        child: buildSchedule(model.scheduleList, model, isAdmin));
  }
}

Widget buildSchedule(list, model, isAdmin) {
  List<Widget> scheduleList = new List.empty(growable: true);
  list.forEach((key, element) => {
        scheduleList.add(InkWell(
            onTap: () {
              model.checkPrint(element, isAdmin);
            },
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              width: 300,
              height: 120,
              decoration: BoxDecoration(

                  // Red border with the width is equal to 5
                  border: Border.all(
                width: 1,
                color: Colors.black,
              )),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Container(
                          margin: EdgeInsets.all(5),
                          child: Text("State: " + element.state),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.all(5),
                          child: Text("Path: " + element.pathName)),
                    ),
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(element.getPath().startLocation),
                              Icon(Icons.arrow_forward_outlined),
                              Text(element.getPath().endLocation),
                            ],
                          )),
                    )
                  ]),
            )))
      });
  return Center(child: Column(children: scheduleList));
}
