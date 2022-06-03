import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:helbage/shared/buttons.dart';
import 'package:helbage/shared/inputFields.dart';
import 'package:helbage/view/admin/Schedule/VehicleDialogViewModel.dart';
import 'package:stacked/stacked.dart';

class VehicleDialog extends StatefulWidget {
  final isEdit;
  const VehicleDialog({Key? key, this.isEdit}) : super(key: key);

  @override
  State<VehicleDialog> createState() => _VehicleDialogState();
}

class _VehicleDialogState extends State<VehicleDialog> {
  @override
  String? choosen_plat;
  bool expandedAdd = false;
  bool expandedSelect = false;
  TextEditingController _platNo = TextEditingController();

  Widget build(BuildContext context) {
    String? condition = "Vehicle's condition";
    return ViewModelBuilder<VehicleDialogViewModel>.reactive(
      viewModelBuilder: () => VehicleDialogViewModel(),
      builder: (context, model, child) => SingleChildScrollView(
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Vehicle",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  ExpansionTile(
                    onExpansionChanged: (value) {
                      setState(() {
                        expandedSelect = value;
                      });
                    },
                    childrenPadding: EdgeInsets.all(15),
                    leading: Icon(Icons.touch_app),
                    title: Text("Choose a vehicle"),
                    children: [
                      ListView.builder(
                          physics: ClampingScrollPhysics(),
                          itemCount: model.vList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            // return Text(model.vList[index].platNo);
                            return RadioListTile(
                                secondary: IconButton(
                                    onPressed: () {
                                      model.deleteVehicle(
                                          model.vList[index].platNo);
                                    },
                                    icon: Icon(Icons.delete)),
                                title: Text(model.vList[index].platNo),
                                value: model.vList[index].platNo,
                                groupValue: choosen_plat,
                                onChanged: (String? value) {
                                  setState(() {
                                    choosen_plat = value;
                                  });
                                });
                          }),
                    ],
                  ),
                  ExpansionTile(
                    onExpansionChanged: (value) {
                      setState(() {
                        expandedAdd = value;
                      });
                    },
                    childrenPadding: EdgeInsets.all(15),
                    leading: Icon(Icons.add),
                    title: Text("Add new vehicle"),
                    children: [
                      TextFormField(
                        controller: _platNo,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: "Vehicle's plate number"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          txtButton("Add", () {
                            model.addVehicle(_platNo);
                          }, Color.fromARGB(255, 19, 92, 218), 130, 30,
                              TextStyle(color: Colors.white),
                              radius: 0),
                          txtButton("Reset", () {
                            setState(() {
                              _platNo.clear();
                            });
                          }, Colors.red, 130, 30,
                              TextStyle(color: Colors.white),
                              radius: 0),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  expandedAdd
                      ? Center()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            txtButton("Assign", () {
                              model.navigateAssign(choosen_plat);
                            }, Color(0xFF1BC0C5), 130, 50,
                                TextStyle(color: Colors.white),
                                radius: 0),
                            txtButton("Cancel", () {
                              model.navigatePop();
                            }, Colors.red, 130, 50,
                                TextStyle(color: Colors.white),
                                radius: 0),
                          ],
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
