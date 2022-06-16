import 'package:helbage/shared/_shared.dart';
import 'package:helbage/view/admin/Guideline/ViewGuidelineViewModel.dart';
import 'package:stacked/stacked.dart';
class ViewGuidelineView extends StatefulWidget {
  const ViewGuidelineView({Key? key}) : super(key: key);

  @override
  State<ViewGuidelineView> createState() => _ViewGuidelineViewState();
}

class _ViewGuidelineViewState extends State<ViewGuidelineView> {
  String? tag;
  bool _loading=false;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewGuidelineViewModel>.reactive(
      viewModelBuilder: ()=>ViewGuidelineViewModel(), 
      builder: (context,model,child)=>Scaffold(
        appBar: AppBar(
          title:Text("Guidelines"),
          actions: [
            IconButton(
            onPressed: () 
            {
            model.addGuideline();
            },
            icon: Icon(Icons.add)),
            PopupMenuButton(itemBuilder: (BuildContext context) {
                return getGuidelinetag(model.tagList);},
                onSelected: (vale){model.getGuideline(vale);},)
                ],
          ),
        body:Column(children: [
            model.tag == null? Center(): _loading? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Expanded(
                            child:
                                buildBody(model.status, model)),
        ],)
          
        )
      );
  
  }
}

List<PopupMenuItem> getGuidelinetag(tag,{size=15.0})
{
  
  List<PopupMenuItem> tagMenu=new List.empty(growable: true);
  tag.forEach((element) {
    tagMenu.add(
      PopupMenuItem(
        child: InkWell(
          child:Text(
            element.toString(),
            style:TextStyle(fontSize: size)
            )
            ),
        value:element),
        );
  });
  return tagMenu;
}
Widget buildBody(tag, model) {
  if (!tag) {
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
        child: buildSchedule(model.guidelineList, model));
  }
}

Widget buildSchedule(list, model) {
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
                          margin: EdgeInsets.all(5),
                          child: Text("Title: " + element.title),
                        ),
                      ),
                    ),
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
                            children: [
                            ],
                          )),
                    )
                  ]),
            )))
      });
  return Center(child: Column(children: guidelineList));
}