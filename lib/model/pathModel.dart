import 'package:flutter/material.dart';
class pathModel
{
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String? vehicle;
  List<dynamic> locationList;
  List<dynamic> durationList;
  //Map<String,dynamic>? locationList;
  String? _startLocation;
  String? _endLocation;
  /*pathModel({required String startTimeString,required Map<String,dynamic> locList,this.vehicle})
  {
    try{
      startTime=stringToTime(startTimeString);
    }catch(e)
    {
      throw Exception("Data format error (unable to parse String to int)");
    }
    
  }*/
  pathModel.fromInput(
    {required String startTime,
    required this.locationList,
    required this.durationList,
    this.vehicle="undefined"}
  );
  
  pathModel.fromFireStore(
    {required String startTimeString,
    required this.locationList,
    required this.durationList,
    required String endTimeString,
    this.vehicle})
    {
      try{
      startTime=stringToTime(startTimeString);
      endTime=stringToTime(endTimeString);
      _startLocation=locationList.first;
      _endLocation=locationList.last;
    }catch(e)
    {
      print(e.toString());
      throw Exception("Data format error (unable to parse String to int)");
    }
    }
    TimeOfDay stringToTime(String time)
    {
      return new TimeOfDay(hour:int.parse(time.split(':')[0]), minute: int.parse(time.split(':')[0]));
    }
    @override
    String toString()
    {
      return vehicle.toString();
    }
  Map<String, dynamic> toFirestore() {
    return {
      "StartTime": startTime.toString(),
      "EndTime": endTime.toString(),
      "vehicle": startTime.toString(),
      "locationList": locationList,
      "durationList":durationList,
      "vehicle":vehicle,
      };
    }
    

  String getStartTime()
  {
    return (startTime?.hour).toString()+":"+(startTime?.minute).toString();
  }
  List getLocationList()
  {
    return locationList;
  }
  List getDurationList()
  {
    return durationList;
  }
  String getVehicle()
  {
    return "JKA 1234";
  }
  String? get startLocation=>_startLocation;
  String? get endLocation=>_endLocation;
}