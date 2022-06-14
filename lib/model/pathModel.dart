import 'package:flutter/material.dart';
import 'package:helbage/model/_model.dart';

class pathModel {
  Time? _startTime;
  Time? _endTime;
  String? vehicle;
  List<dynamic> locationList;
  List<dynamic> durationList;

  String get startTime => startTime.toString();
  String get endTime => _endTime.toString();
  String? get startLocation => locationList.first;
  String? get endLocation => locationList.last;
  List<dynamic> get location_List => locationList;
  List<dynamic> get duration_List => durationList;

  pathModel.fromInput(
      {required String startTimeString,
      required this.locationList,
      required this.durationList,
      required this.vehicle}) {
    _startTime = Time.fromString(timeInString: startTimeString);
    setEndTime();
  }

  pathModel.fromFireStore(
      {required String startTimeString,
      required this.locationList,
      required this.durationList,
      required String endTimeString,
      this.vehicle}) {
    try {
      _startTime = Time.fromString(timeInString: startTimeString);
      setEndTime();
    } catch (e) {
      print(e.toString());
      throw Exception("Data format error (unable to parse String to int)");
    }
  }
  TimeOfDay stringToTime(String time) {
    return new TimeOfDay(
        hour: int.parse(time.split(':')[0]),
        minute: int.parse(time.split(':')[1]));
  }

  @override
  String toString() {
    return vehicle.toString();
  }

  Map<String, dynamic> toFirestore() {
    return {
      "StartTime": _startTime.toString(),
      "EndTime": _endTime.toString(),
      "vehicle": vehicle,
      "locationList": locationList,
      "durationList": dynamicToInt(durationList),
      "vehicle": vehicle,
    };
  }

  //set End Time, called in Constructor;
  void setEndTime() {
    List<int> tempList = dynamicToInt(this.durationList);
    int totalDuration = 0;
    tempList.forEach((element) {
      totalDuration += element;
    });
    totalDuration += _startTime!.minute;
    _endTime = _startTime?.clone();
    _endTime?.addMinute(totalDuration);
  }

  //convert List<dynamic> to List<int>
  List<int> dynamicToInt(List<dynamic> convertList) {
    List<int> tempList = new List.empty(growable: true);
    convertList.forEach((element) {
      try {
        //int.tryParse(element);
        if (element.runtimeType == int) {
          tempList.add(element);
        } else {
          tempList.add(int.parse(element));
        }
      } catch (e) {
        throw Exception(e.toString() + "in dynamicToInt in pathModel");
      }
    });
    return tempList;
  }

  Time? getStartTime() {
    return _startTime;
  }
}
