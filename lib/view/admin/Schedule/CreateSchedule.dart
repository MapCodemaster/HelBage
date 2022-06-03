import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:helbage/model/constant/State.dart';
import 'package:helbage/shared/buttons.dart';
import 'package:helbage/shared/color.dart';
import 'package:helbage/shared/stateDropDownButtonField.dart';
import 'package:helbage/shared/textInputForm.dart';
import 'package:helbage/shared/validation.dart';
import 'package:helbage/view/admin/Schedule/CreateScheduleViewModel.dart';
import 'package:helbage/view/admin/Schedule/VehicleDialog.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class CreateSchedule extends StatefulWidget {
  const CreateSchedule({Key? key}) : super(key: key);
  @override
  State<CreateSchedule> createState() => _CreateSchedule();
}

class _CreateSchedule extends State<CreateSchedule> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String? state;
  String? time;
  final timeFormat = DateFormat("HH:mm");
  Validation validate = Validation();
  TextEditingController _cityField = TextEditingController();
  TextEditingController _timeField = TextEditingController();
  var platno;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateScheduleViewModel>.reactive(
        viewModelBuilder: () => CreateScheduleViewModel(),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: logoColor,
              // leading:Container(child:IconButton(icon:Icon(Icons.arrow_back),onPressed: (){model.quit();})),
              title: Text("Create New Schedule"),
              actions: [],
            ),
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
                              child: Center(child: Text("Create Schedule"))),
                          Container(
                              padding: EdgeInsets.only(top: 10),
                              width: MediaQuery.of(context).size.width -
                                  MediaQuery.of(context).size.width / 5,
                              child: getStateDropDownEnum(
                                  onChangeValue: (dynamic? value) {
                                    state = value;
                                  },
                                  value: state)),
                          TextinputForm(
                            "Path",
                            Colors.black,
                            Colors.white,
                            _cityField,
                            validator: validate.validateForEmpty,
                            inputype: TextInputType.text,
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
                                      width: MediaQuery.of(context).size.width -
                                          MediaQuery.of(context).size.width /
                                              1.5,
                                      child: DateTimeField(
                                          controller: _timeField,
                                          validator: validate.validateDateTime,
                                          format: timeFormat,
                                          onShowPicker:
                                              (context, currentValue) async {
                                            final time = await showTimePicker(
                                              context: context,
                                              initialTime:
                                                  TimeOfDay(hour: 8, minute: 0),
                                            );

                                            return DateTimeField.convert(time);
                                          })),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 10, 5, 10),
                                        child: txtButton("Assign Vehicle",
                                            () async {
                                          platno = await showDialog<String>(
                                              context: context,
                                              builder: (context) =>
                                                  VehicleDialog());
                                          setState(() {});
                                        }, Colors.green, 140, 50, TextStyle(),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          onPressed: () => {model.addNewRow()},
                          child: Text("Add New Row")),
                      TextButton(
                          onPressed: () => {model.deleteLastRow()},
                          child: Text("Delete Last Row")),
                      TextButton(
                          onPressed: () => {
                                model.create(state, _cityField.text, _formkey,
                                    _timeField, platno)
                              },
                          child: Text("Create")),
                    ]))))));
  }
}
