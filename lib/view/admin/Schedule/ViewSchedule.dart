import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helbage/model/scheduleModel.dart';
import 'package:helbage/shared/color.dart';
import 'package:helbage/shared/dropdownbuttonfield.dart';
import 'package:helbage/shared/stateDropDownButtonField.dart';
import 'package:helbage/view/admin/Schedule/CreateSchedule.dart';
import 'package:helbage/view/admin/Schedule/ViewScheduleViewModel.dart';
import 'package:helbage/view/authentication/UserLogin.dart';
import 'package:helbage/view/main/MoreScreen.dart';
import 'package:helbage/view/resident/noticeboard/noticeboard.dart';
import 'package:stacked/stacked.dart';

class ViewSchedule extends StatefulWidget {
  final showAdd;
  const ViewSchedule({Key? key, this.showAdd}) : super(key: key);

  @override
  State<ViewSchedule> createState() => _viewSchedule();
}
class _viewSchedule extends State<ViewSchedule>
{
  int index=2;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<viewScheduleViewModel>.reactive(
      viewModelBuilder: ()=>viewScheduleViewModel(), 
      builder: (context,model,child)=>Scaffold(
          appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: model.toMain,),
            title:Center(child: Text("Schedule")),
            backgroundColor: logoColor,
            actions: [
              
              IconButton(onPressed: (){model.addSchedule();}, icon: Icon(Icons.add)),
              PopupMenuButton(itemBuilder: (BuildContext context) {
                return getStateListPop();},onSelected: (vale){model.ChangeBody(vale);},),
            ],
          ),

          body:SingleChildScrollView(child: buildBody(model.status,model)),
      ));
  }
}

Widget buildBody(schedule, model) {
  if (!schedule) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Center(child: Text("loading schedule for "+model.state)));
  } else {
    if (model.scheduleList.isEmpty) {
      return Container(
          margin: EdgeInsets.only(top: 10),
          child: Center(child: Text("No schedule in database for "+model.state)));
    }
    model.scheduleList.forEach((key, value) {});
    return buildSchedule(model.scheduleList, model);
  }
}

Widget buildSchedule(list, model) {
  List<Widget> scheduleList = new List.empty(growable: true);
  list.forEach((key, element) => {
        scheduleList.add(InkWell(
            onTap: () {
              model.checkPrint(element);
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
                    InkWell(
                      child: Container(
                        margin: EdgeInsets.all(5),
                        child: Text("State: " + element.pathName),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.all(5),
                        child: Text("Path: " + element.pathName)),
                    Container(
                        margin: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(element.getPath().startLocation),
                            Icon(Icons.arrow_forward_outlined),
                            Text(element.getPath().endLocation),
                          ],
                        ))
                  ]),
            )))
      });
  return Center(child: Column(children: scheduleList));
}
