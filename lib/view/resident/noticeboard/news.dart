import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:helbage/model/newsModel.dart';
import 'package:helbage/view/resident/noticeboard/linkpreview.dart';
import 'package:helbage/viewmodel/resident/noticeboard/newsViewModel.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewsViewModel>.reactive(
        viewModelBuilder: (() => NewsViewModel()),
        builder: (context, model, child) {
          if (model.dataReady) {
            model.data!.sort(
              (b, a) => a.dt.compareTo(b.dt),
            );

            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: ListView.builder(
                  itemCount: model.data?.length,
                  itemBuilder: ((context, index) {
                    return LinkPreview(
                        link: model.data![index].url,
                        date: DateFormat('yyyy-MM-dd kk:mm')
                            .format(model.data![index].dt)
                            .toString(),
                        onTap: () {
                          model.launch(model.data![index].url);
                        });
                  })),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
