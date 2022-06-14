import 'package:flutter/material.dart';
import 'package:helbage/model/_model.dart';
import 'package:helbage/shared/_shared.dart';

import 'package:helbage/view/admin/CollectionPoint/_admin_Collection_Point.dart';
import 'package:stacked/stacked.dart';

class CollectionList extends StatefulWidget {
  const CollectionList({Key? key}) : super(key: key);

  @override
  State<CollectionList> createState() => _CollectionListState();
}

class _CollectionListState extends State<CollectionList> {
  String? _option = "All";
  List<CollectionPointModel>? list = [];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CollectionPointListViewModel>.reactive(
        viewModelBuilder: () => CollectionPointListViewModel(),
        builder: (context, model, child) {
          if (!model.dataReady) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            model.data!.sort((a, b) =>
                a.title.toLowerCase().compareTo(b.title.toLowerCase()));
            if (_option == "All") {
              list = model.data;
            } else {
              list = model.data!.where((e) {
                return e.state == _option;
              }).toList();
            }

            return Scaffold(
              appBar: AppBar(
                title: Text("Bulky Waste Collection Point"),
                backgroundColor: logoColor,
                automaticallyImplyLeading: false,
                centerTitle: true,
                actions: [
                  IconButton(
                      onPressed: () async {
                        _option = await showDialog<String>(
                            context: context,
                            builder: (context) {
                              return FilterDiaolog(
                                option: _option,
                              );
                            });

                        setState(() {});
                      },
                      icon: Icon(Icons.filter_alt))
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  model.NavigateToCreatePoint();
                },
                child: Icon(Icons.add),
                backgroundColor: logoColor,
              ),
              body: list!.isEmpty
                  ? Center(
                      child:
                          Text("There is no bulky waste collection points yet"),
                    )
                  : SingleChildScrollView(child: pointList(model)),
            );
          }
        });
  }

  Padding pointList(CollectionPointListViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: list!.length,
          itemBuilder: ((context, index) {
            return InkWell(
              onTap: () {
                model.NavigateToEditPoint(list![index]);
              },
              child: Card(
                child: ListTile(
                  subtitle: Text(list![index].address),
                  title: Text(list![index].title),
                  trailing: IconButton(
                      onPressed: () {
                        model.deletePoint(list![index].id);
                      },
                      icon: Icon(Icons.delete)),
                ),
              ),
            );
          })),
    );
  }
}
