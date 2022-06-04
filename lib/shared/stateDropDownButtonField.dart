import 'package:flutter/material.dart';
import 'package:helbage/shared/color.dart';
import 'package:helbage/shared/styles.dart';
import 'package:helbage/model/constant/State.dart';

Widget getStateDropDownEnum({onChangeValue, dynamic? value,containerWidth=400.0}) {
  
  double size = 15;
  List<DropdownMenuItem> stateList=getStateList(size:size);
  return Container(
    height: 55.0,
    width: containerWidth,
    child: DropdownButtonFormField(
        value: value,
        isExpanded: true,
        decoration: InputDecoration(
          enabledBorder: inputFieldDefaultBorderStyle,
          focusedBorder: inputFieldFocusedBorderStyle,
        ),
        hint: Text(
          "State",
          style: TextStyle(fontSize: size),
        ),
        items: stateList,
        onChanged: onChangeValue),
  );
}

List<DropdownMenuItem> getStateList({size})
{
  List<DropdownMenuItem> stateList=new List.empty(growable:true);
  MalaysiaState.values.forEach((element) {
    
    stateList.add(
      DropdownMenuItem(
        child: Text(element.getString(),style:TextStyle(fontSize: size)),
        value:element.getString(),),
    );
  });
  
  return stateList;
}

List<PopupMenuItem> getStateListPop({size})
{
  List<PopupMenuItem> stateList=new List.empty(growable:true);
  MalaysiaState.values.forEach((element) {
    
    stateList.add(
      PopupMenuItem(
        child: InkWell(child:Text(element.getString(),style:TextStyle(fontSize: size))),
        value:element.getString(),),
    );
  });
  
  return stateList;
}