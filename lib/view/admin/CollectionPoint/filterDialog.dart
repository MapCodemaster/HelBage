import 'package:flutter/material.dart';
import 'package:helbage/constant/_constant.dart';
import 'package:helbage/shared/_shared.dart';

import 'package:helbage/view/admin/CollectionPoint/_admin_Collection_Point.dart';
import 'package:stacked/stacked.dart';

class FilterDiaolog extends StatefulWidget {
  final option;
  const FilterDiaolog({Key? key, required this.option}) : super(key: key);

  @override
  State<FilterDiaolog> createState() => _FilterDiaologState();
}

class _FilterDiaologState extends State<FilterDiaolog> {
  List<String> state = [];
  String? option;
  @override
  void initState() {
    option = widget.option;
    state.clear();
    state.add("All");
    MalaysiaState.values.forEach((element) {
      state.add(element.getString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FilterDialogViewModel>.nonReactive(
        viewModelBuilder: () => FilterDialogViewModel(),
        builder: (context, model, child) {
          return Dialog(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.length,
                      itemBuilder: (context, index) {
                        return RadioListTile(
                            title: Text(state[index]),
                            value: state[index],
                            groupValue: option,
                            onChanged: (String? value) {
                              setState(() {
                                option = value;
                              });
                            });
                      }),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        txtButton("Cancel", () {
                          model.pop();
                        }, Colors.red, 130, 50, TextStyle(color: Colors.white),
                            radius: 0),
                        txtButton("Filter", () {
                          model.filter(option);
                        }, Color(0xFF1BC0C5), 130, 50,
                            TextStyle(color: Colors.white),
                            radius: 0),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
