import 'package:flutter/material.dart';
import 'package:helbage/view/resident/noticeboard/_resident_Noticeboard.dart';

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
                    return ListTile(
                      minVerticalPadding: 0,
                      dense: true,
                      contentPadding: EdgeInsets.all(0),
                      horizontalTitleGap: 0,
                      trailing: IconButton(
                          onPressed: () {
                            model.share(model.data![index].url);
                          },
                          icon: Icon(Icons.share)),
                      title: LinkPreview(
                          link: model.data![index].url,
                          date: DateFormat('yyyy-MM-dd kk:mm')
                              .format(model.data![index].dt)
                              .toString(),
                          onTap: () {
                            model.launch(model.data![index].url);
                          }),
                    );
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
