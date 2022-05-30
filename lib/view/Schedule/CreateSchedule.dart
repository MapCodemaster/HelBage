import 'package:flutter/material.dart';
import 'package:helbage/model/constant/State.dart';
import 'package:helbage/shared/buttons.dart';
import 'package:helbage/shared/stateDropDownButtonField.dart';
import 'package:helbage/shared/textInputForm.dart';
import 'package:helbage/shared/validation.dart';
import 'package:stacked/stacked.dart';
import 'package:helbage/viewmodel/Schedule/CreateScheduleViewModel.dart';

class CreateSchedule extends StatefulWidget {
  const CreateSchedule({Key? key}) : super(key: key);
  @override
  State<CreateSchedule> createState() => _CreateSchedule();
}

class _CreateSchedule extends State<CreateSchedule> {
  String? state;
  Validation validate = Validation();
  TextEditingController _cityField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateScheduleViewModel>.reactive(
        viewModelBuilder: () => CreateScheduleViewModel(),
        builder: (context, model, child) => SingleChildScrollView(
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
                      onChangeValue: (dynamic? value) => {state = value},
                      value: state)),
                      TextinputForm(
                "City",Colors.black,Colors.white,_cityField,
                validator: validate.validateForEmpty,
                inputype: TextInputType.text,
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width -
                      MediaQuery.of(context).size.width / 5,
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text('Location' ),
                Text('Duration  (in minute)')
              ],),
              )
              
              
                    ],),
                    Container(
                        child:Column(
                      children: model.InputList,
                    ),),
                    FlatButton(onPressed:()=>{model.addNewRow()}, child: Text("Add New Row")),
                    FlatButton(onPressed:()=>{model.check()}, child: Text("Create")),
              
              
              
            ]))));
  }
}


