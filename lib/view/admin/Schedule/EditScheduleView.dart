import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:helbage/model/scheduleModel.dart';
import 'package:helbage/shared/buttons.dart';
import 'package:helbage/shared/color.dart';
import 'package:helbage/shared/stateDropDownButtonField.dart';
import 'package:helbage/shared/textInputForm.dart';
import 'package:helbage/shared/validation.dart';
import 'package:helbage/view/admin/Schedule/EditScheduleViewModel.dart';
import 'package:helbage/view/admin/Schedule/VehicleDialog.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class EditScheduleView extends StatefulWidget {
  scheduleModel schedule;
  EditScheduleView({Key? key, required this.schedule}) : super(key: key);

  @override
  State<EditScheduleView> createState() => _EditScheduleView();
}

class _EditScheduleView extends State<EditScheduleView> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String? state;
  String? time;
  late String vehicle;
  final timeFormat = DateFormat("HH:mm");

  Validation validate = Validation();
  TextEditingController _cityField = TextEditingController();
  TextEditingController _timeField = TextEditingController();
  TextEditingController _vehicleField = TextEditingController();
  var platno;
  @override
  Widget build(BuildContext context) {
    _cityField = TextEditingController(text: widget.schedule.pathName);
    _timeField = TextEditingController(
        text: widget.schedule.getPath().getStartTime().toString());
    _timeField.value = TextEditingValue(
        text: widget.schedule.getPath().getStartTime().toString());
    _vehicleField =
        TextEditingController(text: widget.schedule.getPath().vehicle);
    String startTime = widget.schedule.getPath().getStartTime().toString();
    int initialHour = int.parse(startTime.split(':')[0]);
    int initialMinute = int.parse(startTime.split(':')[1]);
    return ViewModelBuilder<EditScheduleViewModel>.reactive(
        viewModelBuilder: () => EditScheduleViewModel(
            oriLocationList: widget.schedule.getPath().locationList,
            oriDurationList: widget.schedule.getPath().durationList,
            originalschedule: widget.schedule),
        builder: (context, model, child) {
          if (widget.schedule.getPath().vehicle == null) {
            vehicle == "";
          } else {
            vehicle = widget.schedule.getPath().vehicle!;
          }
          if (!model.setup) {
            for (int i = 0; i < model.oriLocationList.length; i++) {
              addNewRow(
                  model.oriLocationList[i], model.oriDurationList[i], model);
            }
            model.setup = true;
          }
          return Scaffold(
              appBar: AppBar(
                  backgroundColor: logoColor,
                  // leading: Container(
                  //     child: IconButton(
                  //         icon: Icon(Icons.arrow_back),
                  //         onPressed: () {
                  //           model.quit();
                  //         })),
                  title: Text(widget.schedule.pathName),
                  actions: [
                    IconButton(
                      onPressed: () {
                        model.create(
                            state ?? widget.schedule.state,
                            _cityField.text,
                            _formkey,
                            _timeField,
                            platno == null ? vehicle : platno);
                      },
                      icon: Icon(Icons.save),
                    )
                  ]),
              body: SingleChildScrollView(
                  child: Form(
                      key: _formkey,
                      child: Center(
                          child: Column(children: [
                        Column(
                          children: [
                            Container(
                                padding: EdgeInsets.only(top: 30),
                                width: MediaQuery.of(context).size.width -
                                    MediaQuery.of(context).size.width / 5,
                                child: Center(child: Text("Edit Schedule"))),
                            Container(
                                padding: EdgeInsets.only(top: 10),
                                width: MediaQuery.of(context).size.width -
                                    MediaQuery.of(context).size.width / 5,
                                child: getStateDropDownEnum(
                                    onChangeValue: (dynamic value) =>
                                        {state = value.toString()},
                                    value: widget.schedule.state)),
                            TextinputForm(
                              "Path",
                              Colors.black,
                              Colors.white,
                              _cityField,
                              validator: validate.validateForEmpty,
                              inputype: TextInputType.text,
                              readonly: false,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width -
                                  MediaQuery.of(context).size.width / 5,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Start Time: "),
                                    Container(
                                        decoration:
                                            BoxDecoration(border: Border.all()),
                                        width: MediaQuery.of(context)
                                                .size
                                                .width -
                                            MediaQuery.of(context).size.width /
                                                1.5,
                                        child: DateTimeField(
                                            initialValue: DateTimeField.convert(
                                                TimeOfDay(
                                                    hour: initialHour,
                                                    minute: initialMinute)),
                                            controller: _timeField,
                                            validator:
                                                validate.validateDateTime,
                                            format: timeFormat,
                                            onShowPicker:
                                                (context, currentValue) async {
                                              final time = await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay(
                                                    hour: 8, minute: 0),
                                              );

                                              return DateTimeField.convert(
                                                  time);
                                            })),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 10, 5, 0),
                                          child: txtButton("Assign Vehicle",
                                              () async {
                                            platno = await showDialog<String>(
                                                context: context,
                                                builder: (context) =>
                                                    VehicleDialog());
                                            setState(() {});
                                          }, Colors.green, 130, 50, TextStyle(),
                                              radius: 0),
                                        ),
                                        platno == null
                                            ? Center()
                                            : Text(platno + " is selected")
                                      ],
                                    )
                                  ]),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              width: MediaQuery.of(context).size.width -
                                  MediaQuery.of(context).size.width / 5,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Location'),
                                  Text('Duration  (in minute)')
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          child: Column(
                            children: model.InputList,
                          ),
                        ),
                        TextButton(
                            onPressed: () => {addNewRow("", 0, model)},
                            child: Text("Add New Row")),
                        TextButton(
                            onPressed: () => {model.deleteLastRow()},
                            child: Text("Delete Last Row")),
                      ])))));
        });
  }

  void addNewRow(location, duration, model) {
    model.ControllerList.add([
      TextEditingController(text: location),
      TextEditingController(text: duration.toString())
    ]);
    model.InputList.add(
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      TextinputForm(
        "Location",
        Colors.black,
        Colors.white,
        model.ControllerList.last[0],
        validator: validate.validateForEmpty,
        inputype: TextInputType.text,
        widthRatio: 1.5,
        readonly: false,
      ),
      TextinputForm(
        "Duration",
        Colors.black,
        Colors.white,
        model.ControllerList.last[1],
        validator: validate.validateNumOnly,
        inputype: TextInputType.text,
        widthRatio: 1.5,
        readonly: false,
      ),
    ]));

    model.notifyListeners();
  }
}
