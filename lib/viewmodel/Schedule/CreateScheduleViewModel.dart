import 'package:flutter/material.dart';
import 'package:helbage/app/route.locator.dart';
import 'package:helbage/services/FirebaseServices/auth_service.dart';
import 'package:helbage/services/FirebaseServices/storage_service.dart';
import 'package:helbage/shared/textInputForm.dart';
import 'package:helbage/shared/validation.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CreateScheduleViewModel extends BaseViewModel
{
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final auth = locator<AuthService>();
  final stor = locator<storage_service>();
  //List<List<Row>> dataList=List.generate(2, (i) => List.empty(growable: true), growable: false);
  List<Row> InputList=new List.empty(growable: true);
  List<List<TextEditingController>> ControllerList=List.generate(2, (index) =>List.empty(growable: true));
  Validation validate = Validation();
  CreateScheduleViewModel()
  {
    addNewRow();
  }

  void addNewRow()
  {
    ControllerList.add([TextEditingController(),TextEditingController()]);
    InputList.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
        TextinputForm(
                "Location",
                Colors.black,
                Colors.white,
                ControllerList.last[0],
                validator: validate.validateForEmpty,
                inputype: TextInputType.text,
                widthRatio: 1.5,
              ),
              TextinputForm(
                "Duration",
                Colors.black,
                Colors.white,
                ControllerList.last[1],
                validator: validate.validateForEmpty,
                inputype: TextInputType.text,
                widthRatio: 1.5,
              ),
              ])
              );
    /*ControllerList.add(TextEditingController());
    InputList.add(
      TextinputForm(
                "City",
                Colors.black,
                Colors.white,
                ControllerList.last,
                validator: validate.validateForEmpty,
                inputype: TextInputType.text,
              )
    );*/
    notifyListeners();
  }
  void check()
  {
    ControllerList.forEach((element) {element.forEach((element) {print(element.text);});});
  }
}