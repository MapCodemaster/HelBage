import 'dart:math';

import 'package:helbage/shared/_shared.dart';
import 'package:helbage/view/admin/Guideline/viewGuidelineViewModel.dart';
import 'package:helbage/view/resident/Guideline/viewGuidelineModel.dart';
import 'package:stacked/stacked.dart';

class ViewGuideline extends StatefulWidget {
  const ViewGuideline({Key? key}) : super(key: key);

  @override
  State<ViewGuideline> createState() => _ViewGuidelineState();
}

class _ViewGuidelineState extends State<ViewGuideline> {
  String? tag;
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewGuidelineModel>.reactive(
        viewModelBuilder: () => ViewGuidelineModel(),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: logoColor,
              title: Text("Guidelines"),
              leading: model.selected == true
                  ? IconButton(
                      onPressed: () {
                        model.clearSelected();
                      },
                      icon: Icon(Icons.arrow_back))
                  : Container(),
              actions: [
                IconButton(
                    onPressed: () {
                      model.navigateToAdd();
                    },
                    icon: Icon(Icons.add))
              ],
            ),
            body: buildBody(model.status, model)));
  }
}

List<Color?> randColor = [
  Colors.amber[200],
  Colors.blue[100],
  Colors.tealAccent[200],
  Colors.purple[200],
  Colors.pink[100]
];

List<Widget> getGuidelinetagWidget(model,
    {size = 15.0, widthSize = 20.0, heightSize = 20.0, radius = 50.0}) {
  List<Widget> tagContainer = new List.empty(growable: true);
  model.tagList.forEach((element) {
    Color? c = randColor[new Random().nextInt(randColor.length)];
    if (c == null) {
      c = Colors.purple[200];
    }

    tagContainer.add(
      Card(
        child: InkWell(
          onTap: () {
            model.getGuideline(element.toString());
            model.selected = true;
          },
          splashColor: Colors.green,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Text(
                element.toString() + "(" + element.quantity.toString() + ")",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: size, color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  });
  return tagContainer;
}

Widget buildBody(status, model) {
  if (!model.selected) {
    return SingleChildScrollView(
      child: Column(
        children: getGuidelinetagWidget(model),
      ),
    )
        // return Center(
        //     heightFactor: 1.0,
        //     child: Wrap(
        //         spacing: 10.0,
        //         alignment: WrapAlignment.center,
        //         children: ))

        ;
  }
  if (!status) {
    return Center(
      child: CircularProgressIndicator(),
    );
  } else {
    if (model.guidelineList.isEmpty) {
      return Container(
          margin: EdgeInsets.only(top: 10),
          child: Center(child: Text("No guideline in database")));
    }

    return SingleChildScrollView(
        child: buildGuideline(model.guidelineList, model));
  }
}

Widget buildGuideline(list, model) {
  List<Widget> guidelineList = new List.empty(growable: true);
  list.forEach((element) => {
        guidelineList.add(InkWell(
            onTap: () {
              model.viewGuideline(element);
            },
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              width: 300,
              height: 120,
              decoration: BoxDecoration(

                  // Red border with the width is equal to 5
                  border: Border.all(
                width: 1,
                color: Colors.black,
              )),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Container(
                          margin: EdgeInsets.all(2),
                          child: Text("Title: " + element.title),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.all(5),
                          child: Text("Author: " + element.author)),
                    ),
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [],
                          )),
                    )
                  ]),
            )))
      });
  return Center(child: Column(children: guidelineList));
}
