import 'package:flutter/material.dart';
import 'package:helbage/shared/_shared.dart';
import 'package:helbage/view/admin/noticeboard/_noticeboard.dart';
import 'package:helbage/view/resident/noticeboard/_resident_Noticeboard.dart';
import 'package:stacked/stacked.dart';

import 'package:intl/intl.dart';

class NewsList extends StatefulWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewsListViewModel>.reactive(
        viewModelBuilder: (() => NewsListViewModel()),
        builder: (context, model, child) {
          if (model.dataReady) {
            // model.data!.sort(
            //   (b, a) => a.dt.compareTo(b.dt),
            // );

            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: logoColor,
                leading: SizedBox(),
                // On Android it's false by default
                centerTitle: true,
                title: Text("Manage Noticeboard"),
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                backgroundColor: logoColor,
                onPressed: () {
                  model.navigateToNewsInsert();
                },
              ),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: ListView.builder(
                    itemCount: model.data?.length,
                    itemBuilder: ((context, index) {
                      return InkWell(
                        onLongPress: () {
                          model.navigateToNewsEdit(model.data![index]);
                        },
                        child: LinkPreview(
                            link: model.data![index].url,
                            date: DateFormat('yyyy-MM-dd kk:mm')
                                .format(model.data![index].dt)
                                .toString(),
                            onTap: () {
                              model.navigateToNewsEdit(model.data![index]);
                            }),
                      );
                    })),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
