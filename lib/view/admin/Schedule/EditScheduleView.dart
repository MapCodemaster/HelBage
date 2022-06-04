import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:helbage/model/scheduleModel.dart';
import 'package:helbage/shared/color.dart';
import 'package:helbage/shared/stateDropDownButtonField.dart';
import 'package:helbage/shared/textInputForm.dart';
import 'package:helbage/shared/validation.dart';
import 'package:helbage/view/admin/Schedule/EditScheduleViewModel.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
class EditScheduleView extends StatefulWidget
{
  scheduleModel schedule;
   EditScheduleView({Key? key,required this.schedule}):super(key: key);

  @override
  State<EditScheduleView> createState()=>_EditScheduleView();
}

class _EditScheduleView extends State<EditScheduleView>
{
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String state="Johor";
  String? time;
  String? vehicle;
  final timeFormat=DateFormat("HH:mm");
  Validation validate = Validation();
  TextEditingController _cityField = TextEditingController();
  TextEditingController _timeField = TextEditingController();
  TextEditingController _vehicleField = TextEditingController();
  @override
  Widget build(BuildContext context)
  {
    
    state=widget.schedule.state;
    _cityField=TextEditingController(text:widget.schedule.pathName);
    _timeField=TextEditingController(text: widget.schedule.getPath().getStartTime().toString());
    _timeField.value=TextEditingValue(text: widget.schedule.getPath().getStartTime().toString());
    _vehicleField=TextEditingController(text:widget.schedule.getPath().vehicle);
    String startTime=widget.schedule.getPath().getStartTime().toString();
    int initialHour=int.parse(startTime.split(':')[0]);
    int initialMinute=int.parse(startTime.split(':')[1]);
    return ViewModelBuilder<EditScheduleViewModel>.reactive(
      viewModelBuilder:()=> EditScheduleViewModel(originalschedule:widget.schedule), 
      builder: (context,model,child)=>Scaffold(
          appBar: AppBar(
            backgroundColor: logoColor,
            leading:Container(child:IconButton(icon:Icon(Icons.arrow_back),onPressed: (){model.quit();})),
            title:Text(widget.schedule.pathName),
            actions:[
              IconButton(onPressed: (){model.create(state,_cityField.text,_formkey,_timeField);}, 
              icon: Icon(Icons.save),)
            ]
          ),
          body:SingleChildScrollView(
            child:Form(
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
                      onChangeValue: (dynamic? value) => {state = value},
                      value: widget.schedule.state)),
                      TextinputForm(
                "Path",Colors.black,Colors.white,_cityField,
                validator: validate.validateForEmpty,
                inputype: TextInputType.text,
              ),
                      TextinputForm(
                "Vehicle",Colors.black,Colors.white,_vehicleField,
                validator: validate.validateForEmpty,
                inputype: TextInputType.text,
              ),
              Container(
                
                width: MediaQuery.of(context).size.width -
                      MediaQuery.of(context).size.width / 5,
                child: 
                Column(
                  
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: 
                  [
                    Text("Start Time: "),
                    Container( 
                      decoration:BoxDecoration(border: Border.all()),
                      width: MediaQuery.of(context).size.width -
                      MediaQuery.of(context).size.width / 1.5,
                      
                      child:
                    DateTimeField(
                      initialValue:DateTimeField.convert(TimeOfDay(hour: initialHour,minute: initialMinute)) ,
                      controller: _timeField,
                      
                        validator: validate.validateDateTime,
                        format: timeFormat,
                        onShowPicker: (context, currentValue) async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay(hour: 8,minute: 0),
                          );
                          
                          return DateTimeField.convert(time);
                        })),
                      
                  ]),
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
                    FlatButton(onPressed:()=>{model.addNewRow("", 0)}, child: Text("Add New Row")),
                    FlatButton(onPressed:()=>{model.deleteLastRow()}, child: Text("Delete Last Row")),
                    
              
              
              
            ])))))
      );
  }
}


